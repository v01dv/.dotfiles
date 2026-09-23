-- [Vim Dadbod - My Favorite SQL Plugin - YouTube](https://www.youtube.com/watch?v=ALGBuFLzDSA)
if not require('user.config').pde.sql then
  return {}
end

local util = require 'user.util'
local sql_ft = { 'sql', 'mysql', 'plsql' }

return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      util.list_insert_unique(opts.ensure_installed, {
        'sql',
      })
    end,
  },
  -- Add servers and formatters
  {
    'mason-org/mason.nvim',
    opts = {
      ensure_installed = {
        'sqlfluff',
      },
    },
  },
  -- Linters & formatters
  {
    'mfussenegger/nvim-lint',
    opts = {
      linters_by_ft = {
        sql = { 'sqlfluff' },
        pgsql = { 'sqlfluff' },
        mysql = { 'sqlfluff' },
        mariadb = { 'sqlfluff' },
        plsql = { 'sqlfluff' },
      },
    },
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters = {
        sqlfluff = {
          command = 'sqlfluff',
          args = { 'format', '--dialect=ansi', '-' },
          -- args = { 'format', '--dialect', 'postgres', '-' },
        },
      },
      formatters_by_ft = {
        sql = { 'sqlfluff' },
        pgsql = { 'sqlfluff' },
        mysql = { 'sqlfluff' },
        mariadb = { 'sqlfluff' },
        plsql = { 'sqlfluff' },
      },
    },
  },
  {
    'tpope/vim-dadbod',
    cmd = 'DB',
  },
  {
    'kristijanhusak/vim-dadbod-ui',
    cmd = { 'DBUI', 'DBUIToggle', 'DBUIAddConnection', 'DBUIFindBuffer' },
    dependencies = 'vim-dadbod',
    keys = {
      { '<leader>Dt', '<cmd>DBUIToggle<CR>', desc = 'Toggle DBUI' },
    },
    init = function()
      local data_path = vim.fn.stdpath 'data'

      vim.g.db_ui_auto_execute_table_helpers = 1
      vim.g.db_ui_save_location = data_path .. '/dadbod_ui'
      vim.g.db_ui_show_database_icon = true
      vim.g.db_ui_tmp_query_location = data_path .. '/dadbod_ui/tmp'
      vim.g.db_ui_use_nerd_fonts = true
      vim.g.db_ui_use_nvim_notify = false

      -- NOTE: The default behavior of auto-execution of queries on save is disabled
      -- this is useful when you have a big query that you don't want to run every time
      -- you save the file running those queries can crash neovim to run use the
      -- default keymap: <leader>S
      vim.g.db_ui_execute_on_save = false
    end,
  },
  -- blink.cmp integration
  {
    'saghen/blink.cmp',
    dependencies = {
      'kristijanhusak/vim-dadbod-completion',
    },
    opts = {
      sources = {
        default = { 'dadbod' },
        providers = {
          dadbod = {
            name = 'Dadbod',
            module = 'vim_dadbod_completion.blink',
          },
        },
      },
    },
  },
}
