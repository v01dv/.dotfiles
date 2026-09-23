return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'folke/neoconf.nvim', cmd = 'Neoconf', config = true }, -- used to manage global and project local settings.
      -- {
      --   "j-hui/fidget.nvim",
      --   -- config = true,
      --   opts = {
      --     notification = {
      --       window = {
      --         winblend = 0,
      --       },
      --     },
      --   },
      -- },
      { 'smjonas/inc-rename.nvim', config = true },
      'williamboman/mason.nvim',
      { 'williamboman/mason-lspconfig.nvim', version = '1.32.0' },
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      -- "williamboman/mason-lspconfig.nvim",
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
      require('user.plugins.lsp.servers').setup(plugin, opts)
    end,
  },
  {
    'williamboman/mason.nvim',
    -- version = "1.11.0",
    build = ':MasonUpdate',
    cmd = 'Mason',
    opts = {
      ui = {
        border = 'rounded',
      },
      ensure_installed = {
        'shfmt',
      },
    },
    config = function(_, opts)
      require('mason').setup(opts)
      local mr = require 'mason-registry'
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
}
