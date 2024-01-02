local gl = require('galaxyline')
local condition = require('galaxyline.condition')
local gls = gl.section
gl.short_line_list = {'NvimTree', 'vista', 'dbui', 'packer'}

-- Nord theme
--
-- name		dark	light
-- black	0	    8
-- red		1	    9
-- green	2	    10
-- yellow	3	    11
-- blue		4	    12
-- purple	5	    13
-- cyan		6	    14
-- white	7	    15
local clrs = {
    nord0 = "#2E3440",  -- background
    nord1 = "#3B4252",  -- black
    nord2 = "#434C5E",
    nord3 = "#4C566A",  -- black
    nord3_bright = "#616E88",
    nord4 = "#D8DEE9",  -- foreground
    nord5 = "#E5E9F0",  -- white
    nord6 = "#ECEFF4",  -- white
    nord7 = "#8FBCBB",  -- cyan
    nord8 = "#88C0D0",  -- cyan
    nord9 = "#81A1C1",  -- blue
    nord10 = "#5E81AC",
    nord11 = "#BF616A", -- red
    nord12 = "#D08770",
    nord13 = "#EBCB8B", -- yellow
    nord14 = "#A3BE8C", -- green
    nord15 = "#B48EAD"  -- magenta
}

local colors = {
--    a_bg = mode_colors[vim.fn.mode()],
    b_bg = "#3B4252",
    c_bg = "#4C566A",
    fg =  "#A5ABB6", -- dim_foreground from nord-alacritty 
    bg = "#3B4252",
    black = "#4C566A",
    white = "#ECEFF4",
    darkblue = "#5E81AC",
    cyan = "#88C0D0",
    green = "#A3BE8C",
    blue = "#81A1C1",
    magenta = "#B48EAD",
    orange = "#D08770",
    red = "#BF616A",
    violet = "#B48EAD",
    yellow = "#EBCB8B"
}

--local clrs = vim.fn.NordPalette()
--print(clrs.nord3)

-- auto change color according the vim mode
local mode_color = function ()
    local mode_colors = {
        n = colors.cyan, -- +
        i = colors.white, -- +
        v = colors.darkblue, -- +
        [''] = colors.darkblue, -- +
        V = colors.darkblue, -- +
        c = colors.orange, -- +
        no = colors.cyan, -- +
        s = colors.magenta,
        S = colors.magenta,
        [''] = colors.magenta,
        ic = colors.white, -- +
        R = colors.yellow, -- +
        Rv = colors.yellow, -- +
        cv = colors.orange, -- +
        ce = colors.orange, -- +
        r = colors.yellow,
        rm = colors.cyan,
        ['r?'] = colors.cyan,
        ['!'] = colors.green,
        t = colors.green
   }

  local color = mode_colors[vim.fn.mode()]

  if color == nil then
    color = colors.red
  end

  return color
end

gls.left[1] = {
    ViMode = {
        provider = function()
            local alias = {
                n = 'NORMAL',-- Normal, Terminal-Normal
                no = 'OPERATOR-PENDING', --  Operator-pending
--                nov      Operator-pending (forced characterwise o_v)
--                noV      Operator-pending (forced linewise o_V)
--                noCTRL-V Operator-pending (forced blockwise o_CTRL-V);
--                                CTRL-V is one character
--                niI      Normal using i_CTRL-O in Insert-mode
--                niR      Normal using i_CTRL-O in Replace-mode
--                niV      Normal using i_CTRL-O in Virtual-Replace-mode
                v = 'VISUAL', -- Visual by character
                V = 'VISUAL-LINE', -- Visual by line
                ['']  = 'VISUAL-BLOCK', -- CTRL-V   Visual blockwise
                s = 'SELECT', -- Select by character
                S = 'SELECT-LINE', -- Select by line
                [''] = 'S-BLOCK',  -- CTRL-S   Select blockwise
                i = 'INSERT', -- Insert
                ic = 'INSERT-COMPLETE',      -- Insert mode completion compl-generic
--                ix       Insert mode i_CTRL-X completion
                R = 'REPLACE',      --  Replace R
--                Rc       Replace mode completion compl-generic
                Rv = 'VIRTUAL-REPLACE', --  Virtual Replace gR
--                Rx       Replace mode i_CTRL-X completion
                c = 'COMMAND-LINE', -- Command-line editing
                cv = 'VIM-EX', -- Vim Ex mode gQ
                ce = 'NORMAL-EX',-- Normal Ex mode Q
                ['r']  = 'HIT-ENTER', -- r      Hit-enter prompt
                rm = '--MORE', -- The -- more -- prompt
                ['r?'] = ':CONFIRM', -- r?      A :confirm query of some sort
                ['!']  = 'SHELL', -- !       Shell or external command is executing
                t  = 'TERMINAL' --  Terminal-Job mode: keys go to the job
            }
            vim.api.nvim_command('hi GalaxyViMode guifg=' .. mode_color())
            local alias_mode = alias[vim.fn.mode()]
            if alias_mode == nil then
                alias_mode = vim.fn.mode()
            end
            return '  ' ..alias_mode..' '
        end,
--        icon = '▊',
        highlight = {colors.bg, colors.bg}
--        highlight = {colors.black, 'NONE', "bold"}
    }
}


print(vim.fn.getbufvar(0, 'ts'))
vim.fn.getbufvar(0, 'ts')

gls.left[2] = {
    GitIcon = {
        provider = function()
            return '  ' -- '
        end,
        condition = condition.check_git_workspace,
        separator = ' ',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.fg, colors.bg}
    }
}

gls.left[3] = {
    GitBranch = {
        provider = 'GitBranch',
        condition = condition.check_git_workspace,
        separator = ' ',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.fg, colors.bg}
    }
}

gls.left[4] = {
    DiffAdd = {
        provider = 'DiffAdd',
        condition = condition.hide_in_width,
        icon = ' +', --'  ',
        highlight = {colors.green, colors.bg}
    }
}
gls.left[5] = {
    DiffModified = {
        provider = 'DiffModified',
        condition = condition.hide_in_width,
        icon = ' ~', --' 柳',
        highlight = {colors.yellow, colors.bg}
    }
}
gls.left[6] = {
    DiffRemove = {
        provider = 'DiffRemove',
        condition = condition.hide_in_width,
        icon = ' -', --'  ',
        highlight = {colors.red, colors.bg}
    }
}

-- gls.right[1] = {
--     DiagnosticError = {provider = 'DiagnosticError', icon = '  ', highlight = {colors.red, colors.bg}}
-- }
-- gls.right[2] = {DiagnosticWarn = {provider = 'DiagnosticWarn', icon = '  ', highlight = {colors.yellow,colors.bg}}}

-- gls.right[3] = {
--     DiagnosticHint = {provider = 'DiagnosticHint', icon = '  ', highlight = {colors.darkblue, colors.bg}}
-- }
--
-- gls.right[4] = {DiagnosticInfo = {provider = 'DiagnosticInfo', icon = '  ', highlight = {colors.cyan, colors.bg}}}

gls.right[5] = {
    ShowLspClient = {
        provider = 'GetLspClient',
        condition = function()
            local tbl = {['dashboard'] = true, [' '] = true}
            if tbl[vim.bo.filetype] then return false end
            return true
        end,
        icon = ' ',
        highlight = {colors.fg, colors.bg}
    }
}

gls.right[6] = {
    LineInfo = {
        provider = 'LineColumn',
        separator = '  ',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.fg, colors.bg}
    }
}

gls.right[7] = {
    PerCent = {
        provider = 'LinePercent',
        separator = ' ',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.fg, colors.bg}
    }
}

gls.right[8] = {
    Tabstop = {
        provider = function()
            return "Spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth") .. " "
        end,
        condition = condition.hide_in_width,
        separator = ' ',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.fg, colors.bg}
    }
}

gls.right[9] = {
    BufferType = {
        provider = 'FileTypeName',
        condition = condition.hide_in_width,
        separator = ' ',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.fg, colors.bg}
    }
}

gls.right[10] = {
    FileEncode = {
        provider = 'FileEncode',
        condition = condition.hide_in_width,
        separator = ' ',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.fg, colors.bg}
    }
}

gls.right[11] = {
    Space = {
        provider = function()
            return ' '
        end,
        separator = ' ',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.fg, colors.bg}
    }
}

gls.short_line_left[1] = {
    BufferType = {
        provider = 'FileTypeName',
        separator = ' ',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.fg, colors.bg}
    }
}

gls.short_line_left[2] = {
    SFileName = {provider = 'SFileName', condition = condition.buffer_not_empty, highlight = {colors.fg, colors.bg}}
}

gls.short_line_right[1] = {BufferIcon = {provider = 'BufferIcon', highlight = {colors.fg, colors.bg}}}
