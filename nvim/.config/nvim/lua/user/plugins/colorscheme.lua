-- To check current clolorscheme:
-- if (vim.g.colors_name or ''):find 'catppuccin' then
--   opts.highlights = require('catppuccin.special.bufferline').get_theme()
-- end
return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    -- lazy = false -> Load plugin immediately at startup
    -- lazy = true -> Do not load plugin at startup; load only when triggered
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    -- enabled = false,
    config = function()
      require('catppuccin').setup {
        flavour = 'frappe', -- latte, frappe, macchiato, mocha
        -- background = { -- :h background
        --       light = "latte",
        --       dark = "frappe",
        --   },
        transparent_background = false,
        term_colors = false,
        dim_inactive = {
          enabled = false,
          shade = 'dark',
          percentage = 0.15,
        },
        styles = {
          comments = { 'italic' },
          conditionals = { 'italic' },
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
            -- https://www.reddit.com/r/vim/comments/12v898n/comment/jha0epq/
            netrwTreeBar = { fg = colors.surface0 },

            -- NeoTreeWinSeparator = { fg = colors.mantle },
            NeoTreeWinSeparator = { fg = colors.mantle, bg = colors.mantle },

            -- CodeiumSuggestion = { fg = colors.maroon },
            -- CodeiumSuggestion = { fg = colors.sky },
            -- CodeiumSuggestion = { fg = '#B0B0B0' },
            -- CodeiumSuggestion = { fg = '#808080' }, -- default
            CodeiumSuggestion = { fg = '#737994' },
          }
        end,
        auto_integrations = true,
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
          render_markdown = true,
          snacks = {
            enabled = true,
            indent_scope_color = '', -- catppuccin color (eg. `lavender`) Default: text
          },
          ufo = true,
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
          blink_cmp = {
            style = 'bordered',
          },
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { 'italic' },
              hints = { 'italic' },
              warnings = { 'italic' },
              information = { 'italic' },
            },
            underlines = {
              errors = { 'undercurl' },
              hints = { 'undercurl' },
              warnings = { 'undercurl' },
              information = { 'undercurl' },
            },
            inlay_hints = {
              background = true,
            },
          },
          navic = {
            enabled = true,
            custom_bg = 'NONE',
          },
          indent_blankline = {
            enabled = true,
            scope_color = '',
            colored_indent_levels = false,
          },
          dadbod_ui = true,
          overseer = true,
          aerial = true,
        },
      }
      -- setup must be called before loading
      vim.cmd.colorscheme 'catppuccin'

      -- The same as color in the command-line fzf
      -- vim.cmd 'highlight TelescopeMatching guifg=#E78284 guibg=#51576d'
      vim.cmd 'highlight TelescopeMatching guifg=#E78284'
      vim.cmd 'highlight FzfLuaFzfMatch guifg=#E78284'
      -- vim.cmd 'highlight! link TelescopeMatching CurSearch'
      -- vim.cmd 'highlight TelescopeSelectionCaret guifg=#A6D189'
      vim.cmd 'highlight MyYankColor guifg=#303446 guibg=#EF9F76'
    end,
  },
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    enabled = false,
    opts = {
      style = 'moon',
      transparent = false,
      styles = {
        sidebars = 'transparent',
        floats = 'transparent',
      },
    },
    config = function(_, opts)
      local tokyonight = require 'tokyonight'
      tokyonight.setup(opts)
      tokyonight.load()
      -- vim.cmd 'colorscheme tokyonight-night'
      -- vim.cmd 'colorscheme tokyonight-storm'
      -- vim.cmd 'colorscheme tokyonight-moon'
    end,
  },
  {
    'rose-pine/neovim',
    lazy = false,
    priority = 1000,
    enabled = false,
    name = 'rose-pine',
    config = function()
      -- vim.cmd 'colorscheme rose-pine'
      -- vim.cmd 'colorscheme rose-pine-main'
      vim.cmd 'colorscheme rose-pine-moon'

      -- vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
      -- vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
    end,
  },
}
