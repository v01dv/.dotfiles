-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Silent keymap option
local opts = { silent = true }

-- Disable arrow keys (vi muscle memory)
vim.keymap.set('n', '<up>', "<cmd> :echoerr 'Umm, use k instead'<CR>", opts)
vim.keymap.set('n', '<down>', "<cmd> :echoerr 'Umm, use j instead'<CR>", opts)
vim.keymap.set('n', '<left>', "<cmd> :echoerr 'Umm, use h instead'<CR>", opts)
vim.keymap.set('n', '<right>', "<cmd> :echoerr 'Umm, use l instead'<CR>", opts)

vim.keymap.set('i', '<up>', '<NOP>', opts)
vim.keymap.set('i', '<down>', '<NOP>', opts)
vim.keymap.set('i', '<left>', '<NOP>', opts)
vim.keymap.set('i', '<right>', '<NOP>', opts)

-- Better up/down for dealing with word wrap
vim.keymap.set({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
vim.keymap.set({ 'n', 'x' }, '<Down>', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
vim.keymap.set({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })
vim.keymap.set({ 'n', 'x' }, '<Up>', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })

-- Better window navigation
-- NOTE: Commented because use christoomey/vim-tmux-navigator plugin
-- which allow to have Ctrl-hjkl navigation in tmux and nvim simultaneously
-- vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
-- vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
-- vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
-- vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

-- Resize window using <ctrl> arrow keys
vim.keymap.set('n', '<C-Up>', ':resize +2<CR>', { desc = 'Increase Window Height' })
vim.keymap.set('n', '<C-Down>', ':resize -2<CR>', { desc = 'Decrease Window Height' })
vim.keymap.set('n', '<C-Left>', '<CMD>vertical resize -2<CR>', { desc = 'Decrease Window Width' })
vim.keymap.set('n', '<C-Right>', '<CMD>vertical resize +2<CR>', { desc = 'Increase Window Width' })

-- windows
vim.keymap.set('n', '<leader>-', '<C-W>s', { desc = 'Split Window Below', remap = true })
vim.keymap.set('n', '<leader>|', '<C-W>v', { desc = 'Split Window Right', remap = true })
vim.keymap.set('n', '<leader>wd', '<C-W>c', { desc = 'Delete Window', remap = true })

-- Move Lines
vim.keymap.set('n', '<A-j>', "<cmd>execute 'move .+' . v:count1<cr>==", { desc = 'Move Down' })
vim.keymap.set('n', '<A-k>', "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = 'Move Up' })
vim.keymap.set('i', '<A-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move Down' })
vim.keymap.set('i', '<A-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move Up' })
vim.keymap.set('v', '<A-j>', ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = 'Move Down' })
vim.keymap.set('v', '<A-k>', ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = 'Move Up' })

-- Add undo break-points
vim.keymap.set('i', ',', ',<c-g>u')
vim.keymap.set('i', '.', '.<c-g>u')
vim.keymap.set('i', ';', ';<c-g>u')

-- Faster save
vim.keymap.set({ 'i', 'x', 'n', 's' }, '<C-s>', '<cmd>update<cr>', { silent = true, desc = 'Save file' })

-- vim.keymap.set('n', '<leader>qq', '<cmd>qa<cr>', { desc = 'Quit All' })

--keywordprg
vim.keymap.set('n', '<leader>K', '<cmd>norm! K<cr>', { desc = 'Keywordprg' })

-- Better indenting
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- Commenting
vim.keymap.set('n', 'gco', 'o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'Add Comment Below' })
vim.keymap.set('n', 'gcO', 'O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'Add Comment Above' })

-- New file
vim.keymap.set('n', '<leader>fn', '<cmd>enew<cr>', { desc = 'New File' })

-- Lazy
vim.keymap.set('n', '<leader>L', '<cmd>Lazy<cr>', { desc = 'Lazy' })

-- location list
vim.keymap.set('n', '<leader>xl', function()
  local success, err = pcall(vim.fn.getloclist(0, { winid = 0 }).winid ~= 0 and vim.cmd.lclose or vim.cmd.lopen)
  if not success and err then
    vim.notify(err, vim.log.levels.ERROR)
  end
end, { desc = 'Location List' })

-- quickfix list
vim.keymap.set('n', '<leader>xq', function()
  local success, err = pcall(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and vim.cmd.cclose or vim.cmd.copen)
  if not success and err then
    vim.notify(err, vim.log.levels.ERROR)
  end
end, { desc = 'Quickfix List' })

-- vim.keymap.set("n", "<C-q>", ":call QuickFixToggle()<CR>")
-- ThePrimagen keybindings:
-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- diagnostic
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go { severity = severity }
  end
end
vim.keymap.set('n', '<leader>cd', vim.diagnostic.open_float, { desc = 'Line Diagnostics' })
vim.keymap.set('n', ']d', diagnostic_goto(true), { desc = 'Next Diagnostic' })
vim.keymap.set('n', '[d', diagnostic_goto(false), { desc = 'Prev Diagnostic' })
vim.keymap.set('n', ']e', diagnostic_goto(true, 'ERROR'), { desc = 'Next Error' })
vim.keymap.set('n', '[e', diagnostic_goto(false, 'ERROR'), { desc = 'Prev Error' })
vim.keymap.set('n', ']w', diagnostic_goto(true, 'WARN'), { desc = 'Next Warning' })
vim.keymap.set('n', '[w', diagnostic_goto(false, 'WARN'), { desc = 'Prev Warning' })

-- Diagnostic keymaps in
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setqflist, { desc = 'Open diagnostic [Q]uickfix list' })
-- Diagnostic keymaps

-- https://github.com/kien5436/kickstart.nvim/blob/stable/lua/keymaps.lua#L8
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list', noremap = true })
-- vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Open floating [d]iagnostic', noremap = true })

--------------------------------------------------------------------------------
-- theprimeagen
-- Details: https://www.youtube.com/watch?v=w7i4amO_zaE
vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('n', '<C-d>', '<C-d>zz', opts)
vim.keymap.set('n', '<C-u>', '<C-u>zz', opts)

-- Center view on next search
vim.keymap.set('n', 'n', 'nzzzv', opts)
vim.keymap.set('n', 'N', 'Nzzzv', opts)
vim.keymap.set('n', '*', '*zz', opts)
vim.keymap.set('n', '#', '#zz', opts)

-- Better paste
vim.keymap.set('x', '<leader>p', '"_dP', { desc = 'Paste replace visual selection without copying it' })
-- vim.keymap.set({ 'n', 'x' }, '<leader>p', '"+p', { desc = 'Paste from system clipboard after the cursor position' })
-- vim.keymap.set({ 'n', 'x' }, '<leader>P', '"+P', { desc = 'Paste from system clipboard before the cursor position' })

-- Easier interaction with the system clipboard
-- "*y or "+y -> yank visual area into paste buffer
vim.keymap.set({ 'n', 'x' }, '<leader>y', '"+y', { desc = 'Copy to system clipboard' })
vim.keymap.set('n', '<leader>Y', '"+Y', { desc = 'Yank the entire current line, just like yy' })

-- Better yank behaviour
-- yank to the end of the current line (but don't yank the newline character)
-- " Make "Y" act like "D" and "C", to yank until end of line.
vim.keymap.set('n', 'Y', 'y$', { desc = "Yank to the end of the current line (but don't yank the newline character)" })

-- delete without destroying default buffer contents
-- "_d -> what you've ALWAYS wanted. Means: delete without saving the deleted text to any register (i.e., do not yank it).
-- "_ -> Is black hole register. Anything sent here is discarded, not saved.
vim.keymap.set('n', '<leader>d', '"_d', opts)
vim.keymap.set('x', '<leader>d', '"_d', opts)

vim.keymap.set('n', '<C-f>', '<cmd>silent !tmux neww tmux-sessionizer<CR>')
vim.keymap.set({ 'n', 'v' }, '<leader>sr', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>', { desc = 'Search and Replace' })

-- This is going to get me cancelled
vim.keymap.set('i', '<C-c>', '<Esc>', opts) -- Ctrl+[ also do Esc

-- Remove annoying exmode
-- FIX: This not remove exmode. If you hit the q, then wait a second, then hit the :, you're still in the command line
-- window. Also, if you hit q then :q, it eats the first two characters, leaving you with another q just waiting to
-- ambush you.
-- These shortcuts are hardcoded, they do not go by the rules other shortcuts follow. It's inconsistent behavior.
-- Details: https://www.reddit.com/r/neovim/comments/15bvtr4/what_is_that_command_line_mode_where_i_see_the/
vim.keymap.set('n', 'Q', '<Nop>')
vim.keymap.set('n', 'q:', '<Nop>')
--------------------------------------------------------------------------------
-- Save key strokes (now we do not need to press shift to enter command mode).
vim.keymap.set({ 'n', 'x', 'v' }, ';', ':')
vim.keymap.set({ 'n', 'x', 'v' }, ':', ';')

-- Easy insertion of a trailing ; or , from insert mode
vim.keymap.set('i', ';;', '<Esc>A;<Esc>')
vim.keymap.set('i', ',,', '<Esc>A,<Esc>')

-- yank all in buffer
vim.keymap.set('n', '<leader>A', ':%y<cr>', { noremap = false, silent = true, desc = 'Yank entire buffer' })
--------------------------------------------------------------------------------
-- toggle options

-- Spell-check set to <leader>o, 'o' for 'orthography':
-- vim.keymap.set('n', '<F11>', ':setlocal spell! spelllang=en_us<cr>', { desc = 'Toggle spelling' })
vim.keymap.set('n', ']os', ':setlocal spell! spelllang=en_us<cr>', { desc = 'Toggle spelling' })
-- Use spelling for markdown files ‘]s’ to find next, ‘[s’ for previous, 'z=‘ for suggestions when on one.

vim.keymap.set('n', ']oh', '<cmd>nohlsearch<cr>', opts) -- Clear hlsearch

vim.keymap.set('n', ']od', function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = 'Toggle Inline Diagnostics' })
--------------------------------------------------------------------------------

vim.keymap.set('', 'gf', ':edit <cfile><CR>', { desc = 'Allow gf to open non-existent files' })

-- Open the current file in the default program (on Mac this should just be just `open`)
-- vim.keymap.set('n', '<leader>r', ':!xdg-open %<cr><cr>')

vim.keymap.set('n', '<leader>C', ':w! | !compiler "%:p"<CR>', { desc = 'Compile document, be it groff/LaTeX/markdown/etc' })
vim.keymap.set('n', '<leader>r', ':!opout "%:p"<CR><CR>', { desc = 'Open corresponding .pdf/.html or preview' })

-- https://github.com/lukas-reineke/dotfiles/blob/master/vim/lua/mappings.lua
-- map("n", leader .. "gn", ":lua require('lists').change_active('Quickfix')<CR>:VcsJump merge<CR>")
-- map("n", leader .. "gh", ":diffget //2<CR> :diffupdate<CR>")
-- map("n", leader .. "gl", ":diffget //3<CR> :diffupdate<CR>")

-- https://github.com/SylvanFranklin/.config/blob/main/nvim/init.lua#L259
local function open_current_html()
  local path = vim.api.nvim_buf_get_name(0)
  if path == '' then
    vim.notify('Preview requires a saved HTML file', vim.log.levels.ERROR)
    return
  end

  vim.cmd.update()

  local result = vim.system({ 'xdg-open', path }, { text = true }):wait()
  if result.code ~= 0 then
    local output = result.stderr ~= '' and result.stderr or result.stdout
    if output == '' then
      output = 'Failed to open ' .. path
    end
    vim.notify(output, vim.log.levels.ERROR)
  end
end
local function preview_current_file()
  local filetype = vim.bo.filetype
  if filetype == 'typst' then
    vim.cmd.TypstPreview()
  elseif filetype == 'html' then
    open_current_html()
  else
    vim.notify('No preview action configured for filetype: ' .. filetype, vim.log.levels.WARN)
  end
end

vim.keymap.set('n', '<leader>cp', preview_current_file, { desc = 'Preview current file' })

vim.keymap.set('n', '<leader>q', function()
  print 'test'
  require('user.util.cmake').set_preset()
end, {
  desc = 'Select CMake preset',
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
