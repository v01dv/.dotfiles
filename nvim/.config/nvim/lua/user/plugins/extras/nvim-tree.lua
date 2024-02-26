return {
  "nvim-tree/nvim-tree.lua",
  event = "VeryLazy",
  cmd = { "NvimTreeToggle" },
  config = function()

    local function my_on_attach(bufnr)
      local api = require "nvim-tree.api"

      local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      -- default mappings
      api.config.mappings.default_on_attach(bufnr)

      -- custom mappings
      vim.keymap.set("n", "l", api.node.open.edit, opts "Open")
      vim.keymap.set("n", "h", api.node.navigate.parent_close, opts "Close Directory")
      vim.keymap.set("n", "v", api.node.open.vertical, opts "Open: Vertical Split")
      vim.keymap.del("n", "<C-k>", { buffer = bufnr })
      vim.keymap.set("n", "<S-k>", api.node.open.preview, opts "Open Preview")
    end

    local icons = require "user.config.icons"

    require("nvim-tree").setup {
      on_attach = my_on_attach,
      disable_netrw = false,
      hijack_netrw = true,
      -- sync_root_with_cwd = true,
      modified = {
        enable = true,
      },
      view = {
        adaptive_size = true,
        relativenumber = true,
        number = true,
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
          show = {
            file = false,
            folder = false,
            git = false,
          },
          git_placement = "before",
          modified_placement = "after",
          padding = " ",
          symlink_arrow = " ➛ ",
          glyphs = {
            default = icons.ui.Text,
            symlink = icons.ui.FileSymlink,
            bookmark = icons.ui.BookMark,
            modified = "[+]",
            folder = {
              arrow_closed = icons.ui.ChevronRight,
              arrow_open = icons.ui.ChevronShortDown,
              default = icons.ui.Folder,
              open = icons.ui.FolderOpen,
              empty = icons.ui.EmptyFolder,
              empty_open = icons.ui.EmptyFolderOpen,
              symlink = icons.ui.FolderSymlink,
              symlink_open = icons.ui.FolderOpen,
            },
            git = {
              unstaged = icons.git.FileUnstaged,
              staged = icons.git.FileStaged,
              unmerged = icons.git.FileUnmerged,
              renamed = icons.git.FileRenamed,
              untracked = icons.git.FileUntracked,
              deleted = icons.git.FileDeleted,
              ignored = icons.git.FileIgnored,
            },
          },
        },
        special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
        symlink_destination = true,
      },
      -- update_focused_file = {
      --   enable = true,
      --   debounce_delay = 15,
      --   update_root = true,
      --   ignore_list = {},
      -- },
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
          hint = icons.diagnostics.BoldHint,
          info = icons.diagnostics.BoldInformation,
          warning = icons.diagnostics.BoldWarning,
          error = icons.diagnostics.BoldError,
        },
      },
      -- Hide .git Directory
      filters = { custom = { "^.git$" } },
      actions = {
        open_file = {
          quit_on_open = true,
        },
      },
    }

    local function toggle_in_place()
      local api = require("nvim-tree.api")
      if api.tree.is_visible() then
        api.tree.close()
      else
        api.tree.open({
          path = nil,
          current_window = true,
          find_file = false,
          update_root = false,
        })
      end
    end

    vim.keymap.set("n", "-", toggle_in_place, { desc = "[-] NvimTree netrw style" })
    vim.keymap.set("n", "<leader>n", ":NvimTreeToggle<cr>", { desc = "[n]vimTree file explorer" })
  end
}

