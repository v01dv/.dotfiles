-- Source: https://www.lazyvim.org/extras/lang/clangd
if not require('user.config').pde.cpp then
  return {}
end

return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { 'c', 'cpp' })
    end,
  },
  {
    'williamboman/mason.nvim',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { 'codelldb', 'cortex-debug' })
    end,
  },
  {
    'stevearc/overseer.nvim',
    opts = {
      dap = true,
    },
  },
  {
    'p00f/clangd_extensions.nvim',
    ft = { 'c', 'cpp', 'objc', 'objcpp' },
    opts = {
      inlay_hints = {
        inline = false,
      },
      ast = {
        --These require codicons (https://github.com/microsoft/vscode-codicons)
        role_icons = {
          type = '',
          declaration = '',
          expression = '',
          specifier = '',
          statement = '',
          ['template argument'] = '',
        },
        kind_icons = {
          Compound = '',
          Recovery = '',
          TranslationUnit = '',
          PackExpansion = '',
          TemplateTypeParm = '',
          TemplateTemplateParm = '',
          TemplateParamObject = '',
        },
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        clangd = {
          -- root_dir = function(...)
          --   -- using a root .clang-format or .clang-tidy file messes up projects, so remove them
          --   return require('lspconfig.util').root_pattern('compile_commands.json', 'compile_flags.txt', 'configure.ac', '.git')(...)
          -- end,
          root_markers = {
            'compile_commands.json',
            'compile_flags.txt',
            'configure.ac', -- AutoTools
            'Makefile',
            'configure.ac',
            'configure.in',
            'config.h.in',
            'meson.build',
            'meson_options.txt',
            'build.ninja',
            '.git',
            'CMakeLists.txt',
            'CMakePresets.json',
          },
          capabilities = {
            offsetEncoding = { 'utf-16' },
          },
          cmd = {
            'clangd',
            '--background-index',
            '--clang-tidy',
            '--header-insertion=iwyu',
            '--completion-style=detailed',
            '--function-arg-placeholders',
            '--fallback-style=llvm',
          },
          init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            clangdFileStatus = true,
          },
          on_new_config = function(new_config, new_cwd)
            local status, cmake = pcall(require, 'cmake-tools')
            if status then
              cmake.clangd_on_new_config(new_config)
            end
          end,
          OhVim.lsp.on_attach(function(client, buffer)
            vim.keymap.set('n', '<leader>ch', '<cmd>LspClangdSwitchSourceHeader<cr>', { buffer = bufnr, desc = 'Switch Source/Header (C/C++)' })
          end, 'clangd'),
        },
      },
    },
  },

  {
    'jedrzejboczar/nvim-dap-cortex-debug',
    ft = { 'c', 'cpp', 'objc', 'objcpp' },
    opts = {
      debug = false, -- log debug messages
      -- path to cortex-debug extension, supports vim.fn.glob
      -- by default tries to guess: mason.nvim or VSCode extensions
      extension_path = nil,
      lib_extension = nil, -- shared libraries extension, tries auto-detecting, e.g. 'so' on unix
      node_path = 'node', -- path to node.js executable
      dapui_rtt = true, -- register nvim-dap-ui RTT element
      -- make :DapLoadLaunchJSON register cortex-debug for C/C++, set false to disable
      dap_vscode_filetypes = { 'c', 'cpp', 'rust', 'zig' },
      rtt = {
        buftype = 'Terminal', -- 'Terminal' or 'BufTerminal' for terminal buffer vs normal buffer
      },
    },
  },
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'jedrzejboczar/nvim-dap-cortex-debug',
    },
    opts = function()
      local dap = require 'dap'

      if not dap.adapters['codelldb'] then
        require('dap').adapters['codelldb'] = {
          type = 'server',
          host = 'localhost',
          port = '${port}',
          executable = {
            command = 'codelldb',
            args = {
              '--port',
              '${port}',
            },
          },
        }
      end
      for _, lang in ipairs { 'c', 'cpp' } do
        dap.configurations[lang] = {
          {
            name = 'STM32 with OpenOCD',
            type = 'cortex-debug',
            request = 'launch',
            servertype = 'openocd',
            serverpath = 'openocd',
            gdbPath = '/opt/stm32cubeclt/GNU-tools-for-STM32/bin/arm-none-eabi-gdb',
            toolchainPath = '/opt/stm32cubeclt/GNU-tools-for-STM32/bin/',
            toolchainPrefix = 'arm-none-eabi',
            runToEntryPoint = 'main',
            swoConfig = { enabled = false },
            showDevDebugOutput = false,
            -- showDevDebugOutput = 'raw', -- To see verbose GDB transactions here. Very helpful to debug issues or report problems
            gdbTarget = 'localhost:3333',
            -- NUCLEO-F030R8 --> STM32F030R8T6 (Cortex-M0).
            device = 'STM32F030R8T6',
            svdFile = '/opt/stm32cubeclt/STMicroelectronics_CMSIS_SVD/STM32F0x8.svd',
            -- cwd = '${workspaceFolder}',
            -- cwd = '${workspaceRoot}',
            cwd = vim.fs.root(0, {
              'CMakePresets.json',
              'CMakeLists.txt',
            }),
            -- executable = '${workspaceFolder}/build/Debug',
            executable = require('cmake-tools').get_launch_target_path(),

            -- executable = function()
            --   local cwd = vim.fn.getcwd()
            --   local files = vim.fn.glob(cwd .. '/build/Debug/*.elf', false, true)
            --
            --   if #files == 0 then
            --     vim.notify('ELF not found in build/', vim.log.levels.ERROR)
            --     return nil
            --   end
            --
            --   return files[1]
            -- end,
            -- executable = function()
            --   return vim.fn.input('Path to .elf file: ', vim.fn.getcwd() .. '/build/', 'file')
            --   -- return vim.fn.input('Path to ELF: ', vim.fn.getcwd() .. '/', 'file')
            -- end,
            -- configfiles = { '${workspacefolder}/build/openocd/connect.cfg' },
            -- NUCLEO-F030R8 --> STM32F030R8T6 (Cortex-M0).
            configFiles = {
              'interface/stlink.cfg',
              'target/stm32f0x.cfg',
            },
            -- configfiles = { '${workspaceFolder}/openocd.cfg' },
            preLaunchTask = 'Build Project',
            overrideLaunchCommands = {
              -- 'cd Output/build',
              -- 'file firmware.hex',
              -- 'target extended-remote localhost:50000',
              -- 'monitor reset halt',
              -- 'load firmware.hex',
              -- "set output-radix 16"
            },
            rttConfig = {
              address = 'auto',
              decoders = {
                {
                  label = 'RTT:0',
                  port = 0,
                  type = 'console',
                },
              },
              enabled = true,
            },
          },

          {
            -- Reference: https://github.com/Marus/cortex-debug/wiki/ST-Link-(st-util)-Specific-Configuration
            name = 'Debug (ST-Util)',
            type = 'cortex-debug',
            request = 'launch',
            servertype = 'stutil',
            -- NUCLEO-F030R8 --> STM32F030R8T6 (Cortex-M0).
            device = 'STM32F030R8T6',
            cwd = vim.fs.root(0, {
              'CMakePresets.json',
              'CMakeLists.txt',
            }),
            preLaunchTask = 'Build Project',
            -- cwd = '${workspaceRoot}',
            showDevDebugOutput = false,
            -- showDevDebugOutput = 'raw', -- To see verbose GDB transactions here. Very helpful to debug issues or report problems
            executable = require('cmake-tools').get_launch_target_path(),
            -- If you are using an older ST-Link V2 (for example the ST-Link
            -- that is embedded in the STM32 Value Line Discovery board), you
            -- need to specify "v1": true in the launch configuration.
            v1 = 'false',
          },

          {
            -- Reference: https://github.com/Marus/cortex-debug/wiki/STM32CubeCLT-Specific-Configuration-(using-ST%E2%80%90Link)
            name = 'Debug w/ ST-Link',
            type = 'cortex-debug',
            request = 'launch',
            interface = 'swd',
            servertype = 'stlink',
            serverpath = 'ST-LINK_gdbserver',
            -- NUCLEO-F030R8 --> STM32F030R8T6 (Cortex-M0).
            device = 'STM32F030R8T6',
            halt = false,
            stm32cubeprogrammer = '/opt/stm32cubeclt/STM32CubeProgrammer/bin/',
            gdbPath = '/opt/stm32cubeclt/GNU-tools-for-STM32/bin/arm-none-eabi-gdb',
            toolchainPath = '/opt/stm32cubeclt/GNU-tools-for-STM32/bin/',
            serverArgs = {},
            -- serverArgs = {
            --   '-m',
            --   '1',
            -- },
            toolchainPrefix = 'arm-none-eabi',
            runToEntryPoint = 'main',
            swoConfig = { enabled = false },
            showDevDebugOutput = false,
            -- showDevDebugOutput = 'raw', -- To see verbose GDB transactions here. Very helpful to debug issues or report problems
            -- gdbTarget = 'localhost:3333',
            svdFile = '/opt/stm32cubeclt/STMicroelectronics_CMSIS_SVD/STM32F0x8.svd',
            -- cwd = '${workspaceFolder}',
            -- cwd = '${workspaceRoot}',
            cwd = vim.fs.root(0, {
              'CMakePresets.json',
              'CMakeLists.txt',
            }),
            -- executable = '${workspaceFolder}/build/Debug',
            executable = require('cmake-tools').get_launch_target_path(),

            preLaunchTask = 'Build Project',
            -- preLaunchTask = 'Flash Project',
            rttConfig = {
              address = 'auto',
              decoders = {
                {
                  label = 'RTT:0',
                  port = 0,
                  type = 'console',
                },
              },
              enabled = true,
            },
          },

          {
            type = 'codelldb',
            request = 'launch',
            name = 'Launch file',
            program = function()
              return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            cwd = '${workspaceFolder}',
          },
          {
            type = 'codelldb',
            request = 'attach',
            name = 'Attach to process',
            pid = require('dap.utils').pick_process,
            cwd = '${workspaceFolder}',
          },
        }
      end
    end,
  },
  {
    'nvim-neotest/neotest',
    dependencies = {
      { 'alfaix/neotest-gtest', opts = {} },
    },
    opts = function(_, opts)
      vim.list_extend(opts.adapters, {
        require 'neotest-test',
      })
    end,
  },
}
