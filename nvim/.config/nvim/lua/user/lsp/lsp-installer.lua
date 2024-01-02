if not status_ok then
  local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
	return
end

-- TODO: Add automatically install LSP servers:
-- https://github.com/williamboman/nvim-lsp-installer/wiki/Advanced-Configuration#overriding-the-default-lsp-server-options
local servers = {
  "cssls",
  "cssmodules_ls",
  "html",
  "jsonls",
  "sumneko_lua",
  "tsserver",
  "pyright",
  "yamlls",
  "bashls",
  "clangd",
  -- "emmet_ls",
  -- "jdtlls",
}

local settings= {
    -- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer", "sumneko_lua" }
    -- This setting has no relation with the `automatic_installation` setting.
    ensure_installed = servers,

    -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
    -- This setting has no relation with the `ensure_installed` setting.
    -- Can either be:
    --   - false: Servers are not automatically installed.
    --   - true: All servers set up via lspconfig are automatically installed.
    --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
    --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
    -- automatic_installation = false,

    ui = {
        -- Whether to automatically check for outdated servers when opening the UI window.
        check_outdated_servers_on_open = true,

        -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
        border = "none",

        icons = {
            -- The list icon to use for installed servers.
            -- server_installed = "◍",
            -- The list icon to use for servers that are pending installation.
            -- server_pending = "◍",
            -- The list icon to use for servers that are not installed.
            -- server_uninstalled = "◍",
        },
        keymaps = {
            -- Keymap to expand a server in the UI
            toggle_server_expand = "<CR>",
            -- Keymap to install the server under the current cursor position
            install_server = "i",
            -- Keymap to reinstall/update the server under the current cursor position
            update_server = "u",
            -- Keymap to check for new version for the server under the current cursor position
            check_server_version = "c",
            -- Keymap to update all installed servers
            update_all_servers = "U",
            -- Keymap to check which installed servers are outdated
            check_outdated_servers = "C",
            -- Keymap to uninstall a server
            uninstall_server = "X",
        },
    },

    -- The directory in which to install all servers.
    install_root_dir = vim.fn.stdpath("data") ..  "/lsp_servers/",
  --
    -- Controls to which degree logs are written to the log file. It's useful to set this to vim.log.levels.DEBUG when
    -- debugging issues with server installations.
    log_level = vim.log.levels.INFO,
}

lsp_installer.setup(settings)

require("nvim-lsp-installer").setup(settings)

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local opts ={}

for _, server in pairs(servers) do
  opts = {
		on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,
  }

  if server == "jsonls" then
    local jsonls_opts = require("user.lsp.settings.jsonls")
    opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
  end

  if server == "sumneko_lua" then
	 	local sumneko_opts = require("user.lsp.settings.sumneko_lua")
	 	opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
	end

  if server == "pyright" then
    local pyright_opts = require("user.lsp.settings.pyright")
    opts = vim.tbl_deep_extend("force", pyright_opts, opts)
  end

  if server == "tsserver" then
	 	local tsserver_opts = require("user.lsp.settings.tsserver")
	 	opts = vim.tbl_deep_extend("force", tsserver_opts, opts)
	end

  if server == "emmet_ls" then
	 	local emmet_ls_opts = require("user.lsp.settings.emmet_ls")
	 	opts = vim.tbl_deep_extend("force", emmet_ls_opts, opts)
	end

  lspconfig[server].setup(opts)
end

