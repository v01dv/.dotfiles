-- paru efm-langserver
-- Example configuations here: https://github.com/mattn/efm-langserver

local lsp_config = require('lspconfig')
-- local on_attach = require('lsp.on_attach')
local eslint = require('lsp.efm.eslint')
local prettier = require('lsp.efm.prettier')
local shfmt = require('lsp.efm.shfmt')
local lua_format = require('lsp.efm.lua-format')

local vint = require "lsp.efm.vint"
local luafmt = require "lsp.efm.luafmt"
local golint = require "lsp.efm.golint"
local goimports = require "lsp.efm.goimports"
local black = require "lsp.efm.black"
local isort = require "lsp.efm.isort"
local flake8 = require "lsp.efm.flake8"
local mypy = require "lsp.efm.mypy"
-- local prettier = require "efm/prettier"
-- local eslint = require "efm/eslint"
local shellcheck = require "lsp.efm.shellcheck"
local terraform = require "lsp.efm.terraform"
local misspell = require "lsp.efm.misspell"
local markdownlint = require "lsp.efm.markdownlint"
local markdownPandocFormat = require "lsp.efm.pandoc"

local DATA_PATH = vim.fn.stdpath('data')

require"lspconfig".efm.setup {
    -- init_options = {initializationOptions},
    cmd = {DATA_PATH .. "/lsp_servers/efm/efm-langserver"},
    -- on_attach = require'lsp'.common_on_attach,

    -- on_attach = function(client)
    --   client.resolved_capabilities.rename = false
    --   client.resolved_capabilities.hover = false
    --   client.resolved_capabilities.document_formatting = true
    --   client.resolved_capabilities.completion = false
    -- end,
    init_options = {documentFormatting = true, codeAction = false},
    filetypes = {"lua", "python", "javascriptreact", "javascript", "typescript","typescriptreact","sh", "html", "css", "json", "yaml", "markdown" },
    root_dir = vim.loop.cwd,
    -- root_dir = function()
    --     return nil
    -- end,
    settings = {
        rootMarkers = {".git/"},
        languages = {
--            python = python_arguments,
            -- lua = luaFormat,
            -- sh = {shfmt, shellcheck},
            javascript = {eslint},
            javascriptreact = {eslint},
			typescript = {eslint},
			typescriptreact = {eslint},
            html = {prettier},
            css = {prettier},
            json = {prettier},
            yaml = {prettier},
            markdown = {markdownPandocFormat}
            -- javascriptreact = {prettier, eslint},
            -- javascript = {prettier, eslint},
            -- markdown = {markdownPandocFormat, markdownlint},
        }
    }
}

-- Also find way to toggle format on save
-- maybe this will help: https://superuser.com/questions/439078/how-to-disable-autocmd-or-augroup-in-vim
