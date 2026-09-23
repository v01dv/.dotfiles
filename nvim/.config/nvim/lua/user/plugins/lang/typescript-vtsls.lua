-- https://github.com/pmizio/typescript-tools.nvim

if not require('user.config').pde.typescript then
  return {}
end

return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      ensure_installed = {
        'javascript',
        'typescript',
        'tsx',
        'jsdoc',
      },
    },
  },

  -- Add servers and formatters
  {
    'mason-org/mason.nvim',
    opts = {
      ensure_installed = {
        'vtsls',
        'eslint_d',
        'prettierd',
        'js-debug-adapter',
      },
    },
  },
  -- Linters & formatters
  {
    'mfussenegger/nvim-lint',
    opts = {
      linters_by_ft = {
        -- javascript = { 'eslint_d' },
        -- typescript = { 'eslint_d' },
        typescript = { 'eslint_d' },
        javascript = { 'eslint_d' },
        typescriptreact = { 'eslint_d' },
        javascriptreact = { 'eslint_d' },
      },
    },
  },
  {
    'stevearc/conform.nvim',
    optional = true,
    opts = {
      formatters_by_ft = {
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        typescript = { 'prettierd', 'prettier', stop_after_first = true },
        javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
      },
      formatters = {},
    },
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        vtsls = {
          -- explicitly add default filetypes, so that we can extend
          -- them in related extras
          filetypes = {
            'javascript',
            'javascriptreact',
            'javascript.jsx',
            'typescript',
            'typescriptreact',
            'typescript.tsx',
          },
          settings = {
            complete_function_calls = true,
            vtsls = {
              enableMoveToFileCodeAction = true,
              autoUseWorkspaceTsdk = true,
              experimental = {
                maxInlayHintLength = 30,
                completion = {
                  enableServerSideFuzzyMatch = true,
                },
              },
            },
            typescript = {
              updateImportsOnFileMove = { enabled = 'always' },
              suggest = {
                completeFunctionCalls = true,
              },
              inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                parameterNames = { enabled = 'literals' },
                parameterTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = false },
              },
            },
          },
          on_attach = function(client, bufnr)
            vim.keymap.set('n', 'gD', function()
              local params = vim.lsp.util.make_position_params()
              OhVim.lsp.execute {
                command = 'typescript.goToSourceDefinition',
                arguments = { params.textDocument.uri, params.position },
                open = true,
              }
            end, { buffer = bufnr, desc = 'Goto Source Definition' })

            vim.keymap.set('n', 'gR', function()
              OhVim.lsp.execute {
                command = 'typescript.findAllFileReferences',
                arguments = { vim.uri_from_bufnr(0) },
                open = true,
              }
            end, { buffer = bufnr, desc = 'File References' })

            vim.keymap.set('n', '<leader>co', OhVim.lsp.action['source.organizeImports'], { buffer = bufnr, desc = 'Sorts and removes unused imports' })
            vim.keymap.set('n', '<leader>cM', OhVim.lsp.action['source.addMissingImports.ts'], { buffer = bufnr, desc = 'Add missing imports' })
            vim.keymap.set('n', '<leader>cu', OhVim.lsp.action['source.removeUnused.ts'], { buffer = bufnr, desc = 'Remove unused imports' })
            vim.keymap.set('n', '<leader>cD', OhVim.lsp.action['source.fixAll.ts'], { buffer = bufnr, desc = 'Fix all diagnostics' })
            vim.keymap.set('n', '<leader>cV', function()
              OhVim.lsp.execute { command = 'typescript.selectTypeScriptVersion' }
            end, { buffer = bufnr, desc = 'Select TS workspace version' })
          end,
        },

        setup = {
          --- @deprecated -- tsserver renamed to ts_ls but not yet released, so keep this for now
          --- the proper approach is to check the nvim-lspconfig release version when it's released to determine the server name dynamically
          tsserver = function()
            -- disable tsserver
            return true
          end,
          ts_ls = function()
            -- disable tsserver
            return true
          end,
          vtsls = function(_, opts)
            if vim.lsp.config.denols and vim.lsp.config.vtsls then
              ---@param server string
              local resolve = function(server)
                local markers, root_dir = vim.lsp.config[server].root_markers, vim.lsp.config[server].root_dir
                vim.lsp.config(server, {
                  root_dir = function(bufnr, on_dir)
                    local is_deno = vim.fs.root(bufnr, { 'deno.json', 'deno.jsonc' }) ~= nil
                    if is_deno == (server == 'denols') then
                      if root_dir then
                        return root_dir(bufnr, on_dir)
                      elseif type(markers) == 'table' then
                        local root = vim.fs.root(bufnr, markers)
                        return root and on_dir(root)
                      end
                    end
                  end,
                })
              end
              resolve 'denols'
              resolve 'vtsls'
            end
            -- ISSUE: I don't understand why I don't see the result of the print(2) command
            print(2)
            OhVim.lsp.on_attach(function(client, buffer)
              print(3)
              client.commands['_typescript.moveToFileRefactoring'] = function(command, ctx)
                ---@type string, string, lsp.Range
                local action, uri, range = unpack(command.arguments)

                local function move(newf)
                  client:request('workspace/executeCommand', {
                    command = command.command,
                    arguments = { action, uri, range, newf },
                  })
                end

                local fname = vim.uri_to_fname(uri)
                client:request('workspace/executeCommand', {
                  command = 'typescript.tsserverRequest',
                  arguments = {
                    'getMoveToRefactoringFileSuggestions',
                    {
                      file = fname,
                      startLine = range.start.line + 1,
                      startOffset = range.start.character + 1,
                      endLine = range['end'].line + 1,
                      endOffset = range['end'].character + 1,
                    },
                  },
                }, function(_, result)
                  ---@type string[]
                  local files = result.body.files
                  table.insert(files, 1, 'Enter new path...')
                  vim.ui.select(files, {
                    prompt = 'Select move destination:',
                    format_item = function(f)
                      return vim.fn.fnamemodify(f, ':~:.')
                    end,
                  }, function(f)
                    if f and f:find '^Enter new path' then
                      vim.ui.input({
                        prompt = 'Enter move destination:',
                        default = vim.fn.fnamemodify(fname, ':h') .. '/',
                        completion = 'file',
                      }, function(newf)
                        return newf and move(newf)
                      end)
                    elseif f then
                      move(f)
                    end
                  end)
                end)
              end
            end, 'vtsls')
            -- copy typescript settings to javascript
            opts.settings.javascript = vim.tbl_deep_extend('force', {}, opts.settings.typescript, opts.settings.javascript or {})
          end,
        },
      },
    },
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
