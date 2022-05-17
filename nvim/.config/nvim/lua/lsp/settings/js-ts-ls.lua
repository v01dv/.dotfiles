-- npm install -g typescript typescript-language-server
-- require'snippets'.use_suggested_mappings()
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true;
-- local on_attach_common = function(client)
-- print("LSP Initialized")
-- require'completion'.on_attach(client)
-- require'illuminate'.on_attach(client)
-- end

--local DATA_PATH = vim.fn.stdpath('data')
local cwd  = vim.loop.cwd();

require'lspconfig'.tsserver.setup {
    cmd = {"typescript-language-server", "--stdio"},
    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
    -- This makes sure tsserver is not used for formatting (I prefer prettier)
    on_attach = function(client, bufnr)
        client.resolved_capabilities.document_formatting = false
        require'lsp'.custom_on_attach(client, bufnr)
    end,
--    root_dir = require('lspconfig/util').root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
    root_dir = vim.loop.cwd;
    settings = {documentFormatting = false},
    handlers = {
       ["textDocument/publishDiagnostics"] = require('lsp').is_using_eslint,
     }
    -- handlers = {
    --     ["textDocument/publishDiagnostics"] = vim.lsp.with(
    --         vim.lsp.diagnostic.on_publish_diagnostics, {
    --             virtual_text = {
    --                 prefix = "",
    --                 spacing = 0
    --             },
    --             signs = true,
    --             underline = true,
    --             update_in_insert = true
    --     })
    -- }
}
