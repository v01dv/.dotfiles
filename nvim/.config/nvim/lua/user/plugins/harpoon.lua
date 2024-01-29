return {
  {
    "ThePrimeagen/harpoon",
    -- branch = "harpoon2",
    -- event = "VeryLazy",
    opts = {
      sglobal_ettings = {
        save_on_toggle = true,
        enter_on_sendcmd = true,
      },
    },
    keys = {
      { "<leader>ja", function() require("harpoon.mark").add_file() end, desc = "Add File" },
      { "<leader>jm", function() require("harpoon.ui").toggle_quick_menu() end, desc = "File Menu" },
      { "<leader>jc", function() require("harpoon.cmd-ui").toggle_quick_menu() end, desc = "Command Menu" },
      { "<leader>1", function() require("harpoon.ui").nav_file(1) end, desc = "File 1" },
      { "<leader>2", function() require("harpoon.ui").nav_file(2) end, desc = "File 2" },
      { "<leader>3", function() require("harpoon.term").gotoTerminal(1) end, desc = "Terminal 1" },
      { "<leader>4", function() require("harpoon.term").gotoTerminal(2) end, desc = "Terminal 2" },
      { "<leader>5", function() require("harpoon.term").sendCommand(1,1) end, desc = "Command 1" },
      { "<leader>6", function() require("harpoon.term").sendCommand(1,2) end, desc = "Command 2" },
    },
    --[[ config = function(_, opts)
      require("harpoon").setup()
      -- local harpoon = require('harpoon')
      -- harpoon:setup(opts)

      -- from the quickmenu, open a file in:
      -- a vertical split with control+v,
      -- a horizontal split with control+x,
      -- a new tab with control+t
      -- vim.keymap.set("n", "-", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "File Menu" })
      -- vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end, { desc = "Add File" })
      -- vim.keymap.set("n", "]m", function() harpoon:list():next() end, { desc = "Navigate to next mark" })
      -- vim.keymap.set("n", "[m", function() harpoon:list():prev() end, { desc = "Navigate to previous mark" })

      -- vim.keymap.set("n", "<C-1>", function() harpoon:list():select(1) end, { desc = "File 1" })
      -- vim.keymap.set("n", "<C-2>", function() harpoon:list():select(2) end, { desc = "File 2" })
      -- vim.keymap.set("n", "<C-3>", function() harpoon:list():select(3) end, { desc = "File 3" })
      -- vim.keymap.set("n", "<C-4>", function() harpoon:list():select(4) end, { desc = "File 4" })


      vim.keymap.set("n", "<leader>a", function() require("harpoon.mark").add_file() end, { silent = true }) -- Harpoon
      vim.keymap.set("n", "-", function() require("harpoon.ui").toggle_quick_menu() end, { silent = true }) -- Harpoon UI
      vim.keymap.set("n", "]m", "<cmd>lua require('harpoon.ui').nav_next()<cr>", { silent = true }) -- Harpoon next
      vim.keymap.set("n", "[m", "<cmd>lua require('harpoon.ui').nav_prev()<cr>", { silent = true }) -- Harpoon prev

      vim.keymap.set("n", "<C-1>",  function() require("harpoon.ui").nav_file(1) end, { desc = "File 1" })
      vim.keymap.set("n", "<C-2>",  function() require("harpoon.ui").nav_file(2) end, { desc = "File 1" })
      vim.keymap.set("n", "<C-3>",  function() require("harpoon.ui").nav_file(3) end, { desc = "File 1" })
      vim.keymap.set("n", "<C-4>",  function() require("harpoon.ui").nav_file(4) end, { desc = "File 1" })

    end ]]
  },
}

