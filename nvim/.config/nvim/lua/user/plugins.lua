-- Automatically install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
PACKER_BOOTSTRAP = vim.fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

--if fn.empty(fn.glob(install_path)) > 0 then
--  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
--  execute 'packadd packer.nvim'
--end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
-- vim.cmd [[
--   augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost plugins.lua source <afile> | PackerSync
--   augroup end
-- ]]

-- Automatically source and re-compile packer whenever you save this plugin.lua
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | PackerSync',
  group = packer_group,
  pattern = "plugins.lua"
})

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  max_jobs = 50,
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
    prompt_border = "rounded", -- Border style of prompt popups.
  },
}

-- Install your plugins here
--return require('packer').startup(function(use)
packer.startup(function(use)
  use "wbthomason/packer.nvim" -- Packer can manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  -- use "folke/lua-dev.nvim"

  use "folke/neodev.nvim" -- TODO: how to configure this
  -- TODO: Remove bufferline at all
  -- Buffer line
  -- use { "akinsho/bufferline.nvim" }

  --LSP
  use "neovim/nvim-lspconfig"  -- enable LSP
  -- use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
  use "RRethy/vim-illuminate"
  use "j-hui/fidget.nvim"
  use "lvimuser/lsp-inlayhints.nvim"
  use "ray-x/lsp_signature.nvim"
  use "SmiteshP/nvim-navic"
  use "folke/trouble.nvim"
  -- use "simrat39/symbols-outline.nvim" -- TODO: Need to think do I really need this
  use "b0o/SchemaStore.nvim" -- must be installed for jsonls LSP
  -- use "https://git.sr.ht/~whynothugo/lsp_lines.nvim"

  -- Completion
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lua"
  use "hrsh7th/cmp-emoji"
  -- use "hrsh7th/cmp-nvim-lsp-document-symbol"

  -- Snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- Syntax/Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate"
  }
  use { "JoosepAlviste/nvim-ts-context-commentstring", commit = "" }
  use "windwp/nvim-ts-autotag"
  use 'hiphish/rainbow-delimiters.nvim'
  -- use "nvim-treesitter/nvim-treesitter-textobjects" -- TODO: Don't understand how it works
  use "kylechui/nvim-surround" -- TODO: Don't understand how it works
  -- use {
  --   "abecodes/tabout.nvim", -- TODO: Don't understand how it works
  --   wants = { "nvim-treesitter" }, -- or require if not used so far
  -- }

  use "Glench/Vim-Jinja2-Syntax"

  -- Marks
  use "ThePrimeagen/harpoon"
  -- use "christianchiarulli/harpoon" -- TODO: Look at this in the feature
  use "MattesGroeger/vim-bookmarks" -- +

  -- Telescope
  use "nvim-telescope/telescope.nvim"
  use {
    "nvim-telescope/telescope-fzf-native.nvim",
    run = "make"
  }
  use "tom-anders/telescope-vim-bookmarks.nvim"
  use "nvim-telescope/telescope-media-files.nvim"
  use { "nvim-telescope/telescope-file-browser.nvim" }

  -- TODO: install in the feature
  -- Note Taking
  -- use "mickael-menu/zk-nvim"

  -- Colors
  use "NvChad/nvim-colorizer.lua"
  -- use "norcalli/nvim-colorizer.lua" -- +

  -- Colorschemes
  use { "catppuccin/nvim", as = "catppuccin" }
  use "folke/tokyonight.nvim"
  use "EdenEast/nightfox.nvim"
  -- use 'arcticicestudio/nord-vim'

  -- Utility
  use "rcarriga/nvim-notify" -- +
  use {"moll/vim-bbye", commit = "" }
  -- use "stevearc/dressing.nvim"
  use "ghillb/cybu.nvim"
  use {"lewis6991/impatient.nvim", commit = "" }
  -- use "lalitmee/browse.nvim"

  -- Registers
  use {"tversteeg/registers.nvim", commit = "" }

  -- Icon
  use {"kyazdani42/nvim-web-devicons", commit = "" }

  -- Debugging
  use "mfussenegger/nvim-dap"
  use "rcarriga/nvim-dap-ui"
  use "theHamsta/nvim-dap-virtual-text"
  use "ravenxrz/DAPInstall.nvim" -- FIX: Do I really need it if I have Mason ? 
  use 'nvim-telescope/telescope-dap.nvim'

  -- Status line
  use "nvim-lualine/lualine.nvim"

  -- Startup
  -- use "goolord/alpha-nvim" -- I think it is unnecessary 

 -- Indent
  use "lukas-reineke/indent-blankline.nvim"

  -- File explorer
  use { "nvim-tree/nvim-tree.lua" }
  -- use {'tamago324/lir.nvim'} -- Use telescope instead

  -- Comment
  use "numToStr/Comment.nvim" -- Easily comment stuff
  use { "folke/todo-comments.nvim" }

  -- Terminal
  use { "akinsho/toggleterm.nvim" }

  -- Project
  use { "ahmedkhalf/project.nvim", commit = "" }
  use "windwp/nvim-spectre"

  -- Session -OK!
  use "rmagatti/auto-session"
  use "rmagatti/session-lens"

  -- Quickfix
  -- TODO: I don't understand where it should be configired. Do I really need this if I have Trouble plugin ?
  -- use "kevinhwang91/nvim-bqf"

  -- Code Runner
  -- TODO: Not now, maybe in the feature.
  -- use "is0n/jaq-nvim"
  -- use {
  --   "0x100101/lab.nvim",
  --   run = "cd js && npm ci",
  -- }

  -- Git
  use "lewis6991/gitsigns.nvim"
  -- use "f-person/git-blame.nvim"
  use {'tpope/vim-fugitive'}
  --use { 'sindrets/diffview.nvim' }

  -- Github
  -- use "pwntester/octo.nvim" -- TODO: feature

  -- Editing Support
  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
  -- use "monaqa/dial.nvim" --  TODO: Don't know do I realy need this
  -- use "nacro90/numb.nvim" --  TODO: Don't know do I realy need this
  use "andymass/vim-matchup"
  -- use "karb94/neoscroll.nvim" -- TODO: Don't use for now. Use insetad embedded feature Ctrl+d,u,f,b,y,e
  -- use "folke/zen-mode.nvim"-- I think it is unnecessary  
  -- use "junegunn/vim-slash" --  TODO: Don't know do I realy need this
  use('mbbill/undotree')

  -- Motion
  -- use {
  --   "phaazon/hop.nvim", -- TODO: Don't use for now. Use instead embedded feature Fx,Tx,fx,tx 
  --   branch = 'v2'
  -- }

  -- Java
  -- use "mfussenegger/nvim-jdtls"

  -- Rust
  -- use { "christianchiarulli/rust-tools.nvim", branch = "modularize_and_inlay_rewrite" }
  -- use "Saecki/crates.nvim"

  -- Typescript TODO: set this up, also add keybinds to ftplugin
  -- use "jose-elias-alvarez/typescript.nvim" -- TODO: Don't understand how it works

  -- Markdown
  use {
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    ft = "markdown",
  }

-- Source: https://github.com/bashbunni/dotfiles/blob/main/.config/nvim/init.vim
-- fullstack dev
-- Plug 'pangloss/vim-javascript' "JS support
-- Plug 'leafgarland/typescript-vim' "TS support
-- Plug 'maxmellon/vim-jsx-pretty' "JS and JSX syntax
-- Plug 'jparise/vim-graphql' "GraphQL syntax
-- Plug 'mattn/emmet-vim'

-- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
