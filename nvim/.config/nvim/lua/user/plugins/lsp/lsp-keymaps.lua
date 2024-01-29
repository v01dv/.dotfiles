local M ={}

function M.lsp_keymaps(bufnr)

  -- vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = bufnr, desc = 'LSP: [r]e[n]ame' })
  -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'LSP: [g]oto [d]efinition'})
  -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'LSP: [g]oto [r]eferences' })
  -- vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, { desc = 'LSP: [g]oto [i]mplementation' })
  -- vim.keymap.set('n', "<leader>D", vim.lsp.buf.type_definition, { desc = 'LSP: [ ] Type [D]efinition' })
  -- vim.keymap.set('n', '<space>ds', vim.lsp.buf.document_symbol, { desc = 'LSP: [d]ocument [s]ymbols' })
  -- vim.keymap.set('n', '<space>ws', vim.lsp.buf.workspace_symbol, { desc = 'LSP: [w]orkspace [s]ymbols' })

  vim.keymap.set({ "n",  "v"}, "<leader>f", "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", { buffer = bufnr, desc = 'LSP: Format current buffer' })
  vim.keymap.set('n', '<leader>rn', M.rename, { expr = true, buffer = bufnr, desc = 'LSP: [r]e[n]ame' })
  vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { buffer = bufnr, desc = 'LSP: [c]ode [a]ction'})

  -- reuse_win (boolean) Jump to existing window if buffer is already open.
  vim.keymap.set('n', 'gd', function() require('telescope.builtin').lsp_definitions({ reuse_win = true }) end, { buffer = bufnr, desc = 'LSP: [g]oto [d]efinition' })

  vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, { buffer = bufnr, desc = 'LSP: [g]oto [r]eferences' })

  vim.keymap.set('n', 'gI', function() require("telescope.builtin").lsp_implementations({ reuse_win = true }) end, { buffer = bufnr, desc = 'LSP: [g]oto [i]mplementation' })

  vim.keymap.set('n', "<leader>D", function() require("telescope.builtin").lsp_type_definitions({ reuse_win = true }) end, { buffer = bufnr, desc = 'LSP: [ ] Type [D]efinition' })

  -- vim.keymap.set('n', '<space>ds', "<cmd>Telescope lsp_document_symbols<cr>", { desc = 'LSP: [d]ocument [s]ymbols' })
  vim.keymap.set('n', '<leader>ds', require('telescope.builtin').lsp_document_symbols, { buffer = bufnr, desc = 'LSP: [d]ocument [s]ymbols' })

  vim.keymap.set('n', '<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, { buffer = bufnr, desc = 'LSP: [w]orkspace [s]ymbols' })

  vim.keymap.set("n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', { buffer = bufnr, desc = 'LSP: goto prev'})
  vim.keymap.set("n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', { buffer = bufnr, desc = 'LSP: goto next'})
  vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { buffer = bufnr, desc = 'LSP: Floating diagnostic'})

  vim.keymap.set("n", "<leader>lt", "<cmd>lua require('user.plugins.lsp.utils').toggle_diagnostics()<cr>", { buffer = bufnr, desc = "LSP: Toggle Inline Diagnostics" })

  -- See `:help K` for why this keymap
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, desc = 'LSP: Hover Documentation' })
  vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, { buffer = bufnr, desc = 'LSP: Signature Help' })

  vim.keymap.set("n", "lh", function() vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled()) end, { buffer = bufnr, desc = 'LSP: Toggle inlay hints' })

  -- Lesser used LSP functionality
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = bufnr, desc = 'LSP: [g]oto [D]eclaration' })
end

function M.rename()
  if pcall(require, "inc_rename") then
    return ":IncRename " .. vim.fn.expand "<cword>"
  else
    vim.lsp.buf.rename()
  end
end

return M
