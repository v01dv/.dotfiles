return {
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = { 'TodoTrouble', 'TodoTelescope' },
    event = 'LazyFile',
    opts = {
      signs = false, -- show icons in the signs column
      keywords = {
        fix = {
          icon = ' ', -- icon used for the sign, and in search results
          color = 'error', -- can be a hex color, or a named color (see below)
          alt = { 'fixme', 'bug', 'fixit', 'issue' }, -- a set of other keywords that all map to this fix keywords
          -- signs = false, -- configure signs for some keywords individually
        },
        todo = { icon = ' ', color = 'info' },
        hack = { icon = ' ', color = 'warning' },
        warn = { icon = ' ', color = 'warning', alt = { 'warning', 'xxx' } },
        perf = { icon = ' ', alt = { 'optim', 'performance', 'optimize' } }, -- " "
        note = { icon = ' ', color = 'hint', alt = { 'info' } }, --" "
        test = { icon = '󰙨 ', color = 'test', alt = { 'testing', 'passed', 'failed' } },
      },
    },
    -- stylua: ignore
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
      { "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
      { "<leader>xT", "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
      -- { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
      -- { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
    },
  },
}
