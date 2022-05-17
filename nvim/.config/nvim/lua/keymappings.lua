local opts = { noremap = true, silent = true }
--local term_opts = { silent = true }

-- Shorten function name
--local keymap = vim.api.nvim_set_keymap
-------------------------------------------------

--local k = require("astronauta.keymap")
--local noremap = k.noremap
--local vim.keymap.set = k.nnoremap
--local vim.keymap.set = k.inoremap
--local vnoremap = k.vnoremap
--local xnoremap = k.xnoremap
--local tnoremap = k.tnoremap
--local nmap = k.nmap
--local xmap = k.xmap
--local vmap = k.vmap

-- Set leader
vim.keymap.set('n', '<space>',  '<NOP>', { silent = true } )
vim.g.mapleader = " "  -- 'vim.g' sets global variables
--vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
--vim.keymap.set({ '<C-h>', '<C-w>h'})
--vim.keymap.set({ '<C-j>', '<C-w>j'})
--vim.keymap.set({ '<C-k>', '<C-w>k'})
--vim.keymap.set({ '<C-l>', '<C-w>l'})
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

-- Disable arrow keys (vi muscle memory)
vim.keymap.set("n", "<up>", "<cmd> :echoerr 'Umm, use k instead'<CR>", opts)
vim.keymap.set("n", "<down>", "<cmd> :echoerr 'Umm, use j instead'<CR>", opts)
vim.keymap.set("n", "<left>", "<cmd> :echoerr 'Umm, use h instead'<CR>", opts)
vim.keymap.set("n", "<right>", "<cmd> :echoerr 'Umm, use l instead'<CR>", opts)

vim.keymap.set("i", "<up>", "<NOP>", opts)
vim.keymap.set("i", "<down>", "<NOP>", opts)
vim.keymap.set("i", "<left>", "<NOP>", opts)
vim.keymap.set("i", "<right>", "<NOP>", opts)

-- Resize buffer easier
vim.keymap.set('n', "<Leader>+", "<CMD>vertical resize +2<CR>", opts)
vim.keymap.set('n', "<Leader>-", "<CMD>vertical resize -2<CR>", opts)
-- vim.keymap.set { "<Up>", "<CMD>resize +2<CR>" }
-- vim.keymap.set { "<Down>", "<CMD>resize -2<CR>" }

-- Move text up and down
-- FIXME Doesn't work in my case
--vim.keymap.set({"<A-j>", "<ESC>:m .+1<CR>==gi", {silent = true}})
--vim.keymap.set({"<A-k>", "<ESC>:m .-2<CR>==gi", {silent = true}})

-- Insert --
-- I hate escape
vim.keymap.set('i', 'jk',  '<ESC><ESC>', opts)
vim.keymap.set('i', 'kj',  '<ESC><ESC>', opts)
vim.keymap.set('i', 'jj',  '<ESC><ESC>', opts)
vim.keymap.set('i', "JJ",  "<Esc><Esc>", opts)

-- Visual --
-- Better indenting
vim.keymap.set('v', '<', '<gv', {silent = true})
vim.keymap.set('v', '>', '>gv', {silent = true})

-- Move text up and down
vim.keymap.set('n', "<Leader>j", ":m .+1<CR>==", {silent = true})
vim.keymap.set('n', "<Leader>k", ":m .-2<CR>==", {silent = true})
vim.keymap.set('v', "p", '"_dP', {silent = true})

-- Visual Block --
-- Move selected line / block of text up and down
vim.keymap.set('v', 'K', ':move \'<-2<CR>gv=gv', {silent = true})
vim.keymap.set('v', 'J', ':move \'>+1<CR>gv=gv', {silent = true})
vim.keymap.set('v', '<C-k>', '<ESC>:m .-2<CR>==', {silent = true})
vim.keymap.set('v', '<C-j>', '<ESC>:m .+1<CR>==', {silent = true})

-- Terminal --
-- Better terminal navigation
--tnoremap({"<C-h>", "<C-\\><C-N><C-w>h", {silent = true}})
--tnoremap({"<C-j>", "<C-\\><C-N><C-w>j", {silent = true}})
--tnoremap({"<C-k>", "<C-\\><C-N><C-w>k", {silent = true}})
--tnoremap({"<C-l>", "<C-\\><C-N><C-w>l", {silent = true}})

------------------------------------------------------------------------------------------
-- vim.keymap.set { '<leader>q', function() print("Hello world, from lua") end }
--
-- virtualtext
vim.keymap.set('n', '.s', '<Cmd>LspVirtualTextShow<CR>', {silent = true})
vim.keymap.set('n', '.h', '<Cmd>LspVirtualTextHide<CR>', {silent = true})

-- toggle hlsearch
vim.keymap.set('n', '<Leader>h', '<CMD>nohl<CR>', opts)

-- toggle colorizer
vim.keymap.set('n', "<Leader>c", "<CMD>ColorizerToggle<CR>", opts)

vim.keymap.set("n", "<leader>e", ':NvimTreeToggle<cr>', opts)

-- hop plugin
-- vim.api.nvim_set_keymap("", "s", ":HopChar2<cr>", { silent = true })
-- vim.api.nvim_set_keymap("", "S", ":HopWord<cr>", { silent = true })

-- hippity hoppity your word is not my property
--vim.keymap.set ({ "<Leader>w", require("hop").hint_words })

-- For details look at https://github.com/junegunn/vim-easy-align
-- xmap ({ "ga", "<Plug>(EasyAlign)", { silent = true }})
-- nmap ({ "ga", "<Plug>(EasyAlign)", { silent = true }})

-- better yank behaviour
-- yank to the end of the current line (but don't yank the newline character)
vim.keymap.set ('n', "Y", "y$")

-- remove annoying exmode
vim.keymap.set ('n', "Q", "<Nop>")
vim.keymap.set ('n', "q:", "<Nop>")

-- toggle truezen.nvim's ataraxis and minimalist mode
vim.keymap.set('n', '<Leader>z', '<CMD>TZAtaraxis<CR>')
vim.keymap.set('n', '<Leader>m', '<CMD>TZMinimalist<CR>')

-- buffer movements
vim.keymap.set('n', '<S-x>', '<Cmd>Sayonara!<CR>')
--noremap { "<A-j>", "<CMD>Sayonara!<CR>" } -- This deletes the current buffer and preserves the current window.
--noremap { "<A-k>", "<CMD>Sayonara<CR>" } -- This deletes the current buffer and closes the current window.
--noremap { "<A-h>", "<CMD>bprevious<CR>" }
--noremap { "<A-l>", "<CMD>bnext<CR>" }
--noremap({ '<S-TAB>', '<CMD>:bprevious<CR>', {silent = true} })
--noremap({ '<TAB>', '<CMD>:bnext<CR>', {silent = true} })

vim.keymap.set('', '<S-l>', '<Cmd>BufferLineCycleNext<CR>', {silent = true})
vim.keymap.set('', '<S-h>', '<Cmd>BufferLineCyclePrev<CR>', {silent = true})
vim.keymap.set('n', '<leader>1', '<cmd>BufferLineGoToBuffer 1<cr>', {silent = true})
vim.keymap.set('n', '<leader>2', '<cmd>BufferLineGoToBuffer 2<cr>', {silent = true})
vim.keymap.set('n', '<leader>3', '<cmd>BufferLineGoToBuffer 3<cr>', {silent = true})
vim.keymap.set('n', '<leader>4', '<cmd>BufferLineGoToBuffer 4<cr>', {silent = true})
vim.keymap.set('n', '<leader>5', '<cmd>BufferLineGoToBuffer 5<cr>', {silent = true})
vim.keymap.set('n', '<leader>6', '<cmd>BufferLineGoToBuffer 6<cr>', {silent = true})
vim.keymap.set('n', '<leader>7', '<cmd>BufferLineGoToBuffer 7<cr>', {silent = true})
vim.keymap.set('n', '<leader>8', '<cmd>BufferLineGoToBuffer 8<cr>', {silent = true})
vim.keymap.set('n', '<leader>9', '<cmd>BufferLineGoToBuffer 9<cr>', {silent = true})

--command that adds new buffer and moves to it
-- vim.keymap.set({ '<S-t>', '<CMD>tabnew<CR>', {silent = true} })

-- open vertical scratch buffer
--vim.keymap.set {
--  "<Leader>v",
--"<CMD>vnew | setlocal buftype=nofile | setlocal bufhidden=hide<CR>",
-- }

-- TODO: Need investigation how it works
--nmap {"<Leader>t", "<Plug>PlenaryTestFile", { silent = true }}

-- Telescope
-- Search
--keymap("n", "<leader>f", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>", opts)
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>') -- Find file
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>') -- Find text
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>')
vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>')
-- vim.keymap.set({'<leader>fd', '<cmd>Telescope lsp_document_diagnostics<cr>'}) --Document Diagnostics
-- vim.keymap.set({'<leader>fD', '<cmd>Telescope lsp_workspace_diagnostics<CR>'}) --Workspace Diagnostics
vim.keymap.set('n', '<leader>fm', '<cmd>Telescope marks<cr>') --Marks
vim.keymap.set('n', '<leader>fM', '<cmd>Telescope man_pages<cr>') -- Man pages
vim.keymap.set('n', '<leader>fr', '<cmd>Telescope oldfiles<cr>') -- Open recent files
vim.keymap.set('n', '<leader>fR', '<cmd>Telescope registers<cr>') -- Registers
vim.keymap.set('n', '<leader>fz', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find({previewer = false})<CR>]], { noremap = true, silent = true })
vim.keymap.set('n', "<Leader>fe", require("telescope").extensions.media_files.media_files, { silent = true })

-- Git
vim.keymap.set('n', '<leader>go', '<cmd>Telescope git_status<cr>') -- Open changed file
vim.keymap.set('n', '<leader>gb', '<cmd>Telescope git_branches<cr>') -- Checkout branch
vim.keymap.set('n', '<leader>gc', '<cmd>Telescope git_commits<cr>') -- Checkout commit
vim.keymap.set('n', '<leader>gC', '<cmd>Telescope git_bcommits<cr>') -- Checkout commit(for current file)
vim.keymap.set('n', '<leader>gj', '<cmd>NextHunk<cr>') -- Next Hunk
vim.keymap.set('n', '<leader>gk', '<cmd>PrevHunk<cr>') -- Prev Hunk
vim.keymap.set('n', '<leader>gp', '<cmd>PreviewHunk<cr>') -- Preview Hunk
vim.keymap.set('n', '<leader>gr', '<cmd>ResetHunk<cr>') -- Reset Hunk
vim.keymap.set('n', '<leader>gR', '<cmd>ResetBuffer<cr>') -- Reset Buffer
vim.keymap.set('n', '<leader>gs', '<cmd>StageHunk<cr>') -- Stage Hunk
vim.keymap.set('n', '<leader>gu', '<cmd>UndoStageHunk<cr>') -- Undo Stage Hunk
vim.keymap.set('n', '<Leader>gm', '<cmd>:GitBlameToggle<cr>')

-- dashboard
--vim.keymap.set({ '<Leader>;', '<CMD>:Dashboard<CR>', {silent = true} })

--LSP
-- NOTE: Close quickfix with :cclose 
-- vim.keymap.set({'<Leader>la', '<CMD>Lspsaga code_action<CR>', {silent = true} })
-- vim.keymap.set({'<Leader>lA', '<CMD>Lspsaga range_code_action<CR>', {silent = true} }) -- Selected action
-- vim.keymap.set({'<leader>ld', '<cmd>Telescope lsp_document_diagnostics<cr>'}) --Document Diagnostics
-- vim.keymap.set({'<leader>lD', '<cmd>Telescope lsp_workspace_diagnostics<CR>'}) --Workspace Diagnostics
-- vim.keymap.set({'<Leader>lf', '<CMD>LspFormatting<CR>', {silent = true} }) -- Format
-- vim.keymap.set({'<Leader>li', '<CMD>LspInfo<CR>', {silent = true} }) -- Info
-- vim.keymap.set({'<Leader>ll', '<CMD>Lspsaga lsp_finder<CR>', {silent = true} }) -- LSP Finder
-- vim.keymap.set({'<Leader>lL', '<CMD>Lspsaga show_line_diagnostics<CR>', {silent = true} }) -- Line Diagnostics
-- vim.keymap.set({'<Leader>lp', '<CMD>Lspsaga preview_definition<CR>', {silent = true} }) -- Preview Definition
vim.keymap.set('n', '<Leader>lq', '<CMD>Telescope quickfix<CR>', {silent = true}) -- Quickfix
-- vim.keymap.set({'<Leader>lr', '<CMD>Lspsaga rename<CR>', {silent = true} })
-- vim.keymap.set({'<Leader>lt', '<CMD>LspTypeDefinition<CR>', {silent = true} }) -- Type Definition
vim.keymap.set('n', '<Leader>lx', '<CMD>cclose<CR>', {silent = true}) -- Close Quickfix
-- vim.keymap.set({'<Leader>ls', '<CMD>Telescope lsp_document_symbols<CR>', {silent = true} }) -- Document Symbols
-- vim.keymap.set({'<Leader>lS', '<CMD>Telescope lsp_workspace_symbols<CR>', {silent = true} }) -- Workspace Symbols

-- Debug
vim.keymap.set('n', '<Leader>db', '<CMD>DebugToggleBreakpoint<CR>', {silent = true})
vim.keymap.set('n', '<Leader>dc', '<CMD>DebugContinue<CR>', {silent = true})
vim.keymap.set('n', '<Leader>di', '<CMD>DebugStepInto<CR>', {silent = true})
vim.keymap.set('n', '<Leader>do', '<CMD>DebugStepOver<CR>', {silent = true})
vim.keymap.set('n', '<Leader>dr', '<CMD>DebugToggleRepl<CR>', {silent = true})
vim.keymap.set('n', '<Leader>ds', '<CMD>DebugStart<CR>', {silent = true})

-- Session
vim.keymap.set('n', '<Leader>Ss', '<CMD>SessionSave<CR>', {silent = true})
vim.keymap.set('n', '<Leader>Sl', '<CMD>SessionLoad<CR>', {silent = true})


-- Yank Current File Name
vim.keymap.set("n", "<leader>fp", ":lua require('funcs').yank_current_file_name()<CR>", {noremap = true,silent = true})

-- yank all in buffer
vim.keymap.set("n", "<leader>a", ":%y<cr>", { noremap = false, silent = true })

-- https://github.com/lukas-reineke/dotfiles/blob/master/vim/lua/mappings.lua
-- map("n", leader .. "gn", ":lua require('lists').change_active('Quickfix')<CR>:VcsJump merge<CR>")
-- map("n", leader .. "gh", ":diffget //2<CR> :diffupdate<CR>")
-- map("n", leader .. "gl", ":diffget //3<CR> :diffupdate<CR>")



-- FIXME Need to be adopted
-- Visual mode pressing * or # searches for the current selection
-- Super useful! From an idea by Michael Naumann
--vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
--vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>
--
-- function! VisualSelection(direction, extra_filter) range
--     let l:saved_reg = @"
--     execute "normal! vgvy"
--
--     let l:pattern = escape(@", "\\/.*'$^~[]")
--     let l:pattern = substitute(l:pattern, "\n$", "", "")
--
--     if a:direction == 'gv'
--         call CmdLine("Ack '" . l:pattern . "' " )
--     elseif a:direction == 'replace'
--         call CmdLine("%s" . '/'. l:pattern . '/')
--     endif
--
--     let @/ = l:pattern
--     let @" = l:saved_reg
-- endfunction
--
--
--
--Selects all content:
--gg moves to first line
-- V starts visual mode
--G jumps to last line thereby selecting from first to last line
--vim.keymap.set <leader>a ggVG

-- """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
-- " => Spell checking
-- """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
-- " Check file in shellcheck:
-- 	map <leader>s :!clear && shellcheck -x %<CR>
--
-- " Spell-check set to <leader>o, 'o' for 'orthography':
-- 	map <leader>o :setlocal spell! spelllang=en_us<CR>
--



--vim.keymap.set <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>

-- vim.keymap.set   <silent>   <F7>    :FloatermNew<CR>
-- tnoremap   <silent>   <F7>    <C-\><C-n>:FloatermNew<CR>
-- vim.keymap.set   <silent>   <F8>    :FloatermPrev<CR>
-- tnoremap   <silent>   <F8>    <C-\><C-n>:FloatermPrev<CR>
-- vim.keymap.set   <silent>   <F9>    :FloatermNext<CR>
-- tnoremap   <silent>   <F9>    <C-\><C-n>:FloatermNext<CR>
-- vim.keymap.set   <silent>   <F12>   :FloatermToggle<CR>
-- tnoremap   <silent>   <F12>   <C-\><C-n>:FloatermToggle<CR>

--TERMINAL MAPPINGS
--utils.vim.keymap.set('<leader>t', '<CMD>lua require"FTerm".toggle()<CR>')
--utils.tnoremap('<leader>t', '<C-\\><C-n><CMD>lua require"FTerm".toggle()<CR>')
