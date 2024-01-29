-- The language servers are configured here

local M = {}

local lsp_utils = require "user.plugins.lsp.utils"
local icons = require "user.config.icons"

local function lsp_init()

  local signs = {
    active = true,
    -- values = {
      { name = "DiagnosticSignError", text = icons.diagnostics.BoldError },
      { name = "DiagnosticSignWarn", text = icons.diagnostics.BoldWarning },
      { name = "DiagnosticSignHint", text = icons.diagnostics.BoldHint },
      { name = "DiagnosticSignInfo", text = icons.diagnostics.BoldInformation },
    -- },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
  end

  local config = {
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
    },

    diagnostic = {
      -- virtual_text = false,
      virtual_text = {
        spacing = 4,
        -- source = "if_many",
        prefix = "●", -- " ", -- ■
        severity = {
            min = vim.diagnostic.severity.ERROR,
        },
        -- prefix = vim.fn.has('nvim-0.10') > 0 and
        --   function(diagnostic, i, total) ---@param diagnostic Diagnostic
        --     for d, icon in pairs(icons) do
        --       if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
        --         return icon
        --       end
        --     end
        --   end
      },
      update_in_insert = false,
      underline = false,
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
  }

  -- Diagnostic configuration
  vim.diagnostic.config(config.diagnostic)

  -- Hover configuration
  -- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, config.float)

  -- Signature help configuration
  -- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, config.float)

  require("lspconfig.ui.windows").default_options.border = "rounded"
end

function M.setup(_, opts)
  lsp_utils.on_attach(function(client, bufnr)
    -- require("plugins.lsp.format").on_attach(client, bufnr)
    -- require("plugins.lsp.keymaps").on_attach(client, bufnr)
    require("user.plugins.lsp.lsp-keymaps").lsp_keymaps(bufnr)

    -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
    -- Be aware that you also will need to properly configure your LSP server to
    -- provide the inlay hints.
    -- For instance, hints for LUA shoud be enabled into the LSP configuration file (/lspsettings/lua_ls.lua) in hint section.
    -- hint = { enable = true }
    if require("user.config").inlayHint then
      if client.supports_method "textDocument/inlayHint" then
        vim.lsp.inlay_hint.enable(bufnr, true)
      end
    end

  end)

  lsp_init() -- diagnostics, handlers

  local servers = opts.servers
  local capabilities = lsp_utils.common_capabilities()

  local function setup(server)
    local server_opts = vim.tbl_deep_extend("force", {
      -- Capabilities are way to saying to a language server what your client is able to do.
      -- Clients and servers tell each other at the beginning what they can both do.
      capabilities = capabilities,
    }, servers[server] or {})

    if opts.setup[server] then
      if opts.setup[server](server, server_opts) then
        return
      end
    elseif opts.setup["*"] then
      if opts.setup["*"](server, server_opts) then
        return
      end
    end
    require("lspconfig")[server].setup(server_opts)
  end

  -- Add bun for Node.js-based servers
  -- local lspconfig_util = require "lspconfig.util"
  -- local add_bun_prefix = require("plugins.lsp.bun").add_bun_prefix
  -- lspconfig_util.on_setup = lspconfig_util.add_hook_before(lspconfig_util.on_setup, add_bun_prefix)

  -- get all the servers that are available thourgh mason-lspconfig
  local has_mason, mlsp = pcall(require, "mason-lspconfig")
  local all_mslp_servers = {}
  if has_mason then
    all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
  end

  local ensure_installed = {} ---@type string[]
  for server, server_opts in pairs(servers) do
    if server_opts then
      server_opts = server_opts == true and {} or server_opts
      -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
      if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
        setup(server)
      else
        ensure_installed[#ensure_installed + 1] = server
      end
    end
  end

  if has_mason then
    mlsp.setup { ensure_installed = ensure_installed }
    mlsp.setup_handlers { setup }
  end
end

return M
