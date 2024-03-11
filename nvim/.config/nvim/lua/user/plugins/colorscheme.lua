return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("catppuccin").setup {
        flavour = "frappe", -- latte, frappe, macchiato, mocha
        -- background = { -- :h background
        --       light = "latte",
        --       dark = "frappe",
        --   },
        transparent_background = false,
        term_colors = false,
        dim_inactive = {
          enabled = false,
          shade = "dark",
          percentage = 0.15,
        },
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
          loops = {},
          functions = {},
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
        },
        color_overrides = {},
        custom_highlights = function(colors)
          return {
            -- TroubleText = { fg = colors.text },
            -- TroubleCount = { fg = C.pink },
            -- TroubleNormal = { fg = colors.text, bg = colors.base },
            -- NullLsInfoHeader = { fg = colors.green, style = { "bold" } },
            NullLsInfoHeader = { fg = colors.sapphire, bold = true},
            NullLsInfoTitle = { fg = colors.blue },
            NullLsInfoBorder = { fg = colors.blue },
            NullLsInfoSources = { fg = colors.yellow },
            -- https://www.reddit.com/r/vim/comments/12v898n/comment/jha0epq/
            netrwTreeBar = { fg = colors.surface0 },

            -- NeoTreeWinSeparator = { fg = colors.mantle },
            NeoTreeWinSeparator = { fg = colors.mantle, bg = colors.mantle },

            CodeiumSuggestion = { fg = colors.green },
          }
        end,
        integrations = {
          gitsigns = true,
          cmp = true,
          telescope = {
            enabled = true,
            -- style = "nvchad"
          },
          nvimtree = true,
          neotree = true,
          treesitter_context = true,
          treesitter = true,
          harpoon = true,
          hop = true,
          markdown = true,
          mason = true,
          notify = true,
          rainbow_delimiters = true,
          flash = true,
          symbols_outline = true,
          lsp_trouble = true,
          illuminate = {
            enabled = true,
            lsp = false,
          },
          fidget = true,
          neotest = true,
          dap_ui = true,
          dap = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "undercurl" },
              hints = { "undercurl" },
              warnings = { "undercurl" },
              information = { "undercurl" },
            },
            inlay_hints = {
              background = true,
            },
          },
          navic = {
            enabled = true,
            custom_bg = "NONE",
          },
          indent_blankline = {
            enabled = true,
            scope_color = "",
            colored_indent_levels = false,
          },
        },
      }
      -- Load the colorscheme here
      vim.cmd.colorscheme "catppuccin"
      -- https://jdhao.github.io/2020/09/22/highlight_groups_cleared_in_nvim/
      -- vim.cmd "highlight YankColor guifg=#303446 guibg=#F4B8E4"
      vim.cmd "highlight YankColor guifg=#303446 guibg=#CA9EE6"
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    enabled = false,
    opts = {
      style = "moon",
      transparent = false,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
    config = function(_, opts)
      local tokyonight = require "tokyonight"
      tokyonight.setup(opts)
      tokyonight.load()
    end,
  },
}
