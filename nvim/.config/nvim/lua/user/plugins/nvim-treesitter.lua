-- [Understanding Neovim #4 - Treesitter - YouTube](https://www.youtube.com/watch?v=kYXcxJxJVxQ)

return {
    {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
       "LiadOz/nvim-dap-repl-highlights",
       "JoosepAlviste/nvim-ts-context-commentstring",
    },
    opts = {
      sync_install = false,
      -- auto_install = true,
      ensure_installed = {
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        -- "bash",
        "python",
        "css",
        "yaml",
        "c",
        "cpp",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "jsdoc",
        "json",
        "json5",
        "jsonc",
        "ninja",
        "scss",
        "ssh_config",
        "xml",
        "html",
        "vim",
        "vimdoc",
        "rust",
        "go",
        "dockerfile",
        "rst",
        "toml",
        "ron",
        "dap_repl",
        -- "comment", -- comments are slowing down TS bigtime, so disable for now
      },
      highlight = {
        enable = true, -- false will disable the whole extension
        additional_vim_regex_highlighting = { "org", "markdown" }
      },
      matchup = {
        enable = true,
      },
      indent = { enable = true },
      -- incremental_selection = { enable = false },
      -- Incremental selection: Included with nvim-treesitter, see :help nvim-treesitter-incremental-selection-mod
      incremental_selection = {
        enable = true,
        keymaps = {
          -- init_selection = "<c-space>",
          node_incremental = "v",
          node_decremental = "V",
          -- scope_incremental = "<c-s>",
        },
      },
    },
    config = function(_, opts)
      -- NOTE: If you use the ensure_installed option you must first setup nvim-dap-repl-highlights
      -- or else the dap_repl parser won't be found, for example
      -- require('nvim-dap-repl-highlights').setup()

      if type(opts.ensure_installed) == "table" then
        ---@type table<string, boolean>
        local added = {}
        opts.ensure_installed = vim.tbl_filter(function(lang)
          if added[lang] then
            return false
          end
          added[lang] = true
          return true
        end, opts.ensure_installed)
      end
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    enabled = true,
    config = function()
      local npairs = require "nvim-autopairs"
      npairs.setup {
        check_ts = true,
      }
    end,
  },
  {
    "altermo/ultimate-autopair.nvim",
    enabled = false,
    event = { "InsertEnter", "CmdlineEnter" },
    branch = "v0.6",
    opts = {},
  },

}
