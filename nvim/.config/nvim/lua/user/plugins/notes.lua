return {
  -- {
  --   "jakewvincent/mkdnflow.nvim",
  --   ft = { "markdown" },
  --   rocks = "luautf8",
  --   opts = {},
  --   enabled = false,
  -- },
  -- { "AckslD/nvim-FeMaco.lua", ft = { "markdown" }, opts = {} },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    -- If you observe error: Vim:E117: Unknown function: mkdp#util#install
    -- :Lazy build markdown-preview.nvim
    -- or
    -- build = ":call mkdp#util#install()",
    -- Details: https://github.com/iamcco/markdown-preview.nvim/issues/690
    build = function() vim.fn["mkdp#util#install"]() end,
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = { "markdown" },
    -- name = 'render-markdown', -- Only needed if you have another plugin named markdown.nvim
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons', 'aklt/plantuml-syntax' }, -- if you prefer nvim-web-devicons
    opts = {},
  }
  -- { "mzlogin/vim-markdown-toc", ft = { "markdown" } },
  -- {
  --   "renerocksai/telekasten.nvim",
  --   dependencies = { "nvim-telescope/telescope.nvim" },
  --   opts = {
  --     home = vim.env.HOME .. "/zettelkasten",
  --   },
  --   enabled = false,
  --   ft = { "markdown" },
  -- },
  -- {
  --   "epwalsh/obsidian.nvim",
  --   opts = {
  --     dir = vim.env.HOME .. "/obsidian",
  --     completion = {
  --       nvim_cmp = true,
  --     },
  --   },
  --   enabled = false,
  --   ft = { "markdown" },
  -- },
  -- { "ellisonleao/glow.nvim", config = true, cmd = "Glow", enabled = true },
  -- { "toppair/peek.nvim", config = true, ft = { "markdown" }, enabled = false, build = "deno task --quiet build:fast" },
  -- glow.nvim
  -- https://github.com/rockerBOO/awesome-neovim#markdown-and-latex
}
