require("user.config.options")
require("user.config.lazy")

if vim.fn.argc(-1) == 0 then
  vim.api.nvim_create_autocmd("User", {
    group = vim.api.nvim_create_augroup("OhNeovim", { clear = true }),
    -- LazyDone: When lazy.nvim has finished starting up and loaded our config.
    -- VeryLazy: Triggered after LazyDone and processing VimEnter auto commands.
    pattern = "VeryLazy",
    callback = function()
      require "user.config.autocmds"
      require "user.config.keymaps"
    end,
  })
else
  require "user.config.autocmds"
  require "user.config.keymaps"
end
