return {
  'stevearc/conform.nvim',
  dependencies = { 'mason.nvim' },
  -- event = { 'BufReadPre', 'BufNewFile' },
  -- event = 'LazyFile',
  lazy = true,
  cmd = 'ConformInfo',

  -- This will provide type hinting with LuaLS
  ---@module "conform"
  ---@type conform.setupOpts
  opts = {
    default_format_opts = {
      async = false, -- not recommended to change
      quiet = false, -- not recommended to change
      lsp_format = 'fallback', -- not recommended to change
    },
    format_on_save = {
      timeout_ms = 3000,
    },
    formatters_by_ft = {
      lua = { 'stylua' },
      sh = { 'shfmt' },
    },
    -- The options you set here will be merged with the builtin formatters.
    -- You can also define any custom formatters here.
    ---@type table<string, conform.FormatterConfigOverride|fun(bufnr: integer): nil|conform.FormatterConfigOverride>
    formatters = {
      injected = { options = { ignore_errors = true } },
      -- # Example of using dprint only when a dprint.json file is present
      -- dprint = {
      --   condition = function(ctx)
      --     return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[]
      --   end,
      -- },
      --
      -- # Example of using shfmt with extra args
      -- shfmt = {
      --   prepend_args = { "-i", "2", "-ci" },
      -- },
    },
  },
  ---@param opts conform.setupOpts
  config = function(_, opts)
    local conform = require 'conform'
    conform.setup(opts)

    vim.keymap.set({ 'n', 'v' }, '<leader>cf', function()
      conform.format {}
    end, { desc = 'Format buffer' })

    vim.keymap.set({ 'n', 'v' }, '<leader>cF', function()
      conform.format { formatters = { 'injected' }, timeout_ms = 3000 }
    end, { desc = 'Format Injected Langs' })
  end,
}
