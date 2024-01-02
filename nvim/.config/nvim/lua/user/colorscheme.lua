local colorscheme = "catppuccin"
-- local colorscheme = "nordfox"
-- local colorscheme = "nord"
-- local colorscheme = "tokyonight-night"

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
      conditionals = {"italic"},
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
      TroubleText = { fg = colors.text },
		  TroubleCount = { fg = C.pink },
		  TroubleNormal = { fg = colors.text, bg = colors.base },
    }
  end,
  integrations = {
    gitsigns = true,
    cmp = true,
    telescope = true,
    nvimtree = true,
    treesitter_context = true,
    treesitter = true,
    harpoon = true,
    hop = true,
    markdown = true,
    mason = true,
    notify = true,
    ts_rainbow = true,
    symbols_outline = true,
    lsp_trouble = true,
    illuminate = true,
    fidget = true,

    -- Special integrations, see https://github.com/catppuccin/nvim#special-integrations
    dap = {
        enabled = false,
        enable_ui = false,
    },
    native_lsp = {
        enabled = true,
        virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
        },
        underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
        },
    },
    navic = {
      enabled = true,
      custom_bg = "NONE",
    },
  }
}

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end

