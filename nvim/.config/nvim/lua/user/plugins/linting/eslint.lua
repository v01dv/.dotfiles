-- Set to false to disable auto format
vim.g.lazyvim_eslint_auto_format = true

-- If the user did not set vim.g.lazyvim_eslint_auto_format, treat it as enabled by default.
local auto_format = vim.g.lazyvim_eslint_auto_format == nil or vim.g.lazyvim_eslint_auto_format

local gaf = vim.g.autoformat == nil or vim.g.autoformat

return {
  {
    'neovim/nvim-lspconfig',
    -- other settings removed for brevity
    opts = {
      ---@type table<string, vim.lsp.Config>
      servers = {
        eslint = {
          settings = {
            -- helps eslint find the eslintrc when it's placed in a subfolder instead of the cwd root
            experimental = {
              useFlatConfig = true,
            },
            -- helps eslint find the eslintrc when it's placed in a subfolder instead of the cwd root
            workingDirectories = { mode = 'auto' },
            format = auto_format,
          },
        },
      },
    },
  },
}
