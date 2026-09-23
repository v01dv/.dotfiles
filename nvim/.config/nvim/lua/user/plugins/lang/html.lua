if not require('user.config').pde.html then
  return {}
end

local util = require 'user.util'

return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      util.list_insert_unique(opts.ensure_installed, {
        'html',
        'css',
      })
    end,
  },
  -- Add servers and formatters
  {
    'mason-org/mason.nvim',
    opts = {
      ensure_installed = {
        'prettierd',
        'stylelint',
      },
    },
  },
  -- Linters & formatters
  {
    'mfussenegger/nvim-lint',
    opts = {
      linters_by_ft = {
        css = { 'stylelint' },
      },
    },
  },
  {
    'stevearc/conform.nvim',
    optional = true,
    opts = {
      formatters_by_ft = {
        html = { 'prettierd', 'prettier', stop_after_first = true },
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      -- make sure mason installs the server
      servers = {
        -- html
        html = {
          filetypes = { 'html', 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
        },
        -- Emmet
        emmet_language_server = {
          -- filetypes = { 'typescript', 'css', 'html', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
          filetypes = { 'typescript', 'css', 'eruby', 'html', 'javascript', 'javascriptreact', 'less', 'sass', 'scss', 'pug', 'typescriptreact', 'vue' },
          init_options = {
            includeLanguages = {
              typescriptreact = 'html',
              javascriptreact = 'html',
              typescript = 'javascript',
            },
            syntaxProfiles = {
              filters = 'bem',
            },
          },
        },
        -- CSS
        cssls = {},
      },
    },
  },
}
