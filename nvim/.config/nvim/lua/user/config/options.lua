-- auto format
vim.g.autoformat = true

-- if the completion engine supports the AI source,
-- use that instead of inline suggestions
vim.g.ai_cmp = false

-- Root dir detection
-- Each entry can be:
-- * the name of a detector function like `lsp` or `cwd`
-- * a pattern or array of patterns like `.git` or `lua`.
-- * a function with signature `function(buf) -> string|string[]`
vim.g.root_spec = { 'lsp', { '.git', 'lua' }, 'cwd' } -- default

-- Set LSP servers to be ignored when used with `util.root.detectors.lsp`
-- for detecting the LSP root
vim.g.root_lsp_ignore = { 'copilot' }

vim.g.have_nerd_font = true

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' ' -- 'vim.g' sets global variables
vim.g.maplocalleader = ' '

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.netrw_banner = 0
vim.g.netrw_mouse = 2
vim.g.netrw_browse_split = 0
vim.g.netrw_winsize = 25
-- vim.g.netrw_liststyle =3  -- make netrw use the tree view by default
-- Set to true if you have a Nerd Font installed and selected in the terminal

local opt = vim.opt

opt.autowrite = true -- Enable auto write
opt.winborder = 'rounded' --to use rounded borders on all floating windows.

-- For details use :help option-list
opt.backup = false -- creates a backup file

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  -- only set clipboard if not in ssh, to make sure the OSC 52
  -- integration works automatically.
  -- allows neovim to access the system clipboard.
  -- Now you can copy the line in vim with yy and paste it system-wide.
  -- opt.clipboard = vim.env.SSH_TTY and '' or 'unnamedplus'
end)

opt.cmdheight = 1 -- more space in the neovim command line for displaying messages
opt.colorcolumn = '99999' -- fixes indentline for now
opt.completeopt = { 'menu', 'menuone', 'noselect', 'noinsert' } -- mostly just for cmp
opt.conceallevel = 2 -- Hide * markup for bold and italic, but not markers with substitutions
opt.fileencoding = 'utf-8' -- the encoding written to a file
opt.grepformat = '%f:%l:%c:%m'
opt.grepprg = 'rg --vimgrep'
opt.hlsearch = false -- highlight all matches on previous search pattern
opt.ignorecase = true -- ignore case in search patterns
opt.mouse = 'a' -- allow the mouse to be used in neovim
opt.pumheight = 10 -- pop up menu height
opt.pumblend = 10
vim.opt.shortmess:append {
  W = true, -- don't show "written" after :w
  I = true, -- don't show the startup intro message
  c = true, -- don't show ins-completion-menu messages
  C = true, -- don't show match count messages during completion
}
opt.shiftround = true -- Round indent
opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
opt.showtabline = 0 -- 2 - always show tabs, 0 - never
opt.smartcase = true -- when searching try to be smart about cases
opt.smartindent = true -- make indenting smarter again
opt.splitbelow = true -- force all horizontal splits to go below current window
opt.splitkeep = 'screen'
opt.splitright = true -- force all vertical splits to go to the right of current window
opt.swapfile = false -- creates a swapfile
opt.termguicolors = true -- set term gui colors (most terminals support this)
opt.timeoutlen = 1000 --400         -- time to wait for a mapped sequence to complete (in milliseconds). By default timeoutlen is 1000 ms
opt.title = true --Tab title as file file
opt.undofile = true -- enable persistent undo
opt.undolevels = 10000
opt.updatetime = 200 -- Save swap file and trigger CursorHold    -- faster completion (4000ms default)
opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
opt.expandtab = true -- convert tabs to spaces. Use Ctrl-V<Tab> to insert a real Tab.
opt.shiftwidth = 2 -- the number of spaces inserted for each indentation
opt.tabstop = 2 -- insert 2 spaces for a tab
opt.cursorline = true -- highlight the current line
opt.laststatus = 3 -- global status line
opt.jumpoptions = 'view'
opt.inccommand = 'nosplit' -- preview incremental substitute
opt.linebreak = true -- Wrap lines at convenient points
opt.breakindent = true
opt.showbreak = '↪ ' -- Show a visual indicator at wrap
opt.showcmd = false
opt.ruler = false
opt.wildmode = 'longest:full,full' -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.wrap = false -- display lines as one long line
opt.spell = false
opt.spelllang = { 'en_us', 'uk' }
opt.scrolloff = 4 -- Show next 4 lines while scrolling
opt.sidescrolloff = 8 -- Show next 8 columns while side-scrolling
-- opt.guifont = "monospace:h17"               -- the font used in graphical neovim applications
--o.guifont = "JetBrainsMono Nerd Font"

-- statuscolumn configuration
-- Based on:
--  https://github.com/OXY2DEV/bars.nvim/wiki/Guide_Statuscolumn
--  https://www.reddit.com/r/neovim/comments/1djjc6q/statuscolumn_a_beginers_guide/
-- Or usw plugin [statuscol.nvim](https://github.com/luukvbaal/statuscol.nvim)
opt.relativenumber = true -- set relative numbered lines
opt.numberwidth = 1 -- set number column width to 2 {default 4}
opt.number = true -- set numbered lines (turn hybrid line numbers on)
opt.signcolumn = 'yes' -- always show the sign column, otherwise it would shift the text each time

-- If conform is used
opt.formatexpr = "v:lua.require('conform').formatexpr()"
vim.bo.formatexpr = "v:lua.require'conform'.formatexpr()"

-- or
-- opt.formatexpr = 'v:lua.vim.lsp.formatexpr({ timeout_ms = 3000 })'
opt.formatoptions = 'jcroqlnt' -- tcqj

-- https://www.jackfranklin.co.uk/blog/code-folding-in-vim-neovim/
opt.foldcolumn = '0' -- '0' is not bad
opt.foldlevel = 99
opt.foldlevelstart = 99 -- All folds will stay open whenever you're switching between buffers
opt.foldnestmax = 4
opt.foldtext = ''
opt.foldmethod = 'indent'
opt.foldenable = true
opt.virtualedit = 'block' -- Allow cursor to move where there is no text in visual block mode

-- Part     Description
-- %s     The sign column.
-- %C     The fold column.
-- %3l    The line number. It has a width of 3 columns.
-- \      Space.
-- ▍      Border to separate the statuscolumn from the text.
--
-- Example: :set statuscolumn=%s%C%3l\ ▍
-- With colors: :set statuscolumn=%#Normal#%s%C%#Special#%3l%#Normal#\ ▍
opt.statuscolumn = '%s%C%3l '

-- https://neovim.io/doc/user/options.html#'fillchars'
--   item          default        Used for
--   fold          '·' or '-'   filling 'foldtext'...
--   foldopen:c    '-'          mark the beginning of a fold
--   foldclose:c   '+'          show a closed fold
--   foldsep:c     '│' or '|'   open fold middle character
--
-- These characters are from the Box drawing character group: │, ┃, ┆, ┇, ┊, ┋, ╎, ╏, ║, ╽, ╿
-- opt.fillchars:append("foldopen:▾", "foldsep:│" ,"foldclose:▸")
opt.fillchars = {
  foldopen = '',
  foldclose = '',
  fold = ' ',
  foldsep = ' ',
  diff = '╱',
  eob = ' ', -- remove the ~ from end of buffer
}

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
opt.list = true -- Show invisible characters

-- To insert an NBSP
--  1) In Insert Mode, press:
--      Ctrl-v → starts literal input
--      u00a0 → types the Unicode code point for NBSP
--  2) If you have Compose key (Right Alt): Compose + Space + Space
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' } -- '⍽'
-- opt.listchars:append 'eol:¬' -- Show a special character at the end of each line

-- Buffer becomes hidden when abandoned.
-- This makes vim act like all other editors, buffers can
-- exist in the background without being in a window.
-- http://items.sjbach.com/319/configuring-vim-right
opt.hidden = true -- required to keep multiple buffers and open multiple buffers

opt.whichwrap:append '<,>,[,],h,l' -- move to next line with theses keys
opt.iskeyword:append '-' -- treat dash separated words as a word text object

-- Default splitting will cause your main splits to jump when opening an edgebar.
-- To prevent this, set `splitkeep` to either `screen` or `topline`.
vim.opt.splitkeep = 'screen'

--vim.opt.shadafile = _G.get_data_dir() .. "/shada"
--vim.opt.spellfile  = _G.get_config_dir() .. "/spell/en.utf-8.add"
--vim.opt.undodir = "/home/" .. vim.fn.expand('$USER') .. "/.cache/nvim/undodir"
--vim.opt.undodir = _G.get_cache_dir() .. "/undo"     -- set an undo directory

-- Undercurl
-- https://github.com/craftzdog/dotfiles-public/blob/master/.config/nvim/lua/config/options.lua
-- vim.cmd [[let &t_Cs = "\e[4:3m"]]
-- vim.cmd [[let &t_Ce = "\e[4:0m"]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

opt.modeline = false
