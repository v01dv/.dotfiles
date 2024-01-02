-- npm install -g vscode-html-languageserver-bin

local custom_capabilities = require("lsp").custom_capabilities
local custom_on_attach = require("lsp").custom_on_attach

require'lspconfig'.html.setup {
    cmd = {"html-languageserver", "--stdio"},
    on_attach = custom_on_attach,
    capabilities = custom_capabilities
}

