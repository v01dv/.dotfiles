-- "
-- " indentLine
-- " https://github.com/BrodieRobertson/dotfiles/blob/master/config/nvim/plugconfig/indentline.vim
-- "
-- let g:indentLine_fileTypeExclude = ["vimwiki", "coc-explorer", "help", "undotree", "diff"]
-- let g:indentLine_bufTypeExclude = ["help", "terminal"]
-- "let g:indentLine_bufNameExclude = []
-- let g:indentLine_indentLevel = 10
--
-- " Conceal settings
-- "let g:indentLine_setConceal = 0    " Actually fix the annoying markdown links conversion
-- let g:indentLine_setConceal = 1
-- let g:indentLine_concealcursor = "incv"
-- let g:indentLine_conceallevel = 2
--
-- "let g:indentLine_char_list = ['|', '¦', '┆', '┊']
-- let g:indentLine_char_list = ['│']
--
-- " Details at https://github.com/arcticicestudio/nord-vim/issues/115
-- let g:indentLine_color_term = 0
-- let g:indentLine_bgcolor_term = "NONE"
-- let g:indentLine_color_gui = '#3b4252'
-- let g:indentLine_bgcolor_gui = 'NONE'
--

--  :help indent_blankline.txt
local status_ok, indent_blankline = pcall(require, "indent_blankline")
if not status_ok then
  return
end

vim.g.indent_blankline_show_first_indent_level = true
vim.g.indent_blankline_buftype_exclude = {'terminal', 'nofile'}
vim.g.indent_blankline_filetype_exclude = {
  "startify",
  "dashboard",
  "dotooagenda",
  "log",
  "fugitive",
  "gitcommit",
  "packer",
  "vimwiki",
  "markdown",
  "json",
  "txt",
  "vista",
  "help",
  "todoist",
  "NvimTree",
  "Trouble",
  "peekaboo",
  "git",
  "TelescopePrompt",
  "undotree",
  "flutterToolsOutline",
  'man',
  'help',
  'neogitstatus',
  ""
 }
vim.g.indentLine_enabled = 1
vim.g.indent_blankline_char = '▏'
vim.g.indent_blankline_use_treesitter = true
vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.g.indent_blankline_show_current_context = true
vim.g.indent_blankline_context_patterns = {
  "class",
  "return",
  "function",
  "method",
  "^if",
  "^while",
  "jsx_element",
  "^for",
  "^object",
  "^table",
  "block",
  "arguments",
  "if_statement",
  "else_clause",
  "jsx_element",
  "jsx_self_closing_element",
  "try_statement",
  "catch_clause",
  "import_statement",
  "operation_type",
}

-- HACK: work-around for https://github.com/lukas-reineke/indent-blankline.nvim/issues/59
vim.wo.colorcolumn = "99999"

-- vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]
-- vim.opt.list = true
-- vim.opt.listchars:append "space:⋅"
-- vim.opt.listchars:append "space:"
-- vim.opt.listchars:append "eol:↴"

indent_blankline.setup {
  -- show_end_of_line = true,
  -- space_char_blankline = " ",
  show_current_context = true,
  -- show_current_context_start = true,
  -- char_highlight_list = {
  --   "IndentBlanklineIndent1",
  --   "IndentBlanklineIndent2",
  --   "IndentBlanklineIndent3",
  -- },
}
