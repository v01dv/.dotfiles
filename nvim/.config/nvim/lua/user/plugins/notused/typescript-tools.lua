-- https://github.com/pmizio/typescript-tools.nvim

if not require('user.config').pde.typescript then
  return {}
end

return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      OhVim.list_insert_unique(opts.ensure_installed, {
        'javascript',
        'typescript',
        'tsx',
        'jsdoc',
      })
    end,
  },

  -- Add servers and formatters
  {
    'mason-org/mason.nvim',
    opts = {
      ensure_installed = {
        'prettierd',
        'js-debug-adapter',
        -- 'emmet_language_server',
      },
    },
  },
  -- Linters & formatters
  {
    'stevearc/conform.nvim',
    optional = true,
    opts = {
      formatters_by_ft = {
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        typescript = { 'prettierd', 'prettier', stop_after_first = true },
        javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        -- json = { 'prettierd', 'prettier', stop_after_first = true },
        -- graphql = { 'prettierd', 'prettier', stop_after_first = true },
      },
      formatters = {
        -- https://github.com/folke/dot/blob/master/nvim/lua/plugins/lsp.lua
        -- dprint = {
        --   condition = function(_, ctx)
        --     return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
        --   end,
        -- },
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        -- NOTE: Choose either typescript-language-server (ts_ls) or typescript-tools.
        -- Otherwise you will observe a duplicate results into reporting diagnostics from
        -- these two servers simultaneously.
        -- ts_ls = {},
        emmet_language_server = {
          init_options = {
            syntaxProfiles = {
              filters = 'bem',
            },
          },
        },
        eslint = {
          settings = {
            -- helps eslint find the eslintrc when it's placed in a subfolder instead of the cwd root
            experimental = {
              useFlatConfig = true,
            },
            -- helps eslint find the eslintrc when it's placed in a subfolder instead of the cwd root
            workingDirectory = { mode = 'auto' },
          },
          on_attach = function(client, bufnr)
            client.server_capabilities.documentFormattingProvider = true
            client.server_capabilities.documentRangeFormattingProvider = true

            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = bufnr,
              command = 'LspEslintFixAll',
            })
          end,
        },
      },
    },
  },
  -- Native TSServer client
  {
    'pmizio/typescript-tools.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
      'nvim-lua/plenary.nvim',
      { 'folke/neoconf.nvim', cmd = 'Neoconf', config = true },
    },
    ft = {
      'javascript',
      'javascriptreact',
      'javascript.jsx',
      'typescript',
      'typescriptreact',
      'typescript.tsx',
    },
    opts = {
      on_attach = function(client, bufnr)
        vim.keymap.set('n', '<leader>lo', '<cmd>TSToolsOrganizeImports<cr>', { buffer = bufnr, desc = 'Sorts and removes unused imports' })
        vim.keymap.set('n', '<leader>lO', '<cmd>TSToolsSortImports<cr>', { buffer = bufnr, desc = 'Sort Imports' })
        vim.keymap.set('n', '<leader>lR', '<cmd>TSToolsRemoveUnusedImports<cr>', { buffer = bufnr, desc = 'Removed unused imports' })
        vim.keymap.set('n', '<leader>lu', '<cmd>TSToolsRemoveUnused<cr>', { buffer = bufnr, desc = 'Removes all unused statements' })
        vim.keymap.set('n', '<leader>lA', '<cmd>TSToolsAddMissingImports<cr>', { buffer = bufnr, desc = 'Add missing imports' })
        vim.keymap.set('n', '<leader>lF', '<cmd>Fixes all fixable errors (TSToolsFixAll)<cr>', { buffer = bufnr, desc = 'Fix All' })
        vim.keymap.set('n', '<leader>lz', '<cmd>TSToolsGoToSourceDefinition<cr>', { buffer = bufnr, desc = 'Go to source definition' })
        vim.keymap.set('n', '<leader>lr', '<cmd>TSToolsRenameFile<cr>', { buffer = bufnr, desc = 'Rename current file and apply changes to connected files' })
        vim.keymap.set('n', '<leader>lfr', '<cmd>TSToolsFileReferences<cr>', { buffer = bufnr, desc = 'Find files that reference the current file' })
      end,
      settings = {
        -- handlers = {
        --   ["textDocument/publishDiagnostics"] = require("typescript-tools.api").filter_diagnostics(
        --     -- Ignore 'This may be converted to an async function' diagnostics.
        --     { 80001 }
        --   ),
        -- },
        tsserver_file_preferences = {
          -- Inlay Hints
          includeInlayParameterNameHints = 'all', -- "none" | "literals" | "all";
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayVariableTypeHintsWhenTypeMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
          -- To disable: [js] File is a CommonJS module; it may be converted to an ES6 module. [80001]
          -- Details: https://stackoverflow.com/a/76955526
          -- disableSuggestions = true,
        },
      },
    },
    config = function(_, opts)
      require('typescript-tools').setup(opts)
    end,
  },

  -- Testing
  {
    'nvim-neotest/neotest',
    -- BUG: Because of issues:
    --  https://github.com/nvim-neotest/neotest-jest/issues/165
    --  https://github.com/nvim-neotest/neotest/issues/531
    commit = '52fca6717ef972113ddd6ca223e30ad0abb2800c',
    dependencies = {
      'nvim-neotest/neotest-jest',
      -- 'marilari88/neotest-vitest',
      -- 'thenbe/neotest-playwright',
    },
    opts = {
      adapters = {
        ['neotest-jest'] = {
          -- jestCommand = 'npm test --',
          -- jestArguments = function(defaultArguments, context)
          --   return defaultArguments
          -- end,
          -- jestConfigFile = 'custom.jest.config.ts',
          -- env = { CI = true },
          -- cwd = function(path)
          --   return vim.fn.getcwd()
          -- end,
          -- isTestFile = require('neotest-jest.jest-util').defaultIsTestFile,
        },
      },
    },
  },

  -- {
  --   "williamboman/mason.nvim",
  --   -- version = "1.11.0",
  --   build = ":MasonUpdate",
  --   cmd = "Mason",
  --   opts = {
  --     ui = {
  --         border = "rounded",
  --     },
  --     ensure_installed = {
  --       "shfmt",
  --     },
  --   },
  --   config = function(_, opts)
  --     require("mason").setup(opts)
  --     local mr = require "mason-registry"
  --     local function ensure_installed()
  --       for _, tool in ipairs(opts.ensure_installed) do
  --         local p = mr.get_package(tool)
  --         if not p:is_installed() then
  --           p:install()
  --         end
  --       end
  --     end
  --     if mr.refresh then
  --       mr.refresh(ensure_installed)
  --     else
  --       ensure_installed()
  --     end
  --   end,
  -- },

  -- Linters & formatters
  -- {
  --   'WhoIsSethDaniel/mason-tool-installer.nvim',
  --   opts = function(_, opts)
  --     -- NOTE: Removed typescript-language-server because I have got duplicate results into reporting
  --     -- diagnostics from tsserver and typescript. I didn't find the reason, but removed that helped.
  --     -- vim.list_extend(opts.ensure_installed, { "typescript-language-server", "js-debug-adapter" })
  --     opts.ensure_installed = opts.ensure_installed or {}
  --     -- ensure_installed = { "js-debug-adapter" }
  --     vim.list_extend(opts.ensure_installed, { 'js-debug-adapter', 'prettierd', 'emmet_language_server' })
  --     print('TS:' .. vim.inspect(opts.ensure_installed))
  --   end,
  -- },

  -- Debugging
  -- {
  --  "mfussenegger/nvim-dap",
  --  opts = {
  --    setup = {
  --      vscode_js_debug = function()
  --        local function get_js_debug()
  --          -- https://github.com/mason-org/mason.nvim/blob/main/CHANGELOG.md#packageget_install_path-has-been-removed
  --          -- local install_path = require("mason-registry").get_package("js-debug-adapter"):get_install_path()
  --          local install_path = vim.fn.exepath("js-debug-adapter")
  --          return install_path
  --          -- return install_path .. "/js-debug/src/dapDebugServer.js"
  --        end
  --
  --        -- Neovim needs a debug adapter with which it can communicate. Neovim can either
  --        -- launch the debug adapter itself, or it can attach to an existing one.
  --        -- To tell Neovim if it should launch a debug adapter or connect to one, and if
  --        -- so, how, you need to configure them via the `dap.adapters` table.
  --        for _, adapter in ipairs({
  --          "pwa-node",
  --          "pwa-chrome",
  --          "pwa-msedge",
  --          "firefox",
  --          "node-terminal",
  --          "pwa-extensionHost",
  --        }) do
  --          require("dap").adapters[adapter] = {
  --            type = "server",
  --            host = "localhost",
  --            port = "${port}",
  --            executable = {
  --              command = "node",
  --              args = {
  --                get_js_debug(),
  --                "${port}",
  --              },
  --            },
  --          }
  --        end
  --
  --        -- In addition to launching (possibly) and connecting to a debug adapter, Neovim
  --        -- needs to instruct the adapter itself how to launch and connect to the program
  --        -- that you are trying to debug (the debugee).
  --        -- local js_based_languages = {
  --        --   "typescript",
  --        --   "javascript",
  --        --   "typescriptreact",
  --        --   "javascriptreact",
  --        --   "vue",
  --        -- }
  --
  --        -- See here for all custom configuration options:
  --        -- https://github.com/microsoft/vscode-js-debug/blob/main/OPTIONS.md
  --        for _, language in ipairs({ "typescript", "javascript" }) do
  --          require("dap").configurations[language] = {
  --            -- Debug single nodejs files
  --            {
  --              type = "pwa-node",
  --              request = "launch",
  --              name = "Launch file",
  --              program = "${file}",
  --              cwd = "${workspaceFolder}",
  --            },
  --            -- Help you debug node processes like express applications
  --            -- (make sure to add --inspect when you run the process)
  --            {
  --              type = "pwa-node",
  --              request = "attach",
  --              name = "Attach to process",
  --              processId = require("dap.utils").pick_process,
  --              cwd = "${workspaceFolder}",
  --              -- sourceMaps = true,
  --            },
  --            {
  --              type = "pwa-node",
  --              request = "launch",
  --              name = "Debug Jest Tests",
  --              -- trace = true, -- include debugger info
  --              runtimeExecutable = "node",
  --              runtimeArgs = {
  --                "./node_modules/jest/bin/jest.js",
  --                "--runInBand",
  --              },
  --              rootPath = "${workspaceFolder}",
  --              cwd = "${workspaceFolder}",
  --              console = "integratedTerminal",
  --              internalConsoleOptions = "neverOpen",
  --            },
  --            {
  --              type = "pwa-chrome",
  --              name = "Attach - Remote Debugging",
  --              request = "attach",
  --              program = "${file}",
  --              cwd = vim.fn.getcwd(),
  --              sourceMaps = true,
  --              protocol = "inspector",
  --              port = 9222, -- Start Chrome google-chrome --remote-debugging-port=9222
  --              webRoot = "${workspaceFolder}",
  --            },
  --            -- Debug web applications (client side)
  --            --   The line userDataDir will let you save your Chrome profile in a file
  --            {
  --              type = "pwa-chrome",
  --              name = 'Launch & Debug Chrome with "localhost"',
  --              request = "launch",
  --              url = "http://localhost:5173", -- This is for Vite. Change it to the framework you use
  --              webRoot = "${workspaceFolder}",
  --              userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir",
  --            },
  --            -- FIX: Doesn't work. Need further investigation.
  --            {
  --              type = "firefox",
  --              name = "Debug with Firefox",
  --              request = "launch",
  --              reAttach = true,
  --              url = "http://localhost:5000",
  --              webRoot = "${workspaceFolder}",
  --              firefoxExecutable = "/usr/bin/firefox",
  --            },
  --          }
  --        end
  --
  --        for _, language in ipairs({ "typescriptreact", "javascriptreact" }) do
  --          require("dap").configurations[language] = {
  --            {
  --              type = "pwa-chrome",
  --              name = "Attach - Remote Debugging",
  --              request = "attach",
  --              program = "${file}",
  --              cwd = vim.fn.getcwd(),
  --              sourceMaps = true,
  --              protocol = "inspector",
  --              port = 9222, -- Start Chrome google-chrome --remote-debugging-port=9222
  --              webRoot = "${workspaceFolder}",
  --            },
  --            {
  --              type = "pwa-chrome",
  --              name = "Launch Chrome",
  --              request = "launch",
  --              url = "http://localhost:5173", -- This is for Vite. Change it to the framework you use
  --              webRoot = "${workspaceFolder}",
  --              userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir",
  --            },
  --          }
  --        end
  --      end,
  --    },
  --  },
  -- },
}
