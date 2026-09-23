-- Source: https://www.lazyvim.org/extras/lang/cmake

if not require('user.config').pde.cmake then
  return {}
end

return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      OhVim.list_insert_unique(opts.ensure_installed, {
        'cmake',
      })
    end,
  },
  -- Add servers and formatters
  {
    'mason-org/mason.nvim',
    opts = {
      ensure_installed = {
        'cmakelang',
        'cmakelint',
      },
    },
  },
  -- Linters & formatters
  {
    'mfussenegger/nvim-lint',
    opts = {
      linters_by_ft = {
        cmake = { 'cmakelint' },
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        neomake = {},
      },
    },
  },
  {
    'Civitasv/cmake-tools.nvim',
    lazy = true,
    init = function()
      local loaded = false
      local function check()
        local cwd = vim.uv.cwd()
        if vim.fn.filereadable(cwd .. '/CMakeLists.txt') == 1 then
          require('lazy').load { plugins = { 'cmake-tools.nvim' } }
          loaded = true
        end
      end
      check()
      vim.api.nvim_create_autocmd('DirChanged', {
        callback = function()
          if not loaded then
            check()
          end
        end,
      })
    end,
    opts = {
      -- cmake_executor = { name = 'overseer', opts = {} },
      cmake_executor = { name = 'terminal' },
      cmake_virtual_text_support = false, -- Show the target related to current file using virtual text (at right corner)
      cmake_compile_commands_options = {
        action = 'none',
      },
      cmake_dap_configuration = { -- debug settings for cmake
        name = 'c',
        type = 'cortex-debug',
        servertype = 'openocd',
        executable = function()
          return require('cmake-tools').get_launch_target_path()
        end,
        configFiles = {
          'interface/stlink.cfg',
          'target/stm32f0x.cfg',
        },
        -- type = 'codelldb',
        request = 'launch',
        stopOnEntry = false,
        runInTerminal = true,
        console = 'integratedTerminal',
      },
    },
  },
}
