-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`

local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)

  vim.keymap.set("n", "l", api.node.open.edit, opts "Open")
  vim.keymap.set("n", "h", api.node.navigate.parent_close, opts "Close Directory")
  vim.keymap.set("n", "v", api.node.open.vertical, opts "Open: Vertical Split")
  vim.keymap.del("n", "<C-k>", { buffer = bufnr })
  vim.keymap.set("n", "<S-k>", api.node.open.preview, opts "Open Preview")
end


nvim_tree.setup {
  on_attach = my_on_attach,
  hijack_netrw = false,
  sync_root_with_cwd = true,
  view = {
    adaptive_size = true,
    relativenumber = true,
    -- hide_root_folder = false,
  },
  renderer = {
    add_trailing = false,
    group_empty = false,
    highlight_git = false,
    full_name = false,
    highlight_opened_files = "none",
    root_folder_label = ":t",
    indent_width = 2,
    indent_markers = {
      enable = false,
      inline_arrows = true,
      icons = {
        corner = "└",
        edge = "│",
        item = "│",
        none = " ",
      },
    },
    icons = {
      git_placement = "before",
      padding = " ",
      symlink_arrow = " ➛ ",
      glyphs = {
        default = "",
        symlink = "",
        bookmark = "",
        folder = {
          arrow_closed = "",
          arrow_open = "",
          default = "󰉋 ",
          open = " ",
          empty = " ",
          empty_open = " ",
          symlink = " ",
          symlink_open = " ",
        },
        git = {
        -- unstaged = "",
          unstaged = "✗",
        --staged = "✓",
          staged = "S",
          unmerged = "",
        -- renamed = "➜",
          renamed = " ",
        --untracked = "★",
          untracked = "U",
          deleted = " ",
          ignored = "◌",
        },
      },
    },
    special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
    symlink_destination = true,
  },
  update_focused_file = {
    enable = true,
    debounce_delay = 15,
    update_root = true,
    ignore_list = {},
  },

  diagnostics = {
    enable = false,
    show_on_dirs = false,
    show_on_open_dirs = true,
    debounce_delay = 50,
    severity = {
      min = vim.diagnostic.severity.HINT,
      max = vim.diagnostic.severity.ERROR,
    },
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  -- Hide .git Directory
  filters = { custom = { "^.git$" } },
}

