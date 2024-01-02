-- npm install -g vscode-css-languageserver-bin
local custom_capabilities = require("lsp").custom_capabilities
local custom_on_attach = require("lsp").custom_on_attach

require'lspconfig'.cssls.setup {
    cmd = { "css-languageserver", "--stdio" },
    on_attach = custom_on_attach,
    capabilities = custom_capabilities
}
