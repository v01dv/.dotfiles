return {
  {
    'mason-org/mason.nvim',
    opts = {
      ensure_installed = {
        'taplo',
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        taplo = {},
      },
    },
  },
}
