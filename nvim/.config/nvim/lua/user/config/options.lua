-- For details use :help option-list
vim.opt.backup = false                          -- creates a backup file
-- vim.opt.clipboard = "unnamedplus"               -- allows neovim to access the system clipboard. Now you can copy the line in vim with yy and paste it system-wide.
vim.opt.cmdheight = 1                           -- more space in the neovim command line for displaying messages
vim.opt.colorcolumn = "99999"                   -- fixes indentline for now
vim.opt.completeopt = { "menu", "menuone", "noselect", "noinsert" }  -- mostly just for cmp
vim.opt.conceallevel = 0                        -- so that `` is visible in markdown files
vim.opt.fileencoding = "utf-8"                  -- the encoding written to a file
vim.opt.foldmethod = "manual"                   -- folding, set to "expr" for treesitter based foloding
vim.opt.foldexpr = ""                           -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
vim.opt.hlsearch = false                        -- highlight all matches on previous search pattern
vim.opt.ignorecase = true                       -- ignore case in search patterns
vim.opt.mouse = "a"                             -- allow the mouse to be used in neovim
vim.opt.pumheight = 10                          -- pop up menu height
vim.opt.pumblend = 10
vim.opt.showmode = false                        -- we don't need to see things like -- INSERT -- anymore
vim.opt.showtabline = 0                         -- 2 - always show tabs, 0 - never
vim.opt.smartcase = true                        -- when searching try to be smart about cases
vim.opt.smartindent = true                      -- make indenting smarter again
vim.opt.splitbelow = true                       -- force all horizontal splits to go below current window
vim.opt.splitright = true                       -- force all vertical splits to go to the right of current window
vim.opt.swapfile = false                        -- creates a swapfile
vim.opt.termguicolors = true                    -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 1000         --400         -- time to wait for a mapped sequence to complete (in milliseconds). By default timeoutlen is 1000 ms
vim.opt.title = true                            --Tab title as file file
vim.opt.undofile = true                         -- enable persistent undo
vim.opt.updatetime = 250          --100         -- faster completion (4000ms default)
vim.opt.writebackup = false                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.expandtab = true                        -- convert tabs to spaces. Use Ctrl-V<Tab> to insert a real Tab.
vim.opt.shiftwidth = 2                          -- the number of spaces inserted for each indentation
vim.opt.tabstop = 2                             -- insert 2 spaces for a tab
vim.opt.cursorline = true                       -- highlight the current line
-- Turn hybrid line numbers on
vim.opt.number = true                           -- set numbered lines
vim.opt.laststatus = 3                          -- global status line
vim.opt.showcmd = false
vim.opt.ruler = false
vim.opt.relativenumber = true                   -- set relative numbered lines
vim.opt.numberwidth = 4                         -- set number column width to 2 {default 4}
vim.opt.signcolumn = "yes"   -- "auto"          -- always show the sign column, otherwise it would shift the text each time
vim.opt.wrap = false                            -- display lines as one long line
vim.opt.spell = false
vim.opt.spelllang = { "en_us" }
vim.opt.scrolloff = 8             --999         -- is one of my fav. Show next 8 lines while scrolling
vim.opt.sidescrolloff = 8                       -- Show next 8 columns while side-scrolling
-- vim.opt.guifont = "monospace:h17"               -- the font used in graphical neovim applications
--o.guifont = "JetBrainsMono Nerd Font"
vim.opt.fillchars.eob=" "                       -- remove the ~ from end of buffer

vim.opt.list = true -- Show invisible characters
vim.opt.listchars:append("eol:¬") -- Show a special character at the end of each line
-- vim.opt.listchars = { tab = '▸ ', trail = '·' }

-- Buffer becomes hidden when abandoned.
-- This makes vim act like all other editors, buffers can
-- exist in the background without being in a window.
-- http://items.sjbach.com/319/configuring-vim-right
vim.opt.hidden = true                           -- required to keep multiple buffers and open multiple buffers

vim.opt.shortmess:append "c"                    -- Don't pass messages to |ins-completion-menu|.
vim.opt.whichwrap:append("<,>,[,],h,l")            -- move to next line with theses keys
vim.opt.iskeyword:append("-")                    -- treat dash separated words as a word text object

--vim.opt.shadafile = _G.get_data_dir() .. "/shada"
--vim.opt.spellfile  = _G.get_config_dir() .. "/spell/en.utf-8.add"
--vim.opt.undodir = "/home/" .. vim.fn.expand('$USER') .. "/.cache/nvim/undodir"
--vim.opt.undodir = _G.get_cache_dir() .. "/undo"     -- set an undo directory

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.netrw_banner = 0
vim.g.netrw_mouse = 2
vim.g.netrw_browse_split = 0
vim.g.netrw_winsize = 25
-- vim.g.netrw_liststyle =3  -- make netrw use the tree view by default

-- Undercurl
-- vim.cmd([[let &t_Cs = "\e[4:3m"]])
-- vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " " -- 'vim.g' sets global variables
vim.g.maplocalleader = ' '

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
