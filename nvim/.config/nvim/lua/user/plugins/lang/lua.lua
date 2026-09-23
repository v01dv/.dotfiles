-- Source: https://github.com/alpha2phi/modern-neovim/blob/main/lua/pde/lua.lua

if not require('user.config').pde.lua then
  return {}
end

return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      OhVim.list_insert_unique(opts.ensure_installed, {
        'lua',
        'luadoc',
        'luap',
      })
    end,
  },
  -- Add servers and formatters
  {
    'mason-org/mason.nvim',
    opts = {
      ensure_installed = {
        'selene',
        'lua-language-server',
      },
    },
  },
  -- Linters & formatters
  {
    'mfussenegger/nvim-lint',
    opts = {
      linters_by_ft = {
        -- lua = { 'selene', 'luacheck' },
        -- lua = { 'selene' },
      },

      linters = {
        selene = {
          -- `condition` is another LazyVim extension that allows you to
          -- dynamically enable/disable linters based on the context.
          condition = function(ctx)
            return vim.fs.find({ 'selene.toml' }, { path = ctx.filename, upward = true })[1]
          end,
        },
        luacheck = {
          -- `condition` is another LazyVim extension that allows you to
          -- dynamically enable/disable linters based on the context.
          condition = function(ctx)
            return vim.fs.find({ '.luacheckrc' }, { path = ctx.filename, upward = true })[1]
          end,
        },
      },
    },
  },
  {
    'stevearc/conform.nvim',
    optional = true,
    opts = {
      formatters_by_ft = {
        lua = { 'stylua' },
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        lua_ls = {
          -- https://luals.github.io/wiki/settings/
          -- Current config based on https://github.com/folke/dot/blob/master/nvim/lua/plugins/lsp.lua
          settings = {
            Lua = {
              format = {
                enable = false,
                enable = true,
                -- Put format options here
                -- NOTE: the value should be STRING!!
                defaultConfig = {
                  indent_style = 'space',
                  indent_size = '2',
                  continuation_indent_size = '2',
                },
              },
              diagnostics = {
                -- make the language server recognize "vim" global
                globals = { 'vim' },
                disable = { 'incomplete-signature-doc', 'trailing-space', 'missing-fields' },
              },
              workspace = {
                checkThirdParty = false,
              },
              completion = { callSnippet = 'Replace' },
              misc = {
                parameters = {
                  -- "--log-level=trace",
                },
              },
              hint = {
                enable = true,
                arrayIndex = 'Disable', -- "Enable" | "Auto" | "Disable"
                await = true,
                paramName = 'Disable', -- "All" | "Literal" | "Disable"
                paramType = true,
                semicolon = 'All', -- "All" | "SameLine" | "Disable"
                setType = false,
              },
              telemetry = { enable = false },
            },
          },
          on_attach = function(_, bufnr)
            vim.keymap.set('n', '<leader>dX', function()
              require('osv').run_this()
            end, { buffer = bufnr, desc = 'OSV Run' })
            vim.keymap.set('n', '<leader>dL', function()
              require('osv').launch { port = 8086 }
            end, { buffer = bufnr, desc = 'OSV Launch' })
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
      'nvim-neotest/neotest-plenary',
    },
    opts = {
      adapters = {
        ['neotest-plenary'] = {},
      },
    },
  },
  -- Debugging
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      { 'jbyuki/one-small-step-for-vimkind' },
    },
    opts = {
      setup = {
        osv = function(_, _)
          local dap = require 'dap'
          dap.configurations.lua = {
            {
              type = 'nlua',
              request = 'attach',
              name = 'Attach to running Neovim instance',
              host = function()
                local value = vim.fn.input 'Host [127.0.0.1]: '
                if value ~= '' then
                  return value
                end
                return '127.0.0.1'
              end,
              port = function()
                local val = tonumber(vim.fn.input('Port: ', '8086'))
                assert(val, 'Please provide a port number')
                return val
              end,
            },
          }

          dap.adapters.nlua = function(callback, config)
            callback { type = 'server', host = config.host, port = config.port }
          end
        end,
      },
    },
  },
}
