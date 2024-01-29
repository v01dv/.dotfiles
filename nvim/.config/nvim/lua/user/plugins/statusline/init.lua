return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    -- "AndreM222/copilot-lualine",
  },
  opts = function()
    local components = require "user.plugins.statusline.components"

    return {
      options = {
        icons_enabled = true,
        -- theme = 'auto',
        theme = components.theme,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
          statusline = { "dashboard", "alpha", "lazy", "fugitive"  },
          winbar = {
            "NvimTree", -- Because don't need to display NvimTree on the top of window
            "dap-repl",  -- Without this icons in nvim-dap-ui plugin will will not shown
            "help",
            "lazy",
          },
        },
        ignore_focus = { "NvimTree" },
        always_divide_middle = true,
        globalstatus = true,
      },
      sections = {
        lualine_a = { components.mode },
        lualine_b = { components.branch },
        lualine_c = { components.diff, "filename" },
        lualine_x = { components.diagnostics, components.lsp, components.treesitter, components.filetype, components.encoding, components.spaces },
        lualine_y = { components.progress },
        lualine_z = { components.location },
      },
      inactive_sections = {
        lualine_a = { components.mode },
        lualine_b = { components.branch },
        lualine_c = { components.diff },
        lualine_x = { components.diagnostics, components.lsp, components.treesitter, components.filetype, components.encoding, components.spaces },
        lualine_y = { components.progress },
        lualine_z = { components.location },
      },
      winbar = {
        lualine_a = { components.filename },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      inactive_winbar = {
        lualine_a = { components.filename },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      extensions = { "quickfix", "man", "fugitive", "trouble", "lazy", "mason", "nvim-dap-ui", "nvim-tree", "toggleterm" },
    }
  end,
}

