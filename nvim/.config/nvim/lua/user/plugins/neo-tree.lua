return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  event = "VeryLazy",
  cmd = "Neotree",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup {
      -- hide_root_node = true,
      retain_hidden_root_indent = false,
      -- when opening files, do not use windows containing these filetypes or buftypes
      open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
      enable_git_status = false,
      enable_diagnostics = false,
      enable_modified_markers = false,
      use_popups_for_input = false, -- not floats for input
      default_component_configs = {
        indent = {
          -- with_markers = false,
          -- indent_marker = "│",
          -- last_indent_marker = "└",
          -- indent_size = 2,
          with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
      },
      filesystem = {
        hijack_netrw_behavior = "open_current",
        follow_current_file = { enabled = true },
        bind_to_cwd = false,
        filtered_items = {
          hide_dotfiles = false,
        },
        components = {
          -- hide file icon
          icon = function(config, node, state)
            if node.type == 'file' then
                return {
                  text = "",
                  highlight = config.highlight,
                }
            end
            return require('neo-tree.sources.common.components').icon(config, node, state)
          end,
        }
      },
      window = {
        mappings = {
          ["h"] = function(state)
            local node = state.tree:get_node()
              if node.type == 'directory' and node:is_expanded() then
                require'neo-tree.sources.filesystem'.toggle_directory(state, node)
              else
                require'neo-tree.ui.renderer'.focus_node(state, node:get_parent_id())
              end
            end,
          ["l"] = function(state)
            local node = state.tree:get_node()
              if node.type == 'directory' then
                if not node:is_expanded() then
                  require'neo-tree.sources.filesystem'.toggle_directory(state, node)
                elseif node:has_children() then
                  require'neo-tree.ui.renderer'.focus_node(state, node:get_child_ids()[1])
                end
                      else
                        require("neo-tree.sources.filesystem.commands").open(state)
              end
            end,
          ["P"] = function(state)
            local node = state.tree:get_node()
            require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
          end,
          ["v"] = "open_vsplit",
          ["<space>"] = "none",
          ["Y"] = function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            vim.fn.setreg("+", path, "c")
          end,
        }
      },
      event_handlers = {
        {
          event = "neo_tree_buffer_enter",
          handler = function(arg)
            vim.opt_local.relativenumber = true
          end,
        },
        {
          -- Auto Close on Open File
          event = "file_opened",
          handler = function(file_path)
            require("neo-tree.command").execute({ action = "close" })
          end
        },
        {
          event = "neo_tree_popup_input_ready",
          ---@param input NuiInput
          handler = function(input)
            -- enter input popup with normal mode by default.
            vim.cmd("stopinsert")
          end,
        },
      },
    }

    vim.keymap.set("n", "<leader>n", function()
      require("neo-tree.command").execute({
        toggle = true,
        dir = vim.loop.cwd()
      })
    end, { desc = "[n]eotree (cwd)" })

    vim.keymap.set("n", "-", function()
      require("neo-tree.command").execute({
        toggle = true,
        position = "current"
      })
    end, { desc = "[-] Neotree netrw style" })

  end,
}
