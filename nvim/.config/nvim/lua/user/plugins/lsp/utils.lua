local M = {}

function M.on_attach(on_attach)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local bufnr = args.buf  ---@type number
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      on_attach(client, bufnr)
    end,
  })
end


function M.common_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  -- Some language servers have snippet support built-in. And if they do
  -- I want to turn it on in most cases.
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }
  -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
  return require("cmp_nvim_lsp").default_capabilities(capabilities)
end

local diagnostics_active = true
function M.toggle_diagnostics()
  diagnostics_active = not diagnostics_active
  if diagnostics_active then
    vim.diagnostic.show()
  else
    vim.diagnostic.hide()
  end
end

return M
