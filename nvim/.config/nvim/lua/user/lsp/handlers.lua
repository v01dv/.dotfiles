local M = {}

--fn.sign_define(
--  "LspDiagnosticsSignError",
--  { text = "", texthl = "LspDiagnosticsDefaultError" }
--  { text = "", texthl = "LspDiagnosticsDefaultError" }
--  { text = "", texthl = "LspDiagnosticsDefaultError" }  -- 'ﰸ'
--)
--fn.sign_define(
--  "LspDiagnosticsSignWarning",
--  { text = "", texthl = "lspdiagnosticsdefaultwarning" }
--  { text = "", texthl = "lspdiagnosticsdefaultwarning" }
--  { text = "", texthl = "LspDiagnosticsDefaultWarning"}
--)
--fn.sign_define(
--  "LspDiagnosticsSignInformation",
--  { text = "", texthl = "LspDiagnosticsDefaultInformation" }    -- ""
--  { text = "", texthl = "LspDiagnosticsDefaultInformation" }
--  { text = "", texthl = "LspDiagnosticsDefaultInformation" }
--)
--fn.sign_define(
--  "LspDiagnosticsSignHint",
--  { text = "", texthl = "LspDiagnosticsDefaultHint" }
--  { text = "", texthl = "LspDiagnosticsDefaultHint" }  -- '' -- ''
--  { text = "", texthl = "LspDiagnosticsDefaultHint" }
--)

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
  return
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

M.setup = function()
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    virtual_text = true, -- disable virtual text
    signs = {
      active = signs,     -- show signs
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

local function attach_navic(client, bufnr)
  vim.g.navic_silence = true
  local status_ok_1, navic = pcall(require, "nvim-navic")
  if not status_ok_1 then
    return
  end
  navic.attach(client, bufnr)
end

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true, buffer=bufnr }

  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'LSP: [r]e[n]ame' })
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'LSP: [c]ode [a]ction'})

  -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'LSP: [g]oto [d]efinition'})
  vim.keymap.set('n', 'gd', "<cmd>Telescope lsp_definitions<cr>", {  desc = 'LSP: [g]oto [d]efinition' })

  -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'LSP: [g]oto [r]eferences' })
  vim.keymap.set('n', 'gr', "<cmd>Telescope lsp_references<cr>", { desc = 'LSP: [g]oto [r]eferences' })

  -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'LSP: [g]oto [i]mplementation' })
  vim.keymap.set('n', 'gi',"<cmd>Telescope lsp_implementations<cr>", { desc = 'LSP: [g]oto [i]mplementation' })

  -- vim.keymap.set('n', "<leader>D", vim.lsp.buf.type_definition, { desc = 'LSP: [ ] Type [D]efinition' })
  vim.keymap.set('n', "<leader>D", "<cmd>Telescope lsp_type_definitions<cr>", { desc = 'LSP: [ ] Type [D]efinition' })

  -- vim.keymap.set('n', '<space>ds', vim.lsp.buf.workspace_symbol, { desc = 'LSP: [d]ocument [s]ymbols' })
  vim.keymap.set('n', '<space>ds', "<cmd>Telescope lsp_document_symbols<cr>", { desc = 'LSP: [d]ocument [s]ymbols' })
  vim.keymap.set('n', '<space>ws', "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", { desc = 'LSP: [w]orkspace [s]ymbols' })

  vim.keymap.set("n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', { desc = 'LSP: goto prev'})
  vim.keymap.set("n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', { desc = 'LSP: goto next'})
  vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = 'LSP: Floating diagnostic'})
  vim.keymap.set('n', "<leader>q", vim.diagnostic.setloclist, { desc = 'LSP: Diagnostic setloclist'})

  -- vim.keymap.set('n', '<leader>cl', vim.lsp.codelens.run, opts) -- ???

  -- See `:help K` for why this keymap
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'LSP: Hover Documentation' })
  vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, { desc = 'LSP: Signature Help' })

  -- Lesser used LSP functionality
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'LSP: [g]oto [D]eclaration' })

end

M.on_attach = function(client, bufnr)
  lsp_keymaps(bufnr)
  attach_navic(client, bufnr)

  if client.name == "tsserver" then
    -- client.server_capabilities.document_formatting = false
    client.resolved_capabilities.document_formatting = false -- 0.7 and earlier
    client.server_capabilities.documentFormattingProvider = false -- 0.8 and later
  end

  -- if client.name == "tsserver" then
  --   require("lsp-inlayhints").on_attach(client, bufnr)
  -- end

  if client.name == "sumneko_lua" then
    -- client.server_capabilities.document_formatting = false
    client.resolved_capabilities.document_formatting = false -- 0.7 and earlier
    client.server_capabilities.documentFormattingProvider = false -- 0.8 and later
    vim.lsp.codelens.refresh()
  end

  local status_ok, illuminate = pcall(require, "illuminate")
  if not status_ok then
    return
  end
  illuminate.on_attach(client)
end

return M
