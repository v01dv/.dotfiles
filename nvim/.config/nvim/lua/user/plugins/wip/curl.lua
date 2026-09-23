return {
  'oysandvik94/curl.nvim',
  cmd = { 'CurlOpen' },
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = {
    -- Table of strings to specify default headers to be included in each request, i.e. "-i"
    default_flags = {},
    -- Specify how to open curl
    -- use "tab" to open in separate tab
    -- use "split" to open in horizontal split
    -- use "vsplit" to open in vertical split
    -- use "buffer" to open in new buffer
    open_with = 'vsplit', -- Default 'tab'
    mappings = {
      execute_curl = '<CR>',
    },
  },
  config = true,
}
