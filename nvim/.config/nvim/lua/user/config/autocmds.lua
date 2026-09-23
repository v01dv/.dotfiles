-- [[Demo] Lua Autocmds in Neovim (by the author of Lua Autocmds) - YouTube](https://www.youtube.com/watch?v=ekMIIAqTZ34)
local function augroup(name)
  return vim.api.nvim_create_augroup('ohvim_' .. name, { clear = true })
end

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
  group = augroup 'checktime',
  callback = function()
    if vim.o.buftype ~= 'nofile' then
      vim.cmd 'checktime'
    end
  end,
})

-- Highlight yanked text for 200ms
vim.api.nvim_create_autocmd({ 'TextYankPost' }, {
  group = augroup 'highlight_yank',
  callback = function()
    -- vim.highlight.on_yank()
    -- vim.highlight.on_yank { higroup = 'CurSearch', timeout = 200 }
    vim.highlight.on_yank { higroup = 'MyYankColor' }
  end,
})

vim.api.nvim_create_autocmd({ 'VimResized' }, {
  callback = function()
    vim.cmd 'tabdo wincmd ='
  end,
})

-- Go to last loction when opening a buffer
vim.api.nvim_create_autocmd('BufReadPost', {
  group = augroup 'last_loc',
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
      -- defer centering slightly so it's applied after render
      vim.schedule(function()
        vim.cmd 'normal! zz'
      end)
    end
  end,
})

-- Fixes Autocomment
vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
  group = augroup 'no_auto_comment',
  callback = function()
    -- vim.cmd 'set formatoptions-=cro'
    vim.opt_local.formatoptions:remove { 'c', 'r', 'o' }
  end,
})

-- syntax highlighting for dotenv files
vim.api.nvim_create_autocmd('BufRead', {
  group = vim.api.nvim_create_augroup('dotenv_ft', { clear = true }),
  pattern = { '.env', '.env.*' },
  callback = function()
    vim.bo.filetype = 'dosini'
  end,
})

-- Close windows from list by pressing <q> button
vim.api.nvim_create_autocmd({ 'FileType' }, {
  group = augroup 'close_with_q',
  pattern = {
    'netrw',
    'Jaq',
    'qf',
    'git',
    'help',
    'man',
    'lspinfo',
    'oil',
    'spectre_panel',
    'lir',
    'DressingSelect',
    'tsplayground',
    'checkhealth',
    'fugitive',
    'neotest-output',
    'neotest-summary',
    'neotest-output-panel',
    'query',
    'toggleterm',
    'notify',
    'vim',
    'dbout',
    'gitsigns-blame',
    'startuptime',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set('n', 'q', function()
        vim.cmd 'close'
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end, {
        buffer = event.buf,
        silent = true,
        desc = 'Quit buffer',
      })
    end)
  end,
})

-- make it easier to close man-files when opened inline
vim.api.nvim_create_autocmd('FileType', {
  group = augroup 'man_unlisted',
  pattern = { 'man' },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
  end,
})

-- wrap and check for spell in text filetypes
-- Use spelling for markdown files ‘]s’ to find next, ‘[s’ for previous, 'z=‘ for suggestions when on one.
vim.api.nvim_create_autocmd({ 'FileType' }, {
  group = augroup 'wrap_spell',
  pattern = { 'text', 'plaintex', 'typst', 'gitcommit', 'markdown' },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd({ 'FileType' }, {
  group = augroup 'json_conceal',
  pattern = { 'json', 'jsonc', 'json5' },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

-- Always opening Vim help in a vertical split window
vim.api.nvim_create_autocmd({ 'FileType' }, {
  group = augroup 'help_on_vertical_split',
  -- The pattern matches the buffer name, not the buffer type.
  -- Thats why we use if statement to check if the current buffer
  -- is a actual help buffer.
  pattern = 'help',
  callback = function()
    -- Checks is the current buffer a help buffer and
    -- total number of windows currently open > 1
    if vim.bo.buftype == 'help' and vim.fn.winnr '$' > 1 then
      vim.cmd 'wincmd L'
    end
  end,
})

-- FIX: This blocks Ctrl-F in command line for run command-line window (https://neovim.io/doc/user/cmdline.html#c_CTRL-F)
-- I don't know why I put this autocammand here.
-- vim.api.nvim_create_autocmd({ "CmdWinEnter" }, {
--   callback = function()
--     vim.cmd "quit"
--   end,
-- })

-- NOTE: Comment it because I am not sure is it needed anymore
-- Explained here: https://www.youtube.com/live/KGJV0n70Mxs?si=UtTYVARxpgi76gjC&t=13206
-- vim.api.nvim_create_autocmd({ 'CursorHold' }, {
--   callback = function()
--     local status_ok, luasnip = pcall(require, 'luasnip')
--     if not status_ok then
--       return
--     end
--     if luasnip.expand_or_jumpable() then
--       -- ask maintainer for option to make this silent
--       -- luasnip.unlink_current()
--       vim.cmd [[silent! lua require("luasnip").unlink_current()]]
--     end
--   end,
-- })

-- Remove whitespace at the end of line
-- NOTE: Comment it out because I am using autoformating via Comform plugin
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   group = augroup "space_remover",
--     pattern = "*",
--     command = [[%s/\s\+$//e]],
-- })

-- show cursor line only in active window
vim.api.nvim_create_autocmd({ 'InsertLeave', 'WinEnter' }, {
  callback = function()
    local ok, cl = pcall(vim.api.nvim_win_get_var, 0, 'auto-cursorline')
    if ok and cl then
      vim.wo.cursorline = true
      vim.api.nvim_win_del_var(0, 'auto-cursorline')
    end
  end,
})
vim.api.nvim_create_autocmd({ 'InsertEnter', 'WinLeave' }, {
  callback = function()
    local cl = vim.wo.cursorline
    if cl then
      vim.api.nvim_win_set_var(0, 'auto-cursorline', cl)
      vim.wo.cursorline = false
    end
  end,
})

-- set up file syntax for nunjucks
-- FIX: Replace it in proper place with:
-- vim.filetype.add({
--   extension = {
--     ["http"] = "http",
--   },
-- })
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  group = augroup 'nunjucks_syntax_highlighting',
  pattern = { '*.njk' },
  callback = function()
    vim.cmd [[set filetype=html]]
  end,
})
