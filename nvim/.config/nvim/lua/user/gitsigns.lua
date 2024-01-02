local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then
  return
end

gitsigns.setup {
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '▌', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '▌', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    -- untracked    = {hl = 'GitSignsAdd'   , text = '┆', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn' },
  },
  signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
  numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1000,
    follow_files = true,
  },
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = '<author> • <author_time:%R> • <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000,
  preview_config = {
    -- Options passed to nvim_open_win
    border = "rounded",
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },
  yadm = {
    enable = false,
  },
  trouble = false,  -- When using setqflist() or setloclist(), open Trouble instead of the quickfix/location list window. Default: true if installed.
}


-- • `%a`  abbreviated weekday name (e.g., Wed)
--           • `%A`  full weekday name (e.g., Wednesday)
--           • `%b`  abbreviated month name (e.g., Sep)
--           • `%B`  full month name (e.g., September)
--           • `%c`  date and time (e.g., 09/16/98 23:48:10)
--           • `%d`  day of the month (16) [01-31]
--           • `%H`  hour, using a 24-hour clock (23) [00-23]
--           • `%I`  hour, using a 12-hour clock (11) [01-12]
--           • `%M`  minute (48) [00-59]
--           • `%m`  month (09) [01-12]
--           • `%p`  either "am" or "pm" (pm)
--           • `%S`  second (10) [00-61]
--           • `%w`  weekday (3) [0-6 = Sunday-Saturday]
--           • `%x`  date (e.g., 09/16/98)
--           • `%X`  time (e.g., 23:48:10)
--           • `%Y`  full year (1998)
--           • `%y`  two-digit year (98) [00-99]
--           • `%%`  the character `%´
--           • `%R`  relative (e.g., 4 months ago)

-- vim.g.gitblame_date_format = '%r (%d.%m.%Y %H:%M:%S)'


-- Message template
  -- • `<abbrev_sha>`
  --         • `<orig_lnum>`
  --         • `<final_lnum>`
  --         • `<author>`
  --         • `<author_mail>`
  --         • `<author_time>` or `<author_time:FORMAT>`
  --         • `<author_tz>`
  --         • `<committer>`
  --         • `<committer_mail>`
  --         • `<committer_time>` or `<committer_time:FORMAT>`
  --         • `<committer_tz>`
  --         • `<summary>`
  --         • `<previous>`
  --         • `<filename>`


-- Available options: <author>, <committer>, <date>, <committer-date>, <summary>, <sha>
-- Default: ' <author> • <date> • <summary>'
-- vim.g.gitblame_message_template = "<summary> • <date> • <author>"
