-- [[Demo] Lua Autocmds in Neovim (by the author of Lua Autocmds) - YouTube](https://www.youtube.com/watch?v=ekMIIAqTZ34)
local function augroup(name)
  return vim.api.nvim_create_augroup("vovk_" .. name, { clear = true })
end

-- Fixes Autocomment
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  group = augroup "auto_format_options",
  callback = function()
    vim.cmd "set formatoptions-=cro"
  end,
})

-- Close windows from list by pressing q button
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup "close_with_q",
  pattern = {
    "netrw",
    "Jaq",
    "qf",
    "git",
    "help",
    "man",
    "lspinfo",
    "oil",
    "spectre_panel",
    "lir",
    "DressingSelect",
    "tsplayground",
    "checkhealth",
    "fugitive",
    "neotest-output",
    "neotest-summary",
    "query",
    "toggleterm",
    "notify",
    "vim",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })

    -- vim.cmd [[
    --   nnoremap <silent> <buffer> q :close<CR>
    --   set nobuflisted
    -- ]]
  end,
})

-- vim.api.nvim_create_autocmd({ "FileType" }, {
--   group = augroup "help_on_vertical_split",
--   callback = function()
--     vim.cmd "wincmd L"
--   end,
-- })

-- Always opening Vim help in a vertical split window
vim.api.nvim_create_autocmd({ "CmdWinEnter" }, {
  callback = function()
    vim.cmd "quit"
  end,
})

vim.api.nvim_create_autocmd({ "VimResized" }, {
  callback = function()
    vim.cmd "tabdo wincmd ="
  end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  pattern = { "*" },
  callback = function()
    vim.cmd "checktime"
  end,
})

--TODO: Not used. For now I set YankColor into colorScheme.lua
-- https://jdhao.github.io/2020/09/22/highlight_groups_cleared_in_nvim/
-- vim.api.nvim_create_autocmd({ "ColorScheme" }, {
--   -- group = augroup "highlight_yank",
--   pattern = { "*" },
--   callback = function()
--     vim.cmd "highlight YankColor guifg=#303446 guibg=#F4B8E4"
--   end,
-- })

-- Highlight yanked text for 200ms
-- https://jdhao.github.io/2020/09/22/highlight_groups_cleared_in_nvim/
-- https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  group = augroup "highlight_yank",
  pattern = { "*" },
  callback = function()
    vim.highlight.on_yank { higroup = "YankColor", timeout = 200 }
  end,
})

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd("FocusGained", { command = "checktime" })

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup "wrap_spell",
  pattern = { "gitcommit", "markdown", "NeogitCommitMessage" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Explained here: https://www.youtube.com/live/KGJV0n70Mxs?si=UtTYVARxpgi76gjC&t=13206
vim.api.nvim_create_autocmd({ "CursorHold" }, {
  callback = function()
    local status_ok, luasnip = pcall(require, "luasnip")
    if not status_ok then
      return
    end
    if luasnip.expand_or_jumpable() then
      -- ask maintainer for option to make this silent
      -- luasnip.unlink_current()
      vim.cmd [[silent! lua require("luasnip").unlink_current()]]
    end
  end,
})

-- Go to last loction when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup "last_loc",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Remove whitespace at the end of line
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup "space_remover",
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

-- show cursor line only in active window
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
  callback = function()
    local ok, cl = pcall(vim.api.nvim_win_get_var, 0, "auto-cursorline")
    if ok and cl then
      vim.wo.cursorline = true
      vim.api.nvim_win_del_var(0, "auto-cursorline")
    end
  end,
})
vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
  callback = function()
    local cl = vim.wo.cursorline
    if cl then
      vim.api.nvim_win_set_var(0, "auto-cursorline", cl)
      vim.wo.cursorline = false
    end
  end,
})
