return {
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = "BufReadPost",
    opts = {
      -- keywords recognized as todo comments
      keywords = {
        fix = {
          icon = " ", -- icon used for the sign, and in search results
          color = "error", -- can be a hex color, or a named color (see below)
          alt = { "fixme", "bug", "fixit", "issue" }, -- a set of other keywords that all map to this fix keywords
          -- signs = false, -- configure signs for some keywords individually
        },
        todo = { icon = " ", color = "info" },
        hack = { icon = " ", color = "warning" },
        warn = { icon = " ", color = "warning", alt = { "warning", "xxx" } },
        perf = { icon = " ", alt = { "optim", "performance", "optimize" } }, -- " "
        note = { icon = " ", color = "hint", alt = { "info" } }, --" "
        test = { icon = "󰙨 ", color = "test", alt = { "testing", "passed", "failed" } },
      },
    },
    config = function(_, opts)
      require("todo-comments").setup(opts)

      vim.keymap.set("n", "]t", function()
        require("todo-comments").jump_next()
      end, { desc = "Next ToDo" })

      vim.keymap.set("n", "[t", function()
        require("todo-comments").jump_prev()
      end, { desc = "Previous todo" })

      vim.keymap.set("n", "<leader>lt", "<cmd>TodoTrouble<cr>", { desc = "ToDo (Trouble)" })
      vim.keymap.set("n", "<leader>lt", "<cmd>TodoTelescope<cr>", { desc = "ToDo (Telescope)" })

      -- you can also specify a list of valid jump keywords
      -- vim.keymap.set("n", "]t", function()
      --   require("todo-comments").jump_next { keywords = { "error", "warning" } }
      -- end, { desc = "next error/warning todo comment" })
    end
  },
}
