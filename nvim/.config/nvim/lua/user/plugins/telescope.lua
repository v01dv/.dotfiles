return {
  {
    "nvim-telescope/telescope.nvim",
    branch = '0.1.x',
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true },
      "nvim-telescope/telescope-project.nvim",
      "ahmedkhalf/project.nvim",
      "nvim-telescope/telescope-live-grep-args.nvim",
    },
    cmd = "Telescope",

    config = function(_, _)

      local function find_files()
        local opts = {}
        local telescope = require "telescope.builtin"

        local ok = pcall(telescope.git_files, opts)
        if not ok then
          telescope.find_files(opts)
        end
      end

      local function find_files_from_project_git_root()
        local function is_git_repo()
          vim.fn.system("git rev-parse --is-inside-work-tree")
          return vim.v.shell_error == 0
        end
        local function get_git_root()
          local dot_git_path = vim.fn.finddir(".git", ".;")
          return vim.fn.fnamemodify(dot_git_path, ":h")
        end
        local opts = {}
        if is_git_repo() then
          opts = {
            cwd = get_git_root(),
          }
        end
        print(vim.inspect(opts))
        require("telescope.builtin").find_files({opts,  prompt_title = 'Find files on Git root' })
      end

      -- Custom live_grep function to search in git root
      local function live_grep_from_project_git_root()
        local function is_git_repo()
          vim.fn.system("git rev-parse --is-inside-work-tree")

          return vim.v.shell_error == 0
        end

        local function get_git_root()
          local dot_git_path = vim.fn.finddir(".git", ".;")
          return vim.fn.fnamemodify(dot_git_path, ":h")
        end

        local opts = {}

        if is_git_repo() then
          opts = {
            cwd = get_git_root(),
          }
        end
        require("telescope.builtin").live_grep({opts, prompt_title = 'Grep on Git root'})
      end

      local telescope = require "telescope"
      local icons = require "user.config.icons"
      local actions = require "telescope.actions"
      local actions_layout = require "telescope.actions.layout"

      local mappings = {
        i = {
          ['<C-u>'] = false,
          ['<C-d>'] = false,
          ["?"] = actions_layout.toggle_preview,
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,
        },
        n = {
          ["<esc>"] = actions.close,
          ["j"] = actions.move_selection_next,
          ["k"] = actions.move_selection_previous,
          ["q"] = actions.close,
        },
      }

      local opts = {
        defaults = {
          prompt_prefix = icons.ui.Telescope .. " ",
          selection_caret = icons.ui.Forward .. " ",
          entry_prefix = "   ",
          initial_mode = "insert",
          selection_strategy = "reset",
          color_devicons = true,
          set_env = { ["COLORTERM"] = "truecolor" },
          sorting_strategy = "ascending",
          layout_strategy = "horizontal",
          file_ignore_patterns = { "node_modules" },
          file_previewer = require("telescope.previewers").vim_buffer_cat.new,
          grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
          qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
          buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
          -- path_display = { "smart" },
          path_display = { "truncate" },
          layout_config = {
            width = 0.75,
            preview_cutoff = 120,
            horizontal = {
              preview_width = function(_, cols, _)
                if cols < 120 then
                  return math.floor(cols * 0.5)
                end
                return math.floor(cols * 0.6)
              end,
              mirror = false,
            },
            vertical = {
              width = 0.3,
              mirror = false,
            },
          },

          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
            "--glob=!.git/",
          },

          mappings = mappings,
        },
        pickers = {
          live_grep = {
            --@usage don't include the filename in the search results
            only_sort_text = true,
            theme = "dropdown",
          },

          grep_string = {
            only_sort_text = true,
            theme = "dropdown",
          },

          find_files = {
            theme = "dropdown",
            previewer = false,
            hidden = true,
            find_command = { "rg", "--files", "--hidden", "-g", "!.git" },
          },

          buffers = {
            theme = "dropdown",
            previewer = false,
            initial_mode = "normal",
            mappings = {
              i = {
                ["<C-d>"] = actions.delete_buffer,
              },
              n = {
                ["dd"] = actions.delete_buffer,
              },
            },
          },

          git_files = {
            theme = "dropdown",
            previewer = false,
          },
        },
        extensions = {
          project = {
            hidden_files = false,
            theme = "dropdown",
          },
        },
      }

      telescope.setup(opts)
      -- NOTE: To get fzf loaded and working with telescope, you need to call
      -- load_extension, somewhere after setup function
      telescope.load_extension "fzf"
      telescope.load_extension "project"
      -- FIX: Uncoment after DAP configuration
      -- telescope.load_extension "dap"
      telescope.load_extension "live_grep_args"
      telescope.load_extension("ui-select")

      -- TODO: Update description
      -- :h telescope.builtin.buffers
      -- sort_lastused — Sort the current and last buffer to the top and select the last used.
      -- sort_mru — Sort all buffers after the most recently used. Not just the current and last one.
      -- ignore_current_buffer — if true, don’t show the current buffer in the list.
      vim.keymap.set("n", "<leader>b", function() require("telescope.builtin").buffers { sort_mru=true } end, { desc = "Find open [b]uffers" })
      vim.keymap.set("n", "<leader>sf", find_files, { desc = "[s]earch [f]iles in the current directory" })
      vim.keymap.set("n", "<leader>sF", find_files_from_project_git_root, { desc = "[s]earch [F]iles on Git Root" })
      vim.keymap.set("n", "<leader>fp", function() require("telescope").extensions.project.project { display_type = "minimal" } end, { desc = "Find [p]roject" })
      vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "Live [s]earch for a strin[g] in current working directory" })
      vim.keymap.set("n", "<leader>sG", live_grep_from_project_git_root, { desc = "" })
      -- [Neovim: Using Telescope to find text inside specifics paths](https://miguelcrespo.co/posts/using-telescope-to-find-text-inside-paths/)
      -- ripgrep documentation with more flags and examples: https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md
      vim.keymap.set("n", "<leader>sga", function() require("telescope").extensions.live_grep_args.live_grep_args() end, { desc = "Live Grep (Args)" })
      vim.keymap.set("n", "<leader>sm", require("telescope.builtin").man_pages, { desc = "[s]earch [m]anpage," })
      vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[s]earch [h]elp" })

      vim.keymap.set("n", "<leader>sb", function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = "Live [s]earch fu[z]zily inside current buffer]" })

      -- vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "[s]earch [f]iles in the current directory" })
      -- vim.keymap.set("n", "<leader>sG", require("telescope.builtin").git_files, { desc = "[s]earch [G]it files" })
      vim.keymap.set("n", "<leader>sw", function() local word = vim.fn.expand "<cword>" require("telescope.builtin").grep_string { search = word } end, { desc = "[s]earch curent [w]ord under cursor" })

      vim.keymap.set("n", "<leader>sW", function()
        local word = vim.fn.expand "<cWORD>"
        require("telescope.builtin").grep_string { search = word }
      end, { desc = "[s]earch [W]ord under cursor separetd by space" })

      vim.keymap.set("n", "<leader>psW", function()
        require("telescope.builtin").grep_string { search = vim.fn.input "Grep > " }
      end, { desc = "[s]earch [w]ord under cursor" })


      -- [[ LSP ]]
      -- vim.keymap.set('n', '<leader>sD', "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", { desc = '[s]earch> [d]iagnostics into current buffer'})
      -- vim.keymap.set('n', '<leader>sd', "<cmd>Telescope diagnostics theme=get_ivy<cr>", { desc = '[s]earch [d]iagnostics into whole project'})
    end
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").setup {
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {}

          }
        }
      }
      require("telescope").load_extension("ui-select")
    end
  },
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup {
        detection_methods = { "pattern", "lsp" },
        patterns = { ".git" },
        ignore_lsp = { "null-ls" },
      }
    end,
  },
}




