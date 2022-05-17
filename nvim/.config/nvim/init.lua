-- vim.g.python_host_prog = "~/.pyenv/versions/neovim2/bin/python"
-- vim.g.python3_host_prog = "~/.pyenv/versions/neovim3.8.5/bin/python"
--
--vim.g.mapleader = "<space>"  -- 'vim.g' sets global variables

-- require('globals')  --TODO: need to be implemented
require('utils')
require('settings')
require('plugins')
--vim.cmd('luafile ~/.config/nvim/v-settings.lua')
require('core.autocommands')
require('core.commands')
require('keymappings')
require('colorscheme')  -- This plugin must be required somewhere after nvimtree. Placing it before will break navigation keymappings

-- Plugins
require('core.notify')
require('core.project')
require('core.gitsigns')
require('core.cmp')
require('core.galaxyline')
require('core.treesitter')
require('core.bufferline')
require('core.nvim-tree')  -- This plugin must be required somewhere before colorscheme.  Placing it after will break navigation keymappings
require('core.autopairs')
require('core.colorizer')
require('core.comment')
--require('v-which-key')
require('core.indent-blankline')
require('core.todo-comments')
require('core.bookmark')
--require("v-trouble")
-- require('core.hop')
require('core.git-blame')
require('symbols-outline')
require('zen-mode')
--require('twilight')
--LSP
require('lsp')
