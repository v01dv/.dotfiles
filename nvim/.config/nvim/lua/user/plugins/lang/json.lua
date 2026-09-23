if not require('user.config').pde.json then
  return {}
end

return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'json5' } },
  },
  {
    'mason-org/mason.nvim',
    opts = {
      ensure_installed = {
        'json-lsp',
      },
    },
  },
  -- yaml schema support
  {
    'b0o/SchemaStore.nvim',
    lazy = true,
    -- That means on each update the plugin may fetch the latest commit rather
    -- than being restricted to a release like v0.2.0
    version = false, -- last release is way too old
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      -- make sure mason installs the server
      servers = {
        jsonls = {
          -- lazy-load schemastore when needed
          before_init = function(_, new_config)
            new_config.settings.json.schemas = new_config.settings.json.schemas or {}
            vim.list_extend(new_config.settings.json.schemas, require('schemastore').json.schemas())
          end,
          settings = {
            json = {
              format = {
                enable = true,
              },
              validate = { enable = true },
            },
          },
        },
      },
    },
  },
}
