vim.filetype.add {
  extension = {
    ['http'] = 'http',
  },
}

return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      ensure_installed = { 'http', 'graphql' },
    },
  },
  -- Add servers and formatters
  {
    'mason-org/mason.nvim',
    opts = {
      ensure_installed = {
        'kulala-fmt',
      },
    },
  },
  -- Linters & formatters
  {
    'stevearc/conform.nvim',
    optional = true,
    opts = {
      formatters_by_ft = {
        http = { 'kulala' },
      },
      formatters = {
        kulala = {
          command = 'kulala-fmt',
          args = { 'format', '$FILENAME' },
          stdin = false,
        },
      },
    },
  },
  {
    'mistweaverco/kulala.nvim',
    ft = { 'http', 'rest' },
    opts = {
      global_keymaps = true,
      global_keymaps_prefix = '<leader>R',
      kulala_keymaps_prefix = '',
      default_env = 'dev',
      ui = {
        default_view = 'headers_body',
        -- display_mode = "float",
      },
    },
    keys = {
      { '<leader>R', '', desc = '+Rest', ft = 'http' },
      { '<leader>Rb', "<cmd>lua require('kulala').scratchpad()<cr>", desc = 'Open scratchpad', ft = 'http' },
      { '<leader>Rc', "<cmd>lua require('kulala').copy()<cr>", desc = 'Copy as cURL', ft = 'http' },
      { '<leader>RC', "<cmd>lua require('kulala').from_curl()<cr>", desc = 'Paste from curl', ft = 'http' },
      {
        '<leader>Rg',
        "<cmd>lua require('kulala').download_graphql_schema()<cr>",
        desc = 'Download GraphQL schema',
        ft = 'http',
      },
      { '<leader>Ri', "<cmd>lua require('kulala').inspect()<cr>", desc = 'Inspect current request', ft = 'http' },
      { '<leader>Rn', "<cmd>lua require('kulala').jump_next()<cr>", desc = 'Jump to next request', ft = 'http' },
      { '<leader>Rp', "<cmd>lua require('kulala').jump_prev()<cr>", desc = 'Jump to previous request', ft = 'http' },
      { '<leader>Rq', "<cmd>lua require('kulala').close()<cr>", desc = 'Close window', ft = 'http' },
      { '<leader>Rr', "<cmd>lua require('kulala').replay()<cr>", desc = 'Replay the last request', ft = 'http' },
      { '<leader>Rs', "<cmd>lua require('kulala').run()<cr>", desc = 'Send the request', ft = 'http' },
      { '<leader>RS', "<cmd>lua require('kulala').show_stats()<cr>", desc = 'Show stats', ft = 'http' },
      { '<leader>Rt', "<cmd>lua require('kulala').toggle_view()<cr>", desc = 'Toggle headers/body', ft = 'http' },

      { '<leader>Re', "<cmd>lua require('kulala').set_selected_env()<cr>", desc = 'Select environment', ft = 'http' },
      { '<leader>Ru', "<cmd>lua require('kulala').open_auth_config() <cr>", desc = 'Manage Auth Config', ft = 'http' },

      -- {
      --   '<C-g>',
      --   function()
      --     require('kulala').scripts_clear_global()
      --     require("kulala").clear_cached_files()
      --   end,
      --   ft = { 'http', 'rest' },
      -- },
    },
  },
}
