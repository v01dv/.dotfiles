local icons = require 'user.config.icons'

return {
  -- Treesitter git support
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'git_config', 'gitcommit', 'git_rebase', 'gitignore', 'gitattributes' } },
  },
  {
    'tpope/vim-fugitive',
    event = 'VeryLazy',
    cmd = { 'Git', 'GBrowse', 'Gdiffsplit', 'Gvdiffsplit' },
    config = function()
      vim.keymap.set('n', '<leader>g', '<cmd>Git<cr>') -- Open changed file
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    event = 'LazyFile',
    cmd = 'Gitsigns',
    opts = {
      signs = {
        add = {
          -- hl = "GitSignsAdd",
          -- text = icons.ui.BoldLineMiddle,
          -- text = "▍",
          text = '▎',
          text = '┃',
          -- text = "+",
          -- numhl = "GitSignsAddNr",
          -- linehl = "GitSignsAddLn",
        },
        change = {
          -- hl = "GitSignsChange",
          -- text = icons.ui.BoldLineDashedMiddle,
          -- text = "▍",
          -- text = '▎',
          text = '┃',
          -- text = "~",
          -- numhl = "GitSignsChangeNr",
          -- linehl = "GitSignsChangeLn",
        },
        delete = {
          -- hl = "GitSignsDelete",
          -- text = icons.ui.TriangleShortArrowRight,
          -- text = '▸',
          text = '',
          -- text = "_",
          -- numhl = "GitSignsDeleteNr",
          -- linehl = "GitSignsDeleteLn",
        },
        topdelete = {
          -- hl = "GitSignsDelete",
          -- text = icons.ui.TriangleShortArrowRight,
          -- text = '▾',
          text = '',
          -- text = "‾",
          -- numhl = "GitSignsDeleteNr",
          -- linehl = "GitSignsDeleteLn",
        },
        changedelete = {
          -- hl = "GitSignsChange",
          -- text = icons.ui.BoldLineMiddle,
          -- text = '▍',
          -- text = '▎',
          text = '┃',
          -- text = "~",
          -- numhl = "GitSignsChangeNr",
          -- linehl = "GitSignsChangeLn",
        },
        untracked = {
          -- text = '▎',
          text = '┃',
        },
      },
      -- update_debounce = 100,
      current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
      preview_config = {
        border = 'rounded',
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc, silent = true })
        end

        -- stylua: ignore start
        map("n", "]h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gs.nav_hunk("next")
          end
        end, "Next Hunk")
        map("n", "[h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gs.nav_hunk("prev")
          end
        end, "Prev Hunk")
        map("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk")
        map("n", "[H", function() gs.nav_hunk("first") end, "First Hunk")
        map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
        map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>ghB", function() gs.blame() end, "Blame Buffer")
        map("n", "<leader>ghd", gs.diffthis, "Diff This")
        map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,
    },
  },
}
