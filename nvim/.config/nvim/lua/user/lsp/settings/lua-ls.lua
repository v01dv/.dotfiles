-- https://github.com/sumneko/lua-language-server/wiki/Build-and-Run-(Standalone)
local custom_on_attach = require("lsp").custom_on_attach


USER = vim.fn.expand('$USER')

sumneko_root_path = "/home/" .. USER .. "/.config/nvim/language-servers/lua-language-server"
sumneko_binary = "/home/" .. USER .. "/.config/nvim/language-servers/lua-language-server/bin/Linux/lua-language-server"

require'lspconfig'.sumneko_lua.setup {
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
  on_attach = custom_on_attach,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
        preloadFileSize = 400,
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}
