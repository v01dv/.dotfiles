return {
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-telescope/telescope-ui-select.nvim',
      'nvim-telescope/telescope-frecency.nvim',
      'nvim-telescope/telescope-live-grep-args.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        lazy = true,
      },
    },
    cmd = 'Telescope',

    config = function(_, _)
      local telescope = require 'telescope'
      local builtin = require 'telescope.builtin'
      local actions = require 'telescope.actions'
      local actions_layout = require 'telescope.actions.layout'
      local icons = require 'user.config.icons'

      ---@param command? string
      local function pick(command, opts)
        opts = opts or {}
        opts = vim.deepcopy(opts)

        -- Checks if the user did not explicitly set a CWD
        -- and ensures that root detection is enabled.
        if not opts.cwd and opts.root ~= false then
          opts.cwd = OhVim.root { buf = opts.buf }
        end

        require('telescope.builtin')[command](opts)
      end

      local opts = {
        defaults = {
          winblend = 10,
          -- The character(s) that will be shown in front of Telescope's prompt.
          prompt_prefix = ' ',
          -- prompt_prefix = icons.ui.Telescope, -- Default: '> '
          -- prompt_prefix = '  ',
          --  The character(s) that will be shown in front of the current selection.
          -- selection_caret = icons.ui.Forward .. ' ', -- Default: '> '
          selection_caret = '  ', -- \uf061
          --  Prefix in front of each result entry. Current selection not included.
          entry_prefix = '   ', --  Default: '  '
          -- set_env = { ['COLORTERM'] = 'truecolor' },
          -- file_ignore_patterns = { 'node_modules' },
          -- When I search for stuff in telescope, I want the path to be shown
          -- first, this helps in files that are very deep in the tree and I
          -- cannot see their name.
          -- Also notice the "reverse_directories" option which will show the
          -- closest dir right after the filename
          path_display = {
            filename_first = {
              reverse_directories = true,
            },
          },
          -- layout_config = {
          --   width = 0.75,
          --   preview_cutoff = 120,
          --   horizontal = {
          --     preview_width = function(_, cols, _)
          --       if cols < 120 then
          --         return math.floor(cols * 0.5)
          --       end
          --       return math.floor(cols * 0.6)
          --     end,
          --     mirror = false,
          --   },
          --   vertical = {
          --     width = 0.3,
          --     mirror = false,
          --   },
          -- },
          vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '--hidden',
            '--glob=!.git/',
          },
          mappings = {
            i = {
              ['<C-u>'] = false,
              ['<C-d>'] = false,
              ['?'] = actions_layout.toggle_preview,
              ['<C-j>'] = actions.move_selection_next,
              ['<C-k>'] = actions.move_selection_previous,
              ['<C-n>'] = actions.cycle_history_next,
              ['<C-p>'] = actions.cycle_history_prev,
              -- Details: https://github.com/josean-dev/dev-environment-files/blob/main/.config/nvim/lua/josean/plugins/telescope.lua
              -- ['<C-q>'] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
              -- ['<C-t>'] = trouble_telescope.open,
            },
            n = {
              ['<esc>'] = actions.close,
              ['q'] = actions.close,
              ['j'] = actions.move_selection_next,
              ['k'] = actions.move_selection_previous,
            },
          },
        },
        pickers = {
          live_grep = {
            --@usage don't include the filename in the search results
            only_sort_text = true,
            theme = 'dropdown',
          },

          grep_string = {
            -- only_sort_text = true,
            theme = 'dropdown',
          },

          -- find_files = {
          --   theme = 'dropdown',
          --   -- previewer = false,
          --   -- hidden = true,
          --   disable_devicons = true,
          --   find_command = { 'rg', '--files', '--hidden', '-g', '!.git' },
          --   path_display = {
          --     filename_first = {
          --       reverse_directories = true,
          --     },
          --   },
          -- },
          --
          buffers = {
            theme = 'dropdown',
            previewer = false,
            initial_mode = 'normal',
            mappings = {
              i = {
                ['<C-d>'] = actions.delete_buffer,
              },
              n = {
                ['dd'] = actions.delete_buffer,
              },
            },
          },

          diagnostics = {
            theme = 'ivy',
          },

          current_buffer_fuzzy_find = {
            theme = 'dropdown',
            winblend = 10,
            previewer = false,
          },

          spell_suggest = {
            theme = 'cursor',
          },

          git_files = {
            theme = 'dropdown',
            previewer = false,
          },
        },
        extensions = {
          fzf = {},
          live_grep_args = {
            theme = 'dropdown',
          },
          frecency = {
            previewer = false,
            -- theme = 'dropdown',
            db_version = 'v2', -- Default: "v1"
            -- matcher = 'fuzzy', -- Default: "default"`
            preceding = 'opened', -- Default: `nil`
            -- hide_current_buffer = true, -- Default: false
            -- Show the path of the active filter before file paths.
            -- So if I'm in the `dotfiles-latest` directory it will show me that
            -- before the name of the file
            show_filter_column = false, -- Default: true
            workspaces = {
              ROOT = OhVim.root(),
            },
            -- ISSUE: https://github.com/nvim-telescope/telescope-frecency.nvim/issues/289
            path_display = { 'filename_first' },
            -- path_display = {
            --   filename_first = {
            --     reverse_directories = true,
            --   },
            -- },
            default_workspace = 'CWD',
            enable_prompt_mappings = true, -- Default: false
            show_scores = true, -- Default: false
            -- disable_devicons = true,
            ignore_patterns = { '*/.git', '*/.git/*', '*/node_modules' },
          },
          ['ui-select'] = {
            require('telescope.themes').get_dropdown {},
          },
        },
      }

      telescope.setup(opts)

      -- NOTE: To get exctensions loaded and working with telescope, you need to
      -- call load_extension, somewhere after setup function
      telescope.load_extension 'fzf'
      telescope.load_extension 'live_grep_args'
      telescope.load_extension 'ui-select'
      telescope.load_extension 'frecency'
      -- FIX: Uncoment after DAP configuration
      -- telescope.load_extension "dap"

      --------------------------------------------------------------------------
      -- :h telescope.builtin.buffers
      -- sort_lastused — Sort the current and last buffer to the top and select the last used.
      -- sort_mru — Sort all buffers after the most recently used. Not just the current and last one.
      -- ignore_current_buffer — if true, don’t show the current buffer in the list.
      vim.keymap.set('n', '<leader>b', function()
        builtin.buffers { sort_mru = true, sort_lastused = true, prompt_title = 'Switch Buffer' }
      end, { desc = 'Switch buffer' })

      vim.keymap.set('n', '<leader>/', function()
        pick('live_grep', { prompt_title = 'Grep (Root Dir)' })
      end, { desc = 'Grep (Root Dir)' })

      -- vim.keymap.set('n', '<leader><space>', function()
      --   pick('find_files', { prompt_title = 'Find files (Root Dir)' })
      -- end, { desc = 'Find files (Root Dir)' })

      -- ISSUE: https://github.com/nvim-telescope/telescope-frecency.nvim/issues/316
      vim.keymap.set(
        'n',
        '<leader><space>',
        '<cmd>Telescope frecency workspace=ROOT path_display={"filename_first"} theme=dropdown prompt_title=Find\\ files\\ frecency\\ (Root\\ Dir)<cr>',
        { desc = 'Frecency (Root Dir)' }
      )

      -- vim.keymap.set('n', '<Leader>ftf', function()
      --   require('telescope').extensions.frecency.frecency {
      --     workspace = 'ROOT',
      --     theme = 'ivy',
      --     prompt_title = 'Find files frecency (Root Dir)',
      --   }
      -- end, { desc = 'Frecency (Root Dir)' })

      -- [[ Find ]]
      vim.keymap.set('n', '<leader>fb', function()
        builtin.buffers { sort_mru = true, sort_lastused = true, ignore_current_buffer = true, prompt_title = 'Buffers' }
      end, { desc = 'Buffers' })

      vim.keymap.set('n', '<leader>fc', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config', prompt_title = 'Find config files' }
      end, { desc = 'Find config files' })

      vim.keymap.set('n', '<leader>ff', function()
        pick('find_files', { prompt_title = 'Find files (Root Dir)' })
      end, { desc = 'Find files (Root Dir)' })

      vim.keymap.set('n', '<leader>fF', function()
        pick('find_files', { root = false, prompt_title = 'Find files (CWD)' })
      end, { desc = 'Find files (CWD)' })

      vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = 'Find files (git-files)' })
      --------------------------------------------------------------------------
      -- [[ Search ]]
      vim.keymap.set('n', '<leader>sb', builtin.current_buffer_fuzzy_find, { desc = 'Live fuzzy search inside current buffer' })

      -- vim.keymap.set('n', '<leader>sd', builtin.diagnostics { bufnr = 0 }, { desc = 'Telescope: search diagnostics into current buffer' })
      -- vim.keymap.set('n', '<leader>sD', builtin.diagnostics, { desc = 'Search diagnostics into current workspace' })

      vim.keymap.set('n', '<leader>sg', function()
        pick('live_grep', { root = false, prompt_title = 'Grep (Root Dir)' })
      end, { desc = 'Grep (Root Dir)' })

      vim.keymap.set('n', '<leader>sG', function()
        pick('live_grep', { root = false, prompt_title = 'Grep (CWD)' })
      end, { desc = 'Grep (CWD)' })

      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'Help pages' })
      vim.keymap.set('n', '<leader>sm', builtin.marks, { desc = 'Jump to mark' })
      vim.keymap.set('n', '<leader>sM', builtin.man_pages, { desc = 'Man pages' })
      vim.keymap.set('n', '<leader>sR', builtin.resume, { desc = 'Resume' })

      -- vim.keymap.set('n', '<leader>s', builtin.spell_suggest, { desc = 'Telescope: spelling suggestion' })

      vim.keymap.set('n', '<leader>sw', function()
        pick('grep_string', { word_match = '-w' })
      end, { desc = 'Search word under cursor (Root Dir)' })

      vim.keymap.set('n', '<leader>sW', function()
        pick('grep_string', { root = false, word_match = '-w' })
      end, { desc = 'Search word under cursor (CWD)' })

      vim.keymap.set('n', '<leader>sgi', function()
        local input_string = vim.fn.input 'Grep for > '
        if input_string == '' then
          return
        end
        pick('grep_string', { search = input_string })
      end)

      -- [Neovim: Using Telescope to find text inside specifics paths](https://miguelcrespo.co/posts/using-telescope-to-find-text-inside-paths/)
      -- ripgrep documentation with more flags and examples: https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md
      vim.keymap.set('n', '<leader>sga', function()
        require('telescope').extensions.live_grep_args.live_grep_args()
      end, { desc = 'Live Grep (Args)' })
    end,
  },
}
