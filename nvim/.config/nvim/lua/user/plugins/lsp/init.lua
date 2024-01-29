return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = true }, -- used to manage global and project local settings.
      {
        "j-hui/fidget.nvim",
        -- config = true,
        opts = {
          notification = {
            window = {
              winblend = 0,
            },
          },
        },
      },
      { "smjonas/inc-rename.nvim", config = true },
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    -- By default, we don’t configure any language server. F
    -- or each programming language, we will provide the configuration under the pde folder.
    opts = {
      servers = {
        dockerls = {},
      },
      setup = {},
      format = {
        timeout_ms = 3000,
      },
    },
    config = function(plugin, opts)
      require("user.plugins.lsp.servers").setup(plugin, opts)
    end
  },
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    cmd = "Mason",
    opts = {
      ui = {
          border = "rounded",
      },
      ensure_installed = {
        "shfmt",
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require "mason-registry"
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = {
      use_diagnostic_signs = true,
      auto_close = true,
      signs = { other = "", },
      win_config = { border = "rounded" },
    },
    -- keys = {
    --   { "<leader>ld", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics" },
    --   { "<leader>lD", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics" },
    -- },
    config = function()
      -- vim.keymap.set("n", "<leader>x", function() require("trouble").toggle() end, { silent = true, noremap = true })
      vim.keymap.set("n", "<leader>xD", function() require("trouble").toggle("workspace_diagnostics") end, { silent = true, noremap = true, desc = "Workspace Diagnostics" })

      vim.keymap.set("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end, { silent = true, noremap = true, desc = "Document Diagnostics"})
    end
  },
  {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason.nvim" },
    opts = function()
      local nls = require "null-ls"
      return {
        border = "rounded",
        root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
        sources = {
          nls.builtins.formatting.shfmt,
          -- null_ls.builtins.diagnostics.eslint,
        },
      }
    end,
  },
}

