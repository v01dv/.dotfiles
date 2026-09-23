return {
  {
    'L3MON4D3/LuaSnip',
    version = 'v2.*',
    lazy = true,
    build = ('make install_jsregexp' or nil),
    dependencies = {
      {
        'rafamadriz/friendly-snippets',
        config = function()
          require('luasnip.loaders.from_vscode').lazy_load()
          require('luasnip.loaders.from_vscode').lazy_load { paths = { vim.fn.stdpath 'config' .. '/snippets' } }
        end,
      },
    },
    opts = {
      history = true,
      delete_check_events = 'TextChanged',
    },
  },

  -- add snippet_forward action
  -- {
  --   'L3MON4D3/LuaSnip',
  --   opts = function()
  --     LazyVim.cmp.actions.snippet_forward = function()
  --       if require('luasnip').jumpable(1) then
  --         vim.schedule(function()
  --           require('luasnip').jump(1)
  --         end)
  --         return true
  --       end
  --     end
  --     LazyVim.cmp.actions.snippet_stop = function()
  --       if require('luasnip').expand_or_jumpable() then -- or just jumpable(1) is fine?
  --         require('luasnip').unlink_current()
  --         return true
  --       end
  --     end
  --   end,
  -- },

  -- blink.cmp integration
  {
    'saghen/blink.cmp',
    optional = true,
    opts = {
      snippets = {
        preset = 'luasnip',
      },
    },
  },
}
