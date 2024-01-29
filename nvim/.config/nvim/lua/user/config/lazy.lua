local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup{
  spec = {
    { import = "user.plugins" },
    -- { import = "user.plugins.ui" },
    -- { import = "user.plugins.notes" },
    -- { import = "user.plugins.ai" },
    { import = "user.pde" },
  },
  -- We want to lazy load plugins, and always install the latest plugins
  defaults = { lazy = true, version = nil },
  install = {
    colorscheme = { "catppuccin" }, -- "tokyonight"
  },
  -- automatically check for plugin updates
  checker = { enabled = true },
  ui = {
    border = "rounded",
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
        "gzip",
        "matchit",
        "matchparen",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
        -- "netrwPlugin",
      },
    },
  },
}

-- vim.keymap.set("n", "<leader>z", "<cmd>:Lazy<cr>", { desc = "Plugin Manager" })
