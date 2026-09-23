-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- It must be here
-- Make my utility functions globally available to avoid using require everywhere.
_G.OhVim = require 'user.util'

OhVim.lazy_file()

require('lazy').setup {
  spec = {
    { import = 'user.plugins' },
    { import = 'user.plugins.test' },
    -- { import = "user.plugins.ui" },
    -- { import = "user.plugins.notes" },
    { import = 'user.plugins.ai' },
    -- { import = 'user.plugins.linting' }, -- commented out to avoid duplication with eslint_d
    { import = 'user.plugins.formatting' },
    -- { import = "user.plugins.db" },
    { import = 'user.plugins.lang' },
  },
  -- Need this for correect work of rest.nvim
  rocks = {
    hererocks = true, -- you should enable this to get hererocks support
    -- ISSUE: Temporary fix for:
    -- https://github.com/rest-nvim/rest.nvim/issues/559
    -- https://github.com/folke/lazy.nvim/issues/2059
    server = 'https://lumen-oss.github.io/rocks-binaries/',
  },
  -- We want to lazy load plugins, and always install the latest plugins
  defaults = { lazy = true, version = nil },
  install = {
    -- fallback colorscheme
    colorscheme = { 'catppuccin', 'tokyonight', 'rose-pine' },
  },
  -- automatically check for plugin updates
  checker = { enabled = true },
  ui = {
    border = 'rounded',
  },
  change_detection = {
    enabled = true,
    notify = false,
  },
  -- For better performance, we disable some built-in Neovim plugins
  -- in the run-time path (:h rtp).
  performance = {
    rtp = {
      disabled_plugins = {
        'gzip',
        'matchit',
        'matchparen',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
        -- "netrwPlugin",
      },
    },
  },
}
