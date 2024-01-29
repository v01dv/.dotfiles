-- https://github.com/pmizio/typescript-tools.nvim

if not require("user.config").pde.typescript then
  return {}
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "javascript", "typescript", "tsx" })
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "typescript-language-server", "js-debug-adapter" })
    end,
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
    opts = {
      tsserver_file_preferences = {
        -- Inlay Hints
        includeInlayParameterNameHints = "all",  -- "none" | "literals" | "all";
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
    config = function(_, opts)
      require("user.plugins.lsp.utils").on_attach(function(client, bufnr)
        if client.name == "tsserver" then
          vim.keymap.set("n", "<leader>lo", "<cmd>TSToolsOrganizeImports<cr>", { buffer = bufnr, desc = "Organize Imports" })
          vim.keymap.set("n", "<leader>lO", "<cmd>TSToolsSortImports<cr>", { buffer = bufnr, desc = "Sort Imports" })
          vim.keymap.set("n", "<leader>lu", "<cmd>TSToolsRemoveUnused<cr>", { buffer = bufnr, desc = "Removed Unused" })
          vim.keymap.set("n", "<leader>lz", "<cmd>TSToolsGoToSourceDefinition<cr>", { buffer = bufnr, desc = "Go To Source Definition" })
          vim.keymap.set("n", "<leader>lR", "<cmd>TSToolsRemoveUnusedImports<cr>", { buffer = bufnr, desc = "Removed Unused Imports" })
          vim.keymap.set("n", "<leader>lF", "<cmd>TSToolsFixAll<cr>", { buffer = bufnr, desc = "Fix All" })
          vim.keymap.set("n", "<leader>lA", "<cmd>TSToolsAddMissingImports<cr>", { buffer = bufnr, desc = "Add Missing Imports" })
        end
      end)
      require("typescript-tools").setup(opts)
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "pmizio/typescript-tools.nvim" },
    opts = {
      -- make sure mason installs the server
      servers = {
        -- ESLint
        eslint = {
          settings = {
            -- helps eslint find the eslintrc when it's placed in a subfolder instead of the cwd root
            workingDirectory = { mode = "auto" },
          },
        },
      },
      setup = {
        eslint = function()
          vim.api.nvim_create_autocmd("BufWritePre", {
            callback = function(event)
              local client = vim.lsp.get_active_clients({ bufnr = event.buf, name = "eslint" })[1]
              if client then
                local diag = vim.diagnostic.get(event.buf, { namespace = vim.lsp.diagnostic.get_namespace(client.id) })
                if #diag > 0 then
                  vim.cmd "EslintFixAll"
                end
              end
            end,
          })
        end,
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    opts = {
      setup = {
        vscode_js_debug = function()
          local function get_js_debug()
            local install_path = require("mason-registry").get_package("js-debug-adapter"):get_install_path()
            return install_path .. "/js-debug/src/dapDebugServer.js"
          end

          -- Neovim needs a debug adapter with which it can communicate. Neovim can either
          -- launch the debug adapter itself, or it can attach to an existing one.
          -- To tell Neovim if it should launch a debug adapter or connect to one, and if
          -- so, how, you need to configure them via the `dap.adapters` table.
          for _, adapter in ipairs { "pwa-node", "pwa-chrome", "pwa-msedge", "firefox", "node-terminal", "pwa-extensionHost" } do
            require("dap").adapters[adapter] = {
              type = "server",
              host = "localhost",
              port = "${port}",
              executable = {
                command = "node",
                args = {
                  get_js_debug(),
                  "${port}",
                },
              },
            }
          end

          -- In addition to launching (possibly) and connecting to a debug adapter, Neovim
          -- needs to instruct the adapter itself how to launch and connect to the program
          -- that you are trying to debug (the debugee).
          -- local js_based_languages = {
          --   "typescript",
          --   "javascript",
          --   "typescriptreact",
          --   "javascriptreact",
          --   "vue",
          -- }

          -- See here for all custom configuration options:
          -- https://github.com/microsoft/vscode-js-debug/blob/main/OPTIONS.md
          for _, language in ipairs { "typescript", "javascript" } do
            require("dap").configurations[language] = {
              -- Debug single nodejs files
              {
                type = "pwa-node",
                request = "launch",
                name = "Launch file",
                program = "${file}",
                cwd = "${workspaceFolder}",
              },
              -- Help you debug node processes like express applications
              -- (make sure to add --inspect when you run the process)
              {
                type = "pwa-node",
                request = "attach",
                name = "Attach to process",
                processId = require("dap.utils").pick_process,
                cwd = "${workspaceFolder}",
                -- sourceMaps = true,
              },
              {
                type = "pwa-node",
                request = "launch",
                name = "Debug Jest Tests",
                -- trace = true, -- include debugger info
                runtimeExecutable = "node",
                runtimeArgs = {
                  "./node_modules/jest/bin/jest.js",
                  "--runInBand",
                },
                rootPath = "${workspaceFolder}",
                cwd = "${workspaceFolder}",
                console = "integratedTerminal",
                internalConsoleOptions = "neverOpen",
              },
              {
                type = "pwa-chrome",
                name = "Attach - Remote Debugging",
                request = "attach",
                program = "${file}",
                cwd = vim.fn.getcwd(),
                sourceMaps = true,
                protocol = "inspector",
                port = 9222, -- Start Chrome google-chrome --remote-debugging-port=9222
                webRoot = "${workspaceFolder}",
              },
              -- Debug web applications (client side)
              --   The line userDataDir will let you save your Chrome profile in a file
              {
                type = "pwa-chrome",
                name = "Launch & Debug Chrome with \"localhost\"",
                request = "launch",
                url = "http://localhost:5173", -- This is for Vite. Change it to the framework you use
                webRoot = "${workspaceFolder}",
                userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir",
              },
              -- FIX: Doesn't work. Need further investigation.
              {
                type = 'firefox',
                name = 'Debug with Firefox',
                request = 'launch',
                reAttach = true,
                url = 'http://localhost:5000',
                webRoot = '${workspaceFolder}',
                firefoxExecutable = '/usr/bin/firefox'
              },
            }
          end

          for _, language in ipairs { "typescriptreact", "javascriptreact" } do
            require("dap").configurations[language] = {
              {
                type = "pwa-chrome",
                name = "Attach - Remote Debugging",
                request = "attach",
                program = "${file}",
                cwd = vim.fn.getcwd(),
                sourceMaps = true,
                protocol = "inspector",
                port = 9222, -- Start Chrome google-chrome --remote-debugging-port=9222
                webRoot = "${workspaceFolder}",
              },
              {
                type = "pwa-chrome",
                name = "Launch Chrome",
                request = "launch",
                url = "http://localhost:5173", -- This is for Vite. Change it to the framework you use
                webRoot = "${workspaceFolder}",
                userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir",
              },
            }
          end
        end,
      },
    },
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-jest",
      "marilari88/neotest-vitest",
      "thenbe/neotest-playwright",
    },
    opts = function(_, opts)
      vim.list_extend(opts.adapters, {
        require "neotest-jest",
        require "neotest-vitest",
        require("neotest-playwright").adapter {
          options = {
            persist_project_selection = true,
            enable_dynamic_test_discovery = true,
          },
        },
      })
    end,
  },
}
