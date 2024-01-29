-- Source: https://github.com/alpha2phi/modern-neovim/blob/main/lua/pde/lua.lua

if not require("user.config").pde.lua then
  return {}
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "lua", "luadoc", "luap" })
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "stylua" })
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local nls = require "null-ls"
      table.insert(opts.sources, nls.builtins.formatting.stylua)
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        -- provides full signature help, docs, and completion for the Neovim Lua APIs.
        "folke/neodev.nvim",
        opts = {
          library = { plugins = { "neotest", "nvim-dap-ui" }, types = true },
        },
      },
    },
    opts = {
      servers = {
        lua_ls = {
          -- https://luals.github.io/wiki/settings/
          -- Current config based on https://github.com/folke/dot/blob/master/nvim/lua/plugins/lsp.lua
          settings = {
            Lua = {
              format = {
                enable = false,
                defaultConfig = {
                  indent_style = "space",
                  indent_size = "2",
                  continuation_indent_size = "2",
                },
              },
              diagnostics = {
                -- make the language server recognize "vim" global
                globals = { "vim" },
                disable = { "incomplete-signature-doc", "trailing-space", 'missing-fields' },
              },
              workspace = {
                checkThirdParty = false,
              },
              completion = { callSnippet = "Replace" },
              misc = {
                parameters = {
                  -- "--log-level=trace",
                },
              },
              hint = {
                enable = true,
                arrayIndex = "Disable", -- "Enable" | "Auto" | "Disable"
                await = true,
                paramName = "Disable", -- "All" | "Literal" | "Disable"
                paramType = true,
                semicolon = "All", -- "All" | "SameLine" | "Disable"
                setType = false,
              },
              telemetry = { enable = false },
            },
          },
        },
      },
      setup = {
        lua_ls = function(_, _)
          local lsp_utils = require "user.plugins.lsp.utils"
          lsp_utils.on_attach(function(client, buffer)
            -- stylua: ignore
            if client.name == "lua_ls" then
              vim.keymap.set("n", "<leader>dX", function() require("osv").run_this() end, { buffer = buffer, desc = "OSV Run" })
              vim.keymap.set("n", "<leader>dL", function() require("osv").launch({ port = 8086 }) end, { buffer = buffer, desc = "OSV Launch" })
            end
          end)
        end,
      },
    },
  },
  -- Debugging
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      { "jbyuki/one-small-step-for-vimkind" },
    },
    opts = {
      setup = {
        osv = function(_, _)
          local dap = require "dap"
          dap.configurations.lua = {
            {
              type = "nlua",
              request = "attach",
              name = "Attach to running Neovim instance",
              host = function()
                local value = vim.fn.input "Host [127.0.0.1]: "
                if value ~= "" then
                  return value
                end
                return "127.0.0.1"
              end,
              port = function()
                local val = tonumber(vim.fn.input("Port: ", "8086"))
                assert(val, "Please provide a port number")
                return val
              end,
            },
          }

          dap.adapters.nlua = function(callback, config)
            callback { type = "server", host = config.host, port = config.port }
          end
        end,
      },
    },
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-plenary",
    },
    opts = function(_, opts)
      vim.list_extend(opts.adapters, {
        require "neotest-plenary",
      })
    end,
  },
}
