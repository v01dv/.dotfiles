return {
  "jellydn/hurl.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    -- Optional, for markdown rendering with render-markdown.nvim
    {
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { "markdown" },
      },
      ft = { "markdown" },
    },
  },
  ft = "hurl",
  opts = {
    -- Specify your custom environment file name here
    -- 'hurl.env',
    env_file = { '.env.development.local' },
    -- Custom below to add your own fixture variables
    -- The callback function is executed every time the variable is used in the .hurl file.
    fixture_vars = {
      {
        name = 'random_int_number',
        callback = function()
          return math.random(1, 1000)
        end,
      },
      {
        name = 'random_float_number',
        callback = function()
          local result = math.random() * 10
          return string.format('%.2f', result)
        end,
      },
    },
    -- Show debugging info
    debug = false,
    -- Show notification on run
    show_notification = false,
    -- Show response in popup or split
    mode = "split",
    -- Default formatter
    formatters = {
      json = { 'jq' }, -- Make sure you have install jq in your system, e.g: brew install jq
      html = {
        'prettier', -- Make sure you have install prettier in your system, e.g: npm install -g prettier
        '--parser',
        'html',
      },
      xml = {
        'tidy', -- Make sure you have installed tidy in your system, e.g: brew install tidy-html5
        '-xml',
        '-i',
        '-q',
      },
    },
    -- Default mappings for the response popup or split views
    mappings = {
      close = 'q', -- Close the response popup or split view
      next_panel = '<C-n>', -- Move to the next response popup window
      prev_panel = '<C-p>', -- Move to the previous response popup window
    },
  },
  keys = {
    -- Run API request
    { "<leader>H", "<cmd>HurlRunner<CR>", desc = "Run All requests" },
    { "<leader>h", "<cmd>HurlRunnerAt<CR>", desc = "Run Api request" },
    { "<leader>he", "<cmd>HurlRunnerToEntry<CR>", desc = "Run Api request to entry" },
    { "<leader>hE", "<cmd>HurlRunnerToEnd<CR>", desc = "Run Api request from current entry to end" },
    { "<leader>hm", "<cmd>HurlToggleMode<CR>", desc = "Hurl Toggle Mode" },
    { "<leader>hv", "<cmd>HurlVerbose<CR>", desc = "Run Api in verbose mode" },
    { "<leader>hV", "<cmd>HurlVeryVerbose<CR>", desc = "Run Api in very verbose mode" },

    { "<leader>hl", "<cmd>HurlShowLastResponse<CR>", desc = "View the response of the last HTTP request" },
    { "<leader>ha", "<cmd>HurlManageVariable<CR>", desc = "View and manage environment variables" },
    -- Run Hurl request in visual mode
    { "<leader>h", ":HurlRunner<CR>", desc = "Hurl Runner", mode = "v" },
  },
}
