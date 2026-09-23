return {

  {
    'stevearc/aerial.nvim',
    event = 'LazyFile',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    opts = function()
      -- local icons = vim.deepcopy(LazyVim.config.icons.kinds)

      -- HACK: fix lua's weird choice for `Package` for control
      -- structures like if/else/for/etc.
      -- icons.lua = { Package = icons.Control }

      -- ---@type table<string, string[]>|false
      -- local filter_kind = false
      -- if LazyVim.config.kind_filter then
      --   filter_kind = assert(vim.deepcopy(LazyVim.config.kind_filter))
      --   filter_kind._ = filter_kind.default
      --   filter_kind.default = nil
      -- end

      local opts = {
        attach_mode = 'global',
        backends = { 'lsp', 'treesitter', 'markdown', 'man' },
        show_guides = true,
        layout = {
          resize_to_content = false,
          win_opts = {
            winhl = 'Normal:NormalFloat,FloatBorder:NormalFloat,SignColumn:SignColumnSB',
            signcolumn = 'yes',
            statuscolumn = ' ',
          },
        },
      -- icons = icons,
      -- filter_kind = filter_kind,
      -- stylua: ignore
      guides = {
        mid_item   = "├╴",
        last_item  = "└╴",
        nested_top = "│ ",
        whitespace = "  ",
      },
      }
      return opts
    end,
    keys = {
      { '<leader>cs', '<cmd>AerialToggle<cr>', desc = 'Aerial (Symbols)' },
    },
  },

  {
    'folke/edgy.nvim',
    optional = true,
    opts = function(_, opts)
      -- local edgy_idx = LazyVim.plugin.extra_idx 'ui.edgy'
      -- local aerial_idx = LazyVim.plugin.extra_idx 'editor.aerial'
      --
      -- if edgy_idx and edgy_idx > aerial_idx then
      --   LazyVim.warn('The `edgy.nvim` extra must be **imported** before the `aerial.nvim` extra to work properly.', {
      --     title = 'LazyVim',
      --   })
      -- end

      opts.right = opts.right or {}
      table.insert(opts.right, {
        title = 'Aerial',
        ft = 'aerial',
        pinned = true,
        open = 'AerialOpen',
      })
    end,
  },
}
