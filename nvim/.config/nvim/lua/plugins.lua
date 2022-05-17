local execute = vim.api.nvim_command
local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  --vim.cmd [[packadd packer.nvim]]
  execute 'packadd packer.nvim'
end

--if fn.empty(fn.glob(install_path)) > 0 then
--  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
--  execute 'packadd packer.nvim'
--end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
--return require('packer').startup(function(use)
return packer.startup(function(use)
  use "wbthomason/packer.nvim" -- Packer can manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
  use "numToStr/Comment.nvim" -- Easily comment stuff
--  use "ahmedkhalf/project.nvim"
  use "nvim-telescope/telescope-project.nvim"
  use "folke/which-key.nvim"
  use "rcarriga/nvim-notify"
  use "phaazon/hop.nvim"
--  use "ray-x/lsp_signature.nvim"

  use {"ahmedkhalf/lsp-rooter.nvim"}
  use {
    "folke/todo-comments.nvim",
    requires = {"nvim-lua/plenary.nvim"}
  }
  use "simrat39/symbols-outline.nvim"
  use "MattesGroeger/vim-bookmarks"

  -- Icons
  use "kyazdani42/nvim-web-devicons" -- for file icons

  -- File explorer
  use {
   "kyazdani42/nvim-tree.lua",
   requires = "kyazdani42/nvim-web-devicons"
  }

  -- Status line
  use {
    "glepnir/galaxyline.nvim",
    branch = 'main'
  }
  -- use "nvim-lualine/lualine.nvim"

  -- Buffer line
  use {
    "akinsho/bufferline.nvim",
    requires = 'kyazdani42/nvim-web-devicons'
  }

  use "moll/vim-bbye"

  -- Better window and buffer management
  use {
    "mhinz/vim-sayonara",
    cmd = "Sayonara",
  }

  use "lukas-reineke/indent-blankline.nvim"

  -- Colors
  use 'arcticicestudio/nord-vim'
  use "norcalli/nvim-colorizer.lua"
  --use 'folke/tokyonight.nvim'
  
  -- Autocomplete
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-nvim-lua"
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "hrsh7th/cmp-nvim-lsp"
  -- use "hrsh7th/cmp-nvim-lsp-document-symbol"

-- Snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  --LSP
  use "neovim/nvim-lspconfig"  -- enable LSP
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
  use "b0o/SchemaStore.nvim"

-- Telescope
  use "nvim-telescope/telescope.nvim"
  use {
    "nvim-telescope/telescope-fzf-native.nvim",
    run = "make"
  }
  use "nvim-telescope/telescope-media-files.nvim"
  use "tom-anders/telescope-vim-bookmarks.nvim"

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate"
  }
  use 'p00f/nvim-ts-rainbow'

  use {
    "JoosepAlviste/nvim-ts-context-commentstring"
    --event = "BufReadPost"
  }

  -- Git
  use {
    "lewis6991/gitsigns.nvim",
    requires = {"nvim-lua/plenary.nvim" }
    --event = "BufRead"
  }
--use {'f-person/git-blame.nvim'}
  --use {'tpope/vim-fugitive'}
  --use { 'sindrets/diffview.nvim' }

  -- Debugging
  use {"mfussenegger/nvim-dap"}

  -- Terminal
  use {
    "akinsho/toggleterm.nvim",
    --event = "BufWinEnter",
  }

  --   FOCUSING:
  use "folke/zen-mode.nvim"
  -- use "folke/twilight.nvim"

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
