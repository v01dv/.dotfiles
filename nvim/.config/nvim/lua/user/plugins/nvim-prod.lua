-- Source:
--  [Fix Your BAD Vim Habits - Neovim Plugin Spotlight - Hardtime + Precognition - YouTube](https://www.youtube.com/watch?v=7hQZhHve4HI)

return {
  {
    -- TODO: Read:
    --  - 'Recommended workflow' section in https://github.com/m4xshen/hardtime.nvim?tab=readme-ov-file#%EF%B8%8F--features
    --  - [Practical Vim command workflow | Max Shen Dev](https://m4xshen.dev/posts/vim-command-workflow/)
    --  - [3 Vim commands for blazingly fast navigation between brackets | Max Shen Dev](https://m4xshen.dev/posts/vim-commands-for-navigation-between-brackets)
    --  - [Essential Vim commands for efficient text editing | Max Shen Dev](https://m4xshen.dev/posts/vim-basic-commands/)

    'm4xshen/hardtime.nvim',
    -- event = "VeryLazy",
    cmd = { 'HardTime' },
    dependencies = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim' },
    opts = {
      disabled_filetypes = { 'qf', 'netrw', 'NvimTree', 'lazy', 'mason', 'oil' },
    },
  },
  {
    'tris203/precognition.nvim',
    -- event = 'VeryLazy',
    opts = {
      -- startVisible = true,
      -- showBlankVirtLine = true,
      -- highlightColor = { link = "Comment" },
      -- hints = {
      --      Caret = { text = "^", prio = 2 },
      --      Dollar = { text = "$", prio = 1 },
      --      MatchingPair = { text = "%", prio = 5 },
      --      Zero = { text = "0", prio = 1 },
      --      w = { text = "w", prio = 10 },
      --      b = { text = "b", prio = 9 },
      --      e = { text = "e", prio = 8 },
      --      W = { text = "W", prio = 7 },
      --      B = { text = "B", prio = 6 },
      --      E = { text = "E", prio = 5 },
      -- },
      -- gutterHints = {
      --     G = { text = "G", prio = 10 },
      --     gg = { text = "gg", prio = 9 },
      --     PrevParagraph = { text = "{", prio = 8 },
      --     NextParagraph = { text = "}", prio = 8 },
      -- },
      -- disabled_fts = {
      --     "startify",
      -- },
    },
  },
  -- {
  --   'theprimeagen/vim-be-good',
  --   event = 'VeryLazy',
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --   },
  --   config = function() end,
  -- },
  --
  -- {
  --   "tris203/precognition.nvim",
  --   event = "VeryLazy",
  --   config = {
  --   -- startVisible = true,
  --   -- showBlankVirtLine = true,
  --   -- highlightColor = { link = "Comment" },
  --   -- hints = {
  --   --      Caret = { text = "^", prio = 2 },
  --   --      Dollar = { text = "$", prio = 1 },
  --   --      MatchingPair = { text = "%", prio = 5 },
  --   --      Zero = { text = "0", prio = 1 },
  --   --      w = { text = "w", prio = 10 },
  --   --      b = { text = "b", prio = 9 },
  --   --      e = { text = "e", prio = 8 },
  --   --      W = { text = "W", prio = 7 },
  --   --      B = { text = "B", prio = 6 },
  --   --      E = { text = "E", prio = 5 },
  --   -- },
  --   -- gutterHints = {
  --   --     -- prio is not currently used for gutter hints
  --   --     G = { text = "G", prio = 1 },
  --   --     gg = { text = "gg", prio = 1 },
  --   --     PrevParagraph = { text = "{", prio = 1 },
  --   --     NextParagraph = { text = "}", prio = 1 },
  --   -- },
  --   },
  -- }
}
