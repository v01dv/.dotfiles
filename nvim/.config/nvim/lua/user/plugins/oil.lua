return {
  'stevearc/oil.nvim',
  event = "VeryLazy",
  cmd = "Oil",
  config = function()
    require("oil").setup {
      columns = {
        -- "icon",
        -- "permissions",
        -- "size",
        -- "mtime",
      },
      view_options = {
        -- Show files and directories that start with "."
        show_hidden = true,
      },
      float = {
        max_height = 20,
        max_width = 60,
      },
      keymaps = {
        ["g?"] = "actions.show_help",
        ["l"] = "actions.select",
        ["v"] = "actions.select_vsplit",
        ["<C-h>"] = "actions.select_split",
        ["<C-t>"] = "actions.select_tab",
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = "actions.close",
        ["<C-l>"] = "actions.refresh",
        ["h"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = "actions.tcd",
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["g."] = "actions.toggle_hidden",
        ["g\\"] = "actions.toggle_trash",
      },
    }

    vim.keymap.set("n", "\\", "<CMD>Oil<CR>", { desc = "Open parent directory" })
  end
}
