--https://clangd.llvm.org/installation.html
--paru clang
require'lspconfig'.clangd.setup {
    cmd = { "clangd", "--background-index" },
--    on_attach = require'lsp'.common_on_attach,
    handlers = {
        ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
            virtual_text = {spacing = 0, prefix = ""},
            signs = true,
            underline = true,
            update_in_insert = true
        })
    }
}
