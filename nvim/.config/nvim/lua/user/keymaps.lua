-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Silent keymap option
local opts = { silent = true }

-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " " -- 'vim.g' sets global variables
vim.g.maplocalleader = ' '

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

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
vim.keymap.set("n", "<S-x>", "<cmd>Bdelete!<cr>", opts)

-- Cybu
vim.keymap.set("n", "]b", "<Plug>(CybuNext)")
vim.keymap.set("n", "[b", "<Plug>(CybuPrev)")
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
vim.keymap.set("n", "<C-q>", ":call QuickFixToggle()<CR>")
-- ThePrimagen keybindings:
-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Center view on next search
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)

vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)
vim.keymap.set("n", "J", "mzJ`z")

-- Insert --
-- I hate escape
vim.keymap.set("i", "jk", "<ESC><ESC>", opts)
vim.keymap.set("i", "kj", "<ESC><ESC>", opts)
vim.keymap.set("i", "jj", "<ESC><ESC>", opts)
vim.keymap.set("i", "JJ", "<Esc><Esc>", opts)

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
vim.keymap.set("n", "<leader>a", ":%y<cr>", { noremap = false, silent = true })

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
vim.keymap.set("n", "<leader>o", ":setlocal spell! spelllang=en_us<cr>", opts)

-- General
vim.keymap.set("n", "<leader>w", "<cmd>w!<cr>") -- Save
vim.keymap.set("n", "<leader>n", ":NvimTreeToggle<cr>", opts)
vim.keymap.set("n", "<Leader>c", "<CMD>ColorizerToggle<CR>", opts)
vim.keymap.set("n", "<leader>/", require('Comment.api').toggle.linewise.current, opts)
vim.keymap.set("x", "<leader>/", '<esc><cmd>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<cr>')
vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

-- vim.keymap.set("n", "<Leader><space>", "<cmd>nohlsearch<cr>", opts) -- Clear hlsearch
-- vim.keymap.set("n", "<leader>x", "<cmd>lua require('user.functions').smart_quit()<CR>", opts)

-- Allow gf to open non-existent files
vim.keymap.set('', 'gf', ':edit <cfile><CR>')

-- vim.keymap.set("n", "<Leader>z", "<cmd>ZenMode<cr>")
-- vim.keymap.set("n", "<leader>;", "<cmd>Alpha<cr>") -- Dashboard

-- Easy insertion of a trailing ; or , from insert mode
vim.keymap.set('i', ';;', '<Esc>A;<Esc>')
vim.keymap.set('i', ',,', '<Esc>A,<Esc>')

-- Open the current file in the default program (on Mac this should just be just `open`)
-- vim.keymap.set('n', '<leader>r', ':!xdg-open %<cr><cr>')

-- vim.keymap.set("n", "-", ":lua require'lir.float'.toggle()<cr>")

-- Search
vim.keymap.set("n", "<leader>b", "<cmd>Telescope buffers<cr>", { desc = 'Find existing [b]uffers' })
vim.keymap.set("n", "<leader>sa", "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<cr>") -- Find all
vim.keymap.set("n", "<leader>sp", "<cmd>Telescope projects<cr>")
vim.keymap.set("n", "<leader>sk", "<cmd>Telescope keymaps<cr>")
vim.keymap.set("n", "<leader>sc", "<cmd>Telescope commands<cr>")
-- vim.keymap.set("n", "<leader>sH", "<cmd>Telescope highlights<cr>")
vim.keymap.set("n", "<leader>sm", "<cmd>Telescope marks<cr>") --Marks
vim.keymap.set("n", "<leader>sh", "<cmd>Telescope harpoon marks<cr>") --Marks
vim.keymap.set("n", "<leader>sM", "<cmd>Telescope man_pages<cr>") -- Man pages
vim.keymap.set('n', '<leader>so', "<cmd>Telescope oldfiles<cr>", { desc = '[?] Find recently opened files' })
vim.keymap.set("n", "<leader>sR", "<cmd>Telescope registers<cr>") -- Registers
vim.keymap.set("n", "<leader>sz", function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[s]earch fu[z]zily in current buffer]' })

vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[s]earch [f]iles' })
vim.keymap.set('n', '<leader>sH', require('telescope.builtin').help_tags, { desc = '[s]earch [h]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[s]earch [w]ord under cursor' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[s]earch by [g]rep' })

vim.keymap.set("n", "<leader>se", require("telescope").extensions.media_files.media_files, { silent = true })

-- Git
vim.keymap.set("n", "<leader>g", "<cmd>Git<cr>") -- Open changed file
vim.keymap.set("n", "<leader>go", "<cmd>Telescope git_status<cr>") -- Open changed file
vim.keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>") -- Checkout branch
vim.keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>") -- Checkout commit
vim.keymap.set("n", "<leader>gC", "<cmd>Telescope git_bcommits<cr>") -- Checkout commit(for current file)
vim.keymap.set("n", "<leader>gp", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>") -- Preview Hunk
vim.keymap.set("n", "<leader>gr", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>") -- Reset Hunk
vim.keymap.set("n", "<leader>gR", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>") -- Reset Buffer
vim.keymap.set("n", "<leader>gs", "<cmd>Gitsigns stage_hunk<cr>") -- Stage Hunk
vim.keymap.set("n", "<leader>gu", "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>") -- Undo Stage Hunk
vim.keymap.set("n", "<Leader>gd", "<cmd>lua require 'gitsigns'.diffthis('HEAD')<cr>")
vim.keymap.set("n", "<Leader>gl", "<cmd>lua require 'gitsigns'.toggle_current_line_blame()<cr>")
vim.keymap.set("n", "<Leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<cr>", opts)
vim.keymap.set("n", "]c",
  function() -- Next Hunk
    if vim.wo.diff then return ']c' end
    vim.schedule(function()  require("gitsigns").next_hunk() end)
    return '<Ignore>'
  end, {expr=true})
vim.keymap.set("n", "[c",
  function() -- Prev Hunk
    if vim.wo.diff then return '[c' end
    vim.schedule(function()  require("gitsigns").prev_hunk() end)
    return '<Ignore>'
  end, {expr=true})

-- [[ LSP ]]
vim.keymap.set('n', '<leader>sD', "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", { desc = '[s]earch> [d]iagnostics into current buffer'})
vim.keymap.set('n', '<leader>sd', "<cmd>Telescope diagnostics theme=get_ivy<cr>", { desc = '[s]earch [d]iagnostics into whole project'})
vim.keymap.set("n", "<Leader>lf", "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", { desc = 'Format current buffer with LSP' })
vim.keymap.set("n", "<leader>lt", "<cmd>lua require('user.functions').toggle_diagnostics()<cr>", opts)

-- [[ DAP ]]
-- vim.keymap.set("n", "<leader>b", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", { silent = true })
-- vim.keymap.set("n", "<leader>B", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
-- vim.keymap.set("n", "<leader>lp", "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>")
vim.keymap.set("n", "<F9>", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", { silent = true })
vim.keymap.set("n", "<F5>", "<cmd>lua require'dap'.continue()<cr>", { silent = true }) -- Start/Continue 
vim.keymap.set("n", "<F11>", "<cmd>lua require'dap'.step_into()<cr>", { silent = true })
vim.keymap.set("n", "<F10>", "<cmd>lua require'dap'.step_over()<cr>", { silent = true })
vim.keymap.set("n", "<F12>", "<cmd>lua require'dap'.step_out()<cr>", { silent = true }) -- <F23> = Shift+F11 -> https://github.com/neovim/neovim/issues/7384
vim.keymap.set("n", "<Leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", { silent = true })
vim.keymap.set("n", "<Leader>dl", "<cmd>lua require'dap'.run_last()<cr>", { silent = true })
vim.keymap.set("n", "<Leader>du", "<cmd>lua require'dapui'.toggle()<cr>", { silent = true })
vim.keymap.set("n", "<Leader>dx", "<cmd>lua require'dap'.terminate()<cr>", { silent = true }) -- Exit

-- Session
vim.keymap.set("n", "<Leader>Ss", "<CMD>SessionSave<CR>", { silent = true })
vim.keymap.set("n", "<Leader>Sl", "<CMD>SessionLoad<CR>", { silent = true })

-- Spectre
vim.keymap.set("n", "<Leader>rr", "<cmd>lua require('spectre').open()<cr>", { silent = true }) -- Replace
vim.keymap.set("n", "<Leader>rw", "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", { silent = true }) -- Replace current world
vim.keymap.set("n", "<Leader>rf", "<cmd>lua require('spectre').open_file_search()<cr>", { silent = true }) -- Replace in current file

-- Surround
-- TODO: Investigate keymaps into plugin config file. because described bellow doesn't work for some reason
-- vim.keymap.set("n", "<Leader>s.", "<cmd>lua require('nvim-surround').repeat_last()<cr>", { silent = true }) -- Repeat
-- vim.keymap.set("n", "<Leader>sa", "<cmd>lua require('nvim-surround').surround_add(true)<cr>", { silent = true }) -- Add
-- vim.keymap.set("n", "<Leader>sd", "<cmd>lua require('nvim-surround').surround_delete(true)<cr>", { silent = true }) -- Delete
-- vim.keymap.set("n", "<Leader>sr", "<cmd>lua require('nvim-surround').surround_replace(true)<cr>", { silent = true }) -- Replace
-- vim.keymap.set("n", "<Leader>sq", "<cmd>lua require('nvim-surround').toggle_quotes()<cr>", { silent = true }) -- Quotes
-- vim.keymap.set("n", "<Leader>sb", "<cmd>lua require('nvim-surround').toggle_brackets()<cr>", { silent = true }) -- Brackets

-- Surround
-- Examples:
-- saw" -> "word"
-- ds" or dsq -> word -- q means quote
--
-- TODO: Rewrite using vim.keymap.set
vim.cmd [[nmap <leader>' siw']]

-- Harpoon
vim.keymap.set("n", "<leader>a", "<cmd>lua require('harpoon.mark').add_file()<cr>", { silent = true }) -- Harpoon
vim.keymap.set("n", "-", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", { silent = true }) -- Harpoon UI
vim.keymap.set("n", "]m", "<cmd>lua require('harpoon.ui').nav_next()<cr>", { silent = true }) -- Harpoon next
vim.keymap.set("n", "[m", "<cmd>lua require('harpoon.ui').nav_prev()<cr>", { silent = true }) -- Harpoon prev

vim.keymap.set("n", "<C-1>", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", { silent = true })
vim.keymap.set("n", "<C-2>", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", { silent = true })
vim.keymap.set("n", "<C-3>", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", { silent = true })
vim.keymap.set("n", "<C-4>", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", { silent = true })

-- Bookmarks
vim.keymap.set("n", "ma", "<cmd>silent BookmarkAnnotate<cr>", { silent = true })
vim.keymap.set("n", "mc", "<cmd>silent BookmarkClear<cr>", { silent = true })
vim.keymap.set("n", "mx", "<cmd>silent BookmarkClearAll<cr>", { silent = true })
vim.keymap.set("n", "mb", "<cmd>silent BookmarkToggle<cr>", { silent = true })
vim.keymap.set("n", "mj", "<cmd>silent BookmarkNext<cr>", { silent = true })
vim.keymap.set("n", "mk", "<cmd>silent BookmarkPrev<cr>", { silent = true })
vim.keymap.set("n", "mS", "<cmd>silent BookmarkShowAll<cr>", { silent = true })
vim.keymap.set("n", "ms", "<cmd>lua require('telescope').extensions.vim_bookmarks.all({ hide_filename=false, prompt_title=\"bookmarks\", shorten_path=false })<cr>", { silent = true }) -- Annotate

-- Trouble
vim.keymap.set("n", "<leader>x", "<cmd>TroubleToggle<cr>", {silent = true, noremap = true})
vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", {silent = true, noremap = true})
vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", {silent = true, noremap = true})
vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", {silent = true, noremap = true})
vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", {silent = true, noremap = true})
vim.keymap.set("n", "<leader>xr", "<cmd>TroubleToggle lsp_references<cr>", {silent = true, noremap = true})

-- https://github.com/lukas-reineke/dotfiles/blob/master/vim/lua/mappings.lua
-- map("n", leader .. "gn", ":lua require('lists').change_active('Quickfix')<CR>:VcsJump merge<CR>")
-- map("n", leader .. "gh", ":diffget //2<CR> :diffupdate<CR>")
-- map("n", leader .. "gl", ":diffget //3<CR> :diffupdate<CR>")

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
