local cmake = require 'cmake-tools'
local icons = require 'user.config.icons'
--
-- NOTE: references for Catppuccin Frappé
-- monochromatic: https://coolors.co/c6ceef-b1b8d7-9ba2bf-868ca7-707590-5b5f78-454960-303348-252737-181a25
-- analogous 1: https://coolors.co/f2d5cf-eebebe-f4b8e4-ca9ee6-ea999c-e78284-ef9f76
-- analogous 2: https://coolors.co/bfb7e4-8caaee-99d1db-e5c890-85c1dc-a6d189-81c8be

color_palette = {
  rosewater = '#F2D5CF',
  flamingo = '#EEBEBE',
  pink = '#F4B8E4',
  mauve = '#CA9EE6',
  red = '#E78284',
  maroon = '#EA999C',
  peach = '#EF9F76',
  yellow = '#E5C890',
  green = '#A6D189',
  teal = '#81C8BE',
  sky = '#99D1DB',
  sapphire = '#85C1DC',
  blue = '#8CAAEE',
  lavender = '#BABBF1',

  text = '#c6d0f5',
  subtext1 = '#b5bfe2',
  subtext0 = '#a5adce',
  overlay2 = '#949cbb',
  overlay1 = '#838ba7',
  overlay0 = '#737994',
  surface2 = '#626880',
  surface1 = '#51576d',
  surface0 = '#414559',

  base = '#303446',
  mantle = '#292C3C',
  crust = '#232634',
}

mode_color = function()
  local mode_colors = {
    n = '#8CAAEE',
    i = '#A6D189',
    v = '#CA9EE6',
    [''] = '#CA9EE6',
    V = '#CA9EE6',
    c = '#EF9F76',
    no = '#8CAAEE',
    s = '#CA9EE6',
    S = '#CA9EE6',
    [''] = '#CA9EE6',
    ic = '#A6D189',
    R = '#F4B8E4',
    Rv = '#F4B8E4',
    cv = '#EF9F76',
    ce = '#EF9F76',
    r = '#F4B8E4',
    rm = '#8CAAEE',
    ['r?'] = '#8CAAEE',
    ['!'] = '#c6d0f5',
    t = '#c6d0f5',
  }

  local color = mode_colors[vim.fn.mode()]

  if color == nil then
    color = '#E78284'
  end

  return color
end

local window_width_limit = 100

local hide_in_width = function()
  return vim.o.columns > window_width_limit
end

-- Find here: https://github.com/benfrain/neovim/blob/main/lua/setup/lualine.lua
-- Make a global table
wordCount = {}
-- Now add a function to it for the job needed
function wordCount.getWords()
  if vim.bo.filetype == 'md' or vim.bo.filetype == 'txt' or vim.bo.filetype == 'markdown' then
    if vim.fn.wordcount().visual_words == 1 then
      return tostring(vim.fn.wordcount().visual_words) .. ' word'
    elseif not (vim.fn.wordcount().visual_words == nil) then
      return tostring(vim.fn.wordcount().visual_words) .. ' words'
    else
      return tostring(vim.fn.wordcount().words) .. ' words'
    end
  else
    return 'Not a text file'
  end
end

return {

  theme = {
    normal = {
      a = { fg = '#949cbb', bg = '#414559' },
      b = { fg = '#949cbb', bg = '#414559' },
      c = { fg = '#949cbb', bg = '#414559' },
    },

    -- insert = { a = { fg = colors.black, bg = colors.blue } },
    -- visual = { a = { fg = colors.black, bg = colors.cyan } },
    -- replace = { a = { fg = colors.black, bg = colors.red } },

    inactive = {
      a = { fg = '#949cbb', bg = '#414559' },
      b = { fg = '#949cbb', bg = '#414559' },
      c = { fg = '#949cbb', bg = '#414559' },
    },
  },

  mode = {
    'mode',
    color = function()
      -- auto change color according to neovims mode
      return { fg = mode_color(), bg = '#414559', gui = 'bold' }
    end,
    fmt = function(str)
      if str == 'NORMAL' then
        -- return '=^..^='
        -- return '(=^..^=)'
        -- return '(^◔ᴥ◔^)'
        return '(^..^)ﾉ'
      end
      return str
    end,
    padding = 1,
    cond = nil,
  },

  branch = {
    -- vim-fugitive
    -- "FugitiveHead",
    -- gitsigns.nvim
    'b:gitsigns_head',
    icon = '',
    padding = 1,
  },

  filename = {
    'filename',
    color = { fg = '#b5bfe2', bg = '#303446' },
    cond = nil,
  },

  diff = {
    'diff',
    symbols = {
      added = icons.git.added,
      modified = icons.git.modified,
      removed = icons.git.removed,
    },
    source = function()
      local gitsigns = vim.b.gitsigns_status_dict
      if gitsigns then
        return {
          added = gitsigns.added,
          modified = gitsigns.changed,
          removed = gitsigns.removed,
        }
      end
    end,
  },

  diagnostics = {
    'diagnostics',
    sources = { 'nvim_workspace_diagnostic' },
    -- sources = { 'nvim_diagnostic' },
    symbols = {
      error = icons.diagnostics.Error,
      warn = icons.diagnostics.Warn,
      info = icons.diagnostics.Info,
      hint = icons.diagnostics.Hint,
    },
    always_visible = true,
  },

  treesitter = {

    function()
      return ''
    end,
    color = function()
      local buf = vim.api.nvim_get_current_buf()
      local ts = vim.treesitter.highlighter.active[buf]
      return { fg = ts and not vim.tbl_isempty(ts) and '#A6D189' or '#E78284' }
    end,
    cond = hide_in_width,
  },

  location = {
    'location',
    padding = { left = 1, right = 0 },
  },

  progress = {
    'progress',
    separator = ' ',
    padding = { left = 1, right = 0 },
    -- 'progress',
    -- fmt = function()
    --   return '%P/%L'
    -- end,
    -- color = {},
  },

  spaces = {
    function()
      local shiftwidth = vim.api.nvim_get_option_value('shiftwidth', { buf = 0 })
      return icons.ui.Tab .. ' ' .. shiftwidth
      -- return " " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
    end,
  },

  -- Function to get the number of open buffers using the :ls command
  bufcount = {
    function()
      return '(' .. vim.fn.len(vim.fn.getbufinfo { buflisted = 1 }) .. ')'
    end,
    color = { fg = '#85C1DC', bg = '#303446' },
  },

  dap = {
    function()
      return '  ' .. require('dap').status()
    end,
    cond = function()
      return package.loaded['dap'] and require('dap').status() ~= ''
    end,
    color = { fg = '#f4b8e4' },
    -- color = function()
    --   return { fg = Snacks.util.color 'Debug' }
    -- end,
  },

  filetype = {
    'filetype',
    separator = '',
    padding = { left = 1, right = 0 },
    -- 'filetype',
    icons_enabled = false,
    -- icon = nil,
  },

  encoding = {
    'o:encoding',
    fmt = string.upper,
    color = {},
    cond = hide_in_width,
  },

  lsp = {
    function()
      local msg = 'LS Inactive' -- 'No Active Lsp'
      local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
      local clients = vim.lsp.get_clients()
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
    color = { gui = 'bold' },
    cond = hide_in_width,
  },

  lsp_new = {
    'lsp_status',
    -- icon = ' ', -- f013
    icon = '󰐱', -- 
    symbols = {

      -- Standard unicode symbols to cycle through for LSP progress:
      spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
      -- Standard unicode symbol for when LSP is done:
      done = '✓',
      -- Delimiter inserted between LSP names:
      separator = ' ',
    },
    -- List of LSP names to ignore (e.g., `null-ls`):
    ignore_lsp = {},
  },

  linters = {
    function()
      local linters = require('lint').get_running()
      if #linters == 0 then
        return ''
      end
      return ' ' .. table.concat(linters, ', ')
    end,
  },

  formatters = {
    function()
      local formatters, is_lsp_formater_used = require('conform').list_formatters_to_run()
      -- print(formatters[1].name)
      -- print(lsp_formater_use)
      if is_lsp_formater_used then
        return ' ' .. 'LSP'
      end
      if #formatters == 0 then
        return '󱝱 '
      end
      return ' ' .. formatters[1].name
    end,
  },

  wcount = {
    wordCount.getWords,
    -- color = { fg = "#333333", bg = "#eeeeee" },
    -- separator = { left = "", right = "" },
    cond = function()
      return wordCount.getWords() ~= 'Not a text file'
    end,
  },

  windsurf = {
    function()
      local status = require('codeium.virtual_text').status()

      if status.state == 'idle' then
        -- Output was cleared, for example when leaving insert mode
        return ''
      end

      if status.state == 'waiting' then
        -- Waiting for response
        -- return "Waiting..."
        return '...'
      end

      if status.state == 'completions' and status.total > 0 then
        return string.format('%d/%d', status.current, status.total)
      end

      return '0'
      -- return status.state
      -- return require('codeium.virtual_text').status_string()
    end,
    color = { fg = color_palette.mauve },
    fmt = function(name, context)
      return '  ' .. name
    end,
  },

  kulala = {
    function()
      -- NOTE: This function is only available if you are using a http-client.env.json file.
      local env = require('kulala').get_selected_env()
      local icon = require('kulala.config').options.icons.lualine or '󰖟'
      return icon .. ' ' .. env
    end,
  },

  rest = {
    'rest',
    icon = '',
    fmt = function(path)
      if path == '' then
        return '󱋙 '
      end
      -- Extract the part of a string after the last /
      -- Often referred to as the basename of a path
      -- return path:match '^.+/(.+)$' or path
      -- Extarct the parent directory name + the file name
      return '󰌪 ' .. path:match '.*/([^/]+/[^/]+)$' or path
    end,
    cond = function()
      return package.loaded['rest']
    end,
  },
  -- Source: https://git.0x7be.net/dirk/neovim-config/src/branch/main/after/plugin/lualine.lua
  -- Get spelling language
  --
  -- When there are multiple spelling languages set, the languages are separated
  -- using a slash like `en/de/it`. If there is one language set then just the
  -- language is returned. If the spelling language was explicitly unset, `--`
  -- is returned instead.
  --
  -- If spell checking is disabled (`vim.opt.spell` being anything but `true` or
  -- involking `:setlocal nospell`) then `[]` is returned to keep visual balance
  -- in the status line.
  --
  -- @return string The spelling language(s) or replacement string as described
  -- get_spellang = {
  --   function()
  --     local lang = table.concat(vim.opt_local.spelllang:get(), '/')
  --     -- remove underscores en_us -> en
  --     local short = lang:match '^[^_-]+' or lang
  --     return '󰓆 ' .. (short == '' and '--' or short)
  --   end,
  --   cond = function()
  --     return vim.wo.spell
  --   end,
  -- },
  get_spellang = {
    function()
      if vim.opt.spell:get() ~= true then
        return '[]'
      end
      local lang = table.concat(vim.opt_local.spelllang:get(), '/')
      return '󰓆 ' .. (lang == '' and '--' or lang)
    end,
    cond = function()
      return vim.wo.spell
    end,
  },

  -- get_spellang = {
  --   function()
  --     local langs = vim.opt_local.spelllang:get()
  --
  --     for i, lang in ipairs(langs) do
  --       langs[i] = lang:match '^[^_-]+' or lang
  --     end
  --
  --     return '󰓆 ' .. (#langs > 0 and table.concat(langs, '/') or '--')
  --   end,
  --
  --   cond = function()
  --     return vim.wo.spell
  --   end,
  -- },

  -- Based on: https://github.com/Civitasv/cmake-tools.nvim/blob/master/docs/howto.md#mimic-ui-of-cmake-tools-toolbar-in-visual-studio-code
  cmake_preset = {
    function()
      local c_preset = cmake.get_configure_preset()
      return '󰔷 [' .. (c_preset and c_preset or 'X') .. ']' -- 󱁤
    end,
    cond = function()
      return cmake.is_cmake_project() and cmake.has_cmake_preset()
    end,
    on_click = function(n, mouse)
      if n == 1 then
        if mouse == 'l' then
          -- CMakeSelectConfigurePreset command selects a configure preset from CMakePresets.json.
          vim.cmd 'CMakeSelectConfigurePreset'
        end
      end
    end,
  },
  cmake_build_preset = {
    function()
      local b_preset = cmake.get_build_preset()
      local b_target = cmake.get_build_target()[1]
      return ' [' .. (b_preset and b_preset or 'X') .. ']:' .. (b_target and b_target or 'X') -- 󰀻  
    end,
    cond = function()
      return cmake.is_cmake_project() and cmake.has_cmake_preset()
    end,
    on_click = function(n, mouse)
      if n == 1 then
        if mouse == 'l' then
          -- CMakeSelectConfigurePreset command selects a configure preset from CMakePresets.json.
          vim.cmd 'CMakeSelectBuildPreset'
        end
      end
    end,
  },
  cmake_build_target = {
    function()
      local b_target = cmake.get_build_target()[1]
      -- return b_target[1]
      return '[' .. (b_target and b_target or 'X') .. ']'
    end,
    cond = cmake.is_cmake_project,
    on_click = function(n, mouse)
      if n == 1 then
        if mouse == 'l' then
          vim.cmd 'CMakeSelectBuildTarget'
        end
      end
    end,
  },
  cmake_target = {
    function()
      local l_target = cmake.get_launch_target()
      return ' ' .. (l_target and l_target or 'X') --  ▶
    end,
    cond = cmake.is_cmake_project,
    on_click = function(n, mouse)
      if n == 1 then
        if mouse == 'l' then
          vim.cmd 'CMakeSelectLaunchTarget'
        end
      end
    end,
  },
}
