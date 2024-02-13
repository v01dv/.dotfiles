-- Add here:
--  * any plugins that don't need any extra configuration e.g., dial.nvim, numb.nvim, neogit, diffview.nvim, etc)
--  * common plugins (e.g., plenary.nvim, nui.nvim, nvim-web-devicons, dressing.nvim, etc)
--
-- Plugins that require more configurations will have their own configuration files, e.g. WhichKey, Telescope, and Tree-sitter.
-- For similar plugins that require more configurations, e.g. LSP, and color schemes, they will have their own folders.

return {
  "nvim-lua/plenary.nvim", -- lua functions that many plugins use

  -- if some code requires a module from an unloaded plugin, it will be automatically loaded.
  -- So for api plugins like devicons, we can always set lazy=true
  "nvim-tree/nvim-web-devicons",
  {
    "max397574/better-escape.nvim",
    enabled = true,
    event = "InsertEnter",
    config = function()
      require("better_escape").setup {
        mapping = { "jk", "jj" },
      }
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    main = 'ibl',
    config = function()
      local icons = require "user.config.icons"

      require("ibl").setup {
        exclude = {
          buftypes = { "terminal", "nofile" },
          filetypes = {
            "help",
            "startify",
            "dashboard",
            "lazy",
            "neogitstatus",
            "NvimTree",
            "Trouble",
            "text",
            "toggleterm",
            "notify",
            "lazyterm",
            "mason",
          },
        },
        scope = {
          -- enabled = false,
          show_start = false, -- Shows an underline on the first line of the scope
          -- show_end = false, -- Shows an underline on the last line of the scope
        },
        -- indent = { char = '┊' },  -- '|', '¦', '┆', '┊'
        indent = { char = icons.ui.LineMiddle },  -- '|', '¦', '┆', '┊'
        -- char = icons.ui.LineLeft,
        -- char = icons.ui.LineMiddle,
      }
    end,
  },
  {
    "numToStr/Comment.nvim",
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    keys = { { "gc", mode = { "n", "v" } }, { "gcc", mode = { "n", "v" } }, { "gbc", mode = { "n", "v" } } },
    config = function(_, _)
      local opts = {
        ignore = "^$",
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      }
      require("Comment").setup(opts)
    end,
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    opts = function()
        -- This module contains a number of default definitions
      local rainbow_delimiters = require 'rainbow-delimiters'
      return {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
          vim = rainbow_delimiters.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
          -- typescript = "rainbow-parens",
          -- javascript = "rainbow-parens",
          -- typescriptreact = "rainbow-parens",
          -- javascriptreact = "rainbow-parens",
          -- tsx = "rainbow-parens",
          -- jsx = "rainbow-parens",
          -- html = "rainbow-parens",
        },
      }
    end,
    config = function(_, opts)
      require('rainbow-delimiters.setup').setup(opts)
    end
  },
  {
    "famiu/bufdelete.nvim",
    event = "VeryLazy",
    config = function()
      vim.keymap.set("n", "<S-x>", "<cmd>Bdelete!<cr>")
    end,
  },
  {
    "laytan/cloak.nvim",
    event = "BufReadPost",
    config = function()
      require("cloak").setup {
        enabled = true,
        cloak_character = "*",
        -- The applied highlight group (colors) on the cloaking, see `:h highlight`.
        highlight_group = "Comment",
        patterns = {
          {
            -- Match any file starting with ".env".
            -- This can be a table to match multiple file patterns.
            file_pattern = {
              ".env*",
              "wrangler.toml",
              ".dev.vars",
            },
            -- Match an equals sign and any character after it.
            -- This can also be a table of patterns to cloak,
            -- example: cloak_pattern = { ":.+", "-.+" } for yaml files.
            cloak_pattern = "=.+",
          },
        },
      }
    end
  },
  {
    "eandrju/cellular-automaton.nvim",
    event = "VeryLazy",
    config = function()
      vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>", { desc = "Cellular Automaton" });
    end
  },
  {
    "mbbill/undotree",
    event = "VeryLazy",
    config = function()
      vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
    end
  },
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },
  -- FIXME: Temporary disable becausr of conflict with nvim-treesitter
  -- {
  --   "andymass/vim-matchup",
  --   event = { "BufReadPost" },
  --   config = function()
  --     vim.g.matchup_matchparen_offscreen = { method = "popup" }
  --   end,
  -- },


}
