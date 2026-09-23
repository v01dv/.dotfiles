local M = {}

function M.lsp_keymaps(bufnr)
  -- Jump to the definition of the word under the cursor.
  --  This is where a variable was first declared, or where a function is defined, etc.
  --  To jump back, press <C-t>. To jump next, press <C-i>.
  -- reuse_win (boolean) Jump to existing window if buffer is already open.
  vim.keymap.set('n', 'gd', function()
    require('telescope.builtin').lsp_definitions { reuse_win = true }
  end, { buffer = bufnr, desc = 'LSP: [g]oto [d]efinition' })
end

return M
