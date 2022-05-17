local g = vim.g
local cmd = vim.cmd

cmd('syntax on')

g.nord_uniform_status_lines = 1
g.nord_cursor_line_number_background = 1 --Enables background for the line number of the current line
g.nord_underline = 1
g.nord_italic = 1
g.nord_bold = 1
g.nord_italic_comments = 1 --Enable to italicize all comments
g.nord_uniform_diff_background = 1

cmd("colorscheme nord") --Set colorscheme
--cmd("colorscheme tokyonight")
