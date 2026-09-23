return {
  {
    -- Configures LuaLS to support auto-completion and type checking
    -- while editing your Neovim configuration.
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        { path = 'lazy.nvim', words = { 'OhVim' } },
      },
    },
  },
  {
    'saghen/blink.cmp',
    optional = true,
    dependencies = {
      'folke/lazydev.nvim',
    },
    opts = {
      sources = {
        default = { 'lazydev' },
        providers = {

          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            score_offset = 100,
            async = true,
          },
        },
      },
    },
  },
}
