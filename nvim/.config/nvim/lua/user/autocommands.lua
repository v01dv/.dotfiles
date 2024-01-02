-- Use 'q' to quit from common plugins
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = {
    "Jaq",
    "qf",
    "help",
    "man",
    "lspinfo",
    "spectre_panel",
    "lir",
    "DressingSelect",
    "tsplayground",
    "Markdown",
  },
  callback = function()
    vim.cmd [[
      nnoremap <silent> <buffer> q :close<CR> 
      nnoremap <silent> <buffer> <esc> :close<CR> 
      set nobuflisted 
    ]]
  end,
})

-- Remove statusline and tabline when in Alpha
vim.api.nvim_create_autocmd({ "User" }, {
  pattern = { "AlphaReady" },
  callback = function()
    vim.cmd [[
      set laststatus=0 | autocmd BufUnload <buffer> set showtabline=2
      set laststatus=0 | autocmd BufUnload <buffer> set laststatus=3
    ]]
  end,
})

-- Set wrap and spell in markdown and gitcommit
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "lir" },
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end,
})

vim.cmd "autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif"

-- Fixes Autocomment
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  callback = function()
    vim.cmd "set formatoptions-=cro"
  end,
})

-- Highlight yanked text for 200ms
-- https://jdhao.github.io/2020/09/22/highlight_groups_cleared_in_nvim/
-- https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  pattern = { "*" },
  group = highlight_group,
  callback = function()
    -- vim.highlight.on_yank()
    -- vim.highlight.on_yank { higroup = highlight_group, timeout = 200 }
    vim.highlight.on_yank { higroup = "IncSearch", timeout = 200 }
  end,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "*.lua" },
  callback = function()
    vim.lsp.codelens.refresh()
  end,
})

-- vim.api.nvim_create_autocmd({ "VimEnter" }, {
--   callback = function()
--     vim.cmd "hi link illuminatedWord LspReferenceText"
--   end,
-- })


-- TODO: rewrite using new syntax
vim.cmd[[autocmd BufReadPost * lua goto_last_pos()]]
function goto_last_pos()
  local last_pos = vim.fn.line("'\"")
  if last_pos > 0 and last_pos <= vim.fn.line("$") then
    vim.api.nvim_win_set_cursor(0, {last_pos, 0})
  end
end

-- set up file syntax for nunjucks as html
-- https://github.com/LunarVim/LunarVim/discussions/2224
-- vim.api.nvim_create_autocmd({ "BufRead" }, {
--   pattern = { "*.njk", "*.ejs" },
--   callback = function()
--     vim.cmd "set filetype=html"
--   end,
-- })
--
-- vim.api.nvim_create_autocmd({ "BufNewFile" }, {
--   pattern = { "*.njk", "*.ejs" },
--   callback = function()
--     vim.cmd "set filetype=html"
--   end,
-- })
