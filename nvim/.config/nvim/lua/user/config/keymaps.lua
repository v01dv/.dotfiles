-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Silent keymap option
local opts = { silent = true }

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Disable arrow keys (vi muscle memory)
vim.keymap.set("n", "<up>", "<cmd> :echoerr 'Umm, use k instead'<CR>", opts)
vim.keymap.set("n", "<down>", "<cmd> :echoerr 'Umm, use j instead'<CR>", opts)
vim.keymap.set("n", "<left>", "<cmd> :echoerr 'Umm, use h instead'<CR>", opts)
vim.keymap.set("n", "<right>", "<cmd> :echoerr 'Umm, use l instead'<CR>", opts)

vim.keymap.set("i", "<up>", "<NOP>", opts)
vim.keymap.set("i", "<down>", "<NOP>", opts)
vim.keymap.set("i", "<left>", "<NOP>", opts)
vim.keymap.set("i", "<right>", "<NOP>", opts)

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)
-- vim.keymap.set("n", "<Leader>q", ":q", opts) -- Quit current window
-- vim.keymap.set("n", "<Leader>w", ":wincmd w<cr>", opts) -- Switch beetwen windows

-- Resize buffer easier
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<C-Left>", "<CMD>vertical resize -2<CR>", opts)
vim.keymap.set("n", "<C-Right>", "<CMD>vertical resize +2<CR>", opts)

-- Buffers navigation
-- vim.keymap.set("n", "]b", ":bnext<CR>", opts) -- <S-l>
-- vim.keymap.set("n", "[b", ":bprevious<CR>", opts) -- <S-h>

-- Cybu
-- vim.keymap.set("n", "]b", "<Plug>(CybuNext)")
-- vim.keymap.set("n", "[b", "<Plug>(CybuPrev)")
-- Ctrl+6 (to switch between the previous files, a lot like Alt+Tab in a window manager),

-- Tab navigation
vim.keymap.set("n", "]t", ":tabnext<CR>", opts)
vim.keymap.set("n", "[t", ":tabprevious<CR>", opts)
vim.keymap.set("n", "]T", ":tablast<CR>", opts)
vim.keymap.set("n", "[T", ":tabfirst<CR>", opts)
-- vim.keymap.set("n", "<leader>n", ":tabnew<cr>", opts)

-- QuickFix
vim.keymap.set("n", "]q", ":cnext<CR>")
vim.keymap.set("n", "[q", ":cprev<CR>")
-- vim.keymap.set("n", "<C-q>", ":call QuickFixToggle()<CR>")
-- ThePrimagen keybindings:
-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Center view on next search
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)
vim.keymap.set("n", "*", "*zz", opts)
vim.keymap.set("n", "#", "#zz", opts)

vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)
vim.keymap.set("n", "J", "mzJ`z")

-- Insert --
-- I hate escape
-- vim.keymap.set("i", "jk", "<ESC><ESC>", opts)
-- vim.keymap.set("i", "kj", "<ESC><ESC>", opts)
-- vim.keymap.set("i", "jj", "<ESC><ESC>", opts)
-- vim.keymap.set("i", "JJ", "<Esc><Esc>", opts)

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>", opts) -- Ctrl+[ also do Esc

-- Visual --
-- Better indenting
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Visual Block --
-- Move selected line / block of text up and down
vim.keymap.set("x", "K", ":move '<-2<CR>gv=gv", opts)
vim.keymap.set("x", "J", ":move '>+1<CR>gv=gv", opts)

------------------------------------------------------------------------------------------
-- Yanking and pasting

-- Better yank behaviour
-- yank to the end of the current line (but don't yank the newline character)
-- " Make "Y" act like "D" and "C", to yank until end of line.
vim.keymap.set("n", "Y", "y$", opts)

-- "*y or "+y -> yank visual area into paste buffer
vim.keymap.set("n", "<leader>y", '"+y', opts)
vim.keymap.set("x", "<leader>y", '"+y', opts)
vim.keymap.set("n", "<leader>Y", '"+Y', opts)

-- delete without destroying default buffer contents
-- "_d -> what you've ALWAYS wanted
vim.keymap.set("n", "<leader>d", '"_d', opts)
vim.keymap.set("x", "<leader>d", '"_d', opts)
vim.keymap.set("n", "<leader>D", '"_D', opts)

-- yank all in buffer
vim.keymap.set("n", "<leader>A", ":%y<cr>", { noremap = false, silent = true, desc = "yank entire buffer" })

--Selects all content:
--gg moves to first line
-- V starts visual mode
--G jumps to last line thereby selecting from first to last line
--vim.keymap.set <leader>a ggVG

-- Better paste
-- Paste replace visual selection without copying it
vim.keymap.set("x", "<leader>p", '"_dP', opts)

-- vim.keymap.set("n", "<leader>p", '"+p', opts)
-- vim.keymap.set("x", "<leader>p", '"+p', opts)
-- vim.keymap.set("n", "<leader>P", '"+P', opts)
-- vim.keymap.set("x", "<leader>P", '"+P', opts)

-- remove annoying exmode
vim.keymap.set("n", "Q", "<Nop>")
vim.keymap.set("n", "q:", "<Nop>")

-- Spell-check set to <leader>o, 'o' for 'orthography':
vim.keymap.set("n", "<F11>", ":setlocal spell! spelllang=en_us<cr>", { desc = "Toggle spell" })

-- General
-- vim.keymap.set("n", "<leader>w", "<cmd>w!<cr>") -- Save

-- Shortcut for faster save and quit
vim.keymap.set("n", "<leader>w", "<cmd>update<cr>", { silent = true, desc = "save buffer" })


vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

-- vim.keymap.set("n", "<Leader><space>", "<cmd>nohlsearch<cr>", opts) -- Clear hlsearch
-- vim.keymap.set("n", "<leader>x", "<cmd>lua require('user.functions').smart_quit()<CR>", opts)

-- Allow gf to open non-existent files
vim.keymap.set('', 'gf', ':edit <cfile><CR>')

-- Easy insertion of a trailing ; or , from insert mode
vim.keymap.set('i', ';;', '<Esc>A;<Esc>')
vim.keymap.set('i', ',,', '<Esc>A,<Esc>')

-- Open the current file in the default program (on Mac this should just be just `open`)
-- vim.keymap.set('n', '<leader>r', ':!xdg-open %<cr><cr>')

vim.keymap.set("n", "<Leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<cr>", opts)

-- https://github.com/lukas-reineke/dotfiles/blob/master/vim/lua/mappings.lua
-- map("n", leader .. "gn", ":lua require('lists').change_active('Quickfix')<CR>:VcsJump merge<CR>")
-- map("n", leader .. "gh", ":diffget //2<CR> :diffupdate<CR>")
-- map("n", leader .. "gl", ":diffget //3<CR> :diffupdate<CR>")

-- Insert blank line
vim.keymap.set("n", "]<Space>", "o<Esc>")
vim.keymap.set("n", "[<Space>", "O<Esc>")

-- Save key strokes (now we do not need to press shift to enter command mode).
vim.keymap.set({ "n", "x" }, ";", ":")

-- Turn the word under cursor to upper case
vim.keymap.set("i", "<c-u>", "<Esc>viwUea")

-- Turn the current word into title case
vim.keymap.set("i", "<c-t>", "<Esc>b~lea")

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
