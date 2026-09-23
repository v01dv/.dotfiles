return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
  -- event = 'VeryLazy',
  -- cmd = 'Oil',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    columns = {
      -- "icon",
      -- "permissions",
      -- "size",
      -- "mtime",
    },
    view_options = {
      -- Show files and directories that start with "."
      show_hidden = true,
    },
    float = {
      -- max_height = 20,
      -- max_width = 60,
      get_win_title = nil,
      preview_split = 'right',

      max_width = math.floor(vim.o.columns * 0.55),
      max_height = math.floor(vim.o.lines * 0.7),
    },
    keymaps = {
      ['g?'] = 'actions.show_help',
      -- ["l"] = "actions.select",
      ['v'] = 'actions.select_vsplit',
      ['<C-h>'] = 'actions.select_split',
      ['<C-t>'] = 'actions.select_tab',
      ['<C-p>'] = 'actions.preview',
      ['<C-c>'] = 'actions.close',
      ['<C-l>'] = 'actions.refresh',
      -- ["h"] = "actions.parent",
      ['_'] = 'actions.open_cwd',
      ['`'] = 'actions.cd',
      ['~'] = 'actions.tcd',
      ['gs'] = 'actions.change_sort',
      ['gx'] = 'actions.open_external',
      ['g.'] = 'actions.toggle_hidden',
      ['g\\'] = 'actions.toggle_trash',
    },
  },

  config = function(_, opts)
    require('oil').setup(opts)
    vim.keymap.set('n', '\\', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
    vim.keymap.set('n', '<leader>of', '<CMD>Oil --float<CR>', { desc = 'Open parent directory (float)' })
  end,
  -- config = function()
  --   require('oil').setup {
  --     columns = {
  --       -- "icon",
  --       -- "permissions",
  --       -- "size",
  --       -- "mtime",
  --     },
  --     view_options = {
  --       -- Show files and directories that start with "."
  --       show_hidden = true,
  --     },
  --     float = {
  --       max_height = 20,
  --       max_width = 60,
  --     },
  --     keymaps = {
  --       ['g?'] = 'actions.show_help',
  --       -- ["l"] = "actions.select",
  --       ['v'] = 'actions.select_vsplit',
  --       ['<C-h>'] = 'actions.select_split',
  --       ['<C-t>'] = 'actions.select_tab',
  --       ['<C-p>'] = 'actions.preview',
  --       ['<C-c>'] = 'actions.close',
  --       ['<C-l>'] = 'actions.refresh',
  --       -- ["h"] = "actions.parent",
  --       ['_'] = 'actions.open_cwd',
  --       ['`'] = 'actions.cd',
  --       ['~'] = 'actions.tcd',
  --       ['gs'] = 'actions.change_sort',
  --       ['gx'] = 'actions.open_external',
  --       ['g.'] = 'actions.toggle_hidden',
  --       ['g\\'] = 'actions.toggle_trash',
  --     },
  --   }
  --
  --   vim.keymap.set('n', '\\', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
  -- end,
}
