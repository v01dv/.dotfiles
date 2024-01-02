local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

-- NOTE: references for Catppuccin Frappé
-- monochromatic: https://coolors.co/c6ceef-b1b8d7-9ba2bf-868ca7-707590-5b5f78-454960-303348-252737-181a25
-- analogous 1: https://coolors.co/f2d5cf-eebebe-f4b8e4-ca9ee6-ea999c-e78284-ef9f76
-- analogous 2: https://coolors.co/bfb7e4-8caaee-99d1db-e5c890-85c1dc-a6d189-81c8be

local color_palette = {
	rosewater = "#F2D5CF",
	flamingo = "#EEBEBE",
	pink = "#F4B8E4",
	mauve = "#CA9EE6",
	red = "#E78284",
	maroon = "#EA999C",
	peach = "#EF9F76",
	yellow = "#E5C890",
	green = "#A6D189",
	teal = "#81C8BE",
	sky = "#99D1DB",
	sapphire = "#85C1DC",
	blue = "#8CAAEE",
	lavender = "#BABBF1",

	text = "#c6d0f5",
	subtext1 = "#b5bfe2",
	subtext0 = "#a5adce",
	overlay2 = "#949cbb",
	overlay1 = "#838ba7",
	overlay0 = "#737994",
	surface2 = "#626880",
	surface1 = "#51576d",
	surface0 = "#414559",

	base = "#303446",
	mantle = "#292C3C",
	crust = "#232634",
}

local mode_color = function ()
  local mode_colors = {
    n = "#8CAAEE",
    i = "#A6D189",
    v = "#CA9EE6",
    [''] = "#CA9EE6",
    V = "#CA9EE6",
    c = "#EF9F76",
    no = "#8CAAEE",
    s = "#CA9EE6",
    S = "#CA9EE6",
    [''] = "#CA9EE6",
    ic = "#A6D189",
    R = "#F4B8E4",
    Rv = "#F4B8E4",
    cv = "#EF9F76",
    ce = "#EF9F76",
    r = "#F4B8E4",
    rm = "#8CAAEE",
    ['r?'] = "#8CAAEE",
    ['!'] = "#c6d0f5",
    t ="#c6d0f5"
  }

  local color = mode_colors[vim.fn.mode()]

  if color == nil then
    color = "#E78284"
  end

  return color
end

local theme = {
  normal = {
    a = { fg = "#949cbb", bg = "#414559" },
    b = { fg = "#949cbb", bg = "#414559" },
    c = { fg = "#949cbb", bg = "#414559" },
  },

  -- insert = { a = { fg = colors.black, bg = colors.blue } },
  -- visual = { a = { fg = colors.black, bg = colors.cyan } },
  -- replace = { a = { fg = colors.black, bg = colors.red } },

  inactive = {
    a = { fg = "#949cbb", bg = "#414559" },
    b = { fg = "#949cbb", bg = "#414559" },
    c = { fg = "#949cbb", bg = "#414559" },
  },
}

local window_width_limit = 100

local hide_in_width = function()
  return vim.o.columns > window_width_limit
end

local mode = {
  "mode",
  color = function()
    -- auto change color according to neovims mode
    return { fg = mode_color(), bg = "#414559", gui = 'bold' }
  end,
  padding = 1,
  cond = nil,
}

local branch = {
  "b:gitsigns_head",
  icon = "",
  padding = 1,
}

local filename = {
  "filename",
  color = {},
  cond = nil,
}

local diff = {
  "diff",
  colored = true,
  symbols = {
    added = "+", --'  '
    modified = "~", --' 柳'
    removed = "-" --'  '
  },
  cond = nil,
}

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  symbols = { error = " ", warn = " ", info = " ", hint = " " },
  -- colored = false,
  -- update_in_insert = false,
  -- always_visible = true,
  -- padding = 0,
  -- cond = hide_in_width,
}

local treesitter = {
  function()
    return ""
  end,
  color = function()
    local buf = vim.api.nvim_get_current_buf()
    local ts = vim.treesitter.highlighter.active[buf]
    return { fg = ts and not vim.tbl_isempty(ts) and "#A6D189" or "#E78284" }
  end,
  cond = hide_in_width,
}

local location = {
  "location",
  padding = { left = 1, right = 0 },
}

local progress = {
  "progress",
  fmt = function()
    return "%P/%L"
  end,
  color = {},
}

local spaces = {
  function()
  return " " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
  end,
}

local filetype = {
  "filetype",
  icons_enabled = false,
  icon = nil,
}

local encoding = {
  "o:encoding",
  fmt = string.upper,
  color = {},
  cond = hide_in_width,
}

local lsp = {
  function()
    local msg = "LS Inactive"  -- 'No Active Lsp'
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
      return msg
      -- return "[" .. msg .. "]"
    end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return client.name
        -- return "[" .. client.name .. "]"
      end
    end
    return msg
    -- return "[" .. msg .. "]"
  end,
  icon = '',
  color = { gui = "bold" },
  cond = hide_in_width,
}

lualine.setup {
  options = {
    icons_enabled = true,
    theme = theme,
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {"alpha"},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = { mode },
    lualine_b = { branch },
    lualine_c = { diff },
    lualine_x = { diagnostics, lsp, treesitter, filetype, encoding, spaces },
    lualine_y = { progress },
    lualine_z = { location }
  },
  inactive_sections = {
    lualine_a = { mode },
    lualine_b = { branch },
    lualine_c = { diff },
    lualine_x = { diagnostics, lsp, treesitter, filetype, encoding, spaces },
    lualine_y = { progress },
    lualine_z = { location }
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
