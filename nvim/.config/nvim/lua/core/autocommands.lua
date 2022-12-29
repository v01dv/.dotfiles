local utils = require('utils')

utils.create_augroups({
    _general_settings = {
        -- highlight yanked text for 200ms
        --[[ {'TextYankPost', '*', 'lua require(\'vim.highlight\').on_yank({higroup = \'Search\', timeout = 200})'}, ]]
        {
            'BufWinEnter', '*',
            'setlocal formatoptions-=c formatoptions-=r formatoptions-=o '
        },
        {
            'BufRead', '*',
            'setlocal formatoptions-=c formatoptions-=r formatoptions-=o '
        },
        {
            'BufNewFile', '*',
            'setlocal formatoptions-=c formatoptions-=r formatoptions-=o '
        },
        {'BufWinEnter', '*.ex', 'set filetype=elixir'},
        {'BufWinEnter', '*.exs', 'set filetype=elixir'},
        {'BufNewFile', '*.ex', 'set filetype=elixir'},
        {'BufNewFile', '*.exs', 'set filetype=elixir'},
        {'BufWinEnter', '*.graphql', 'set filetype=graphql'}

        -- TODO
        -- When editing a file, always jump to the last known cursor position.
        -- Don't do it when the position is invalid or when inside an event handler
        -- (happens when dropping a file on gvim).
        -- Also don't do it when the mark is in the first line, that is the default
        -- position when opening a file.
        --         autocmd BufReadPost *
        --           \ if line("'\"") > 1 && line("'\"") <= line("$") |
        --           \   exe "normal! g`\"" |
        --           \ endif
        --
    },
    _number_toggle = {
        -- Relative line numbers are helpful when moving around in normal mode, but
        -- absolute line numbers are more suited for insert mode. When the buffer
        -- doesn’t have focus, it’d also be more useful to show absolute line numbers.
        -- For example, when running tests from a separate terminal split, it’d make
        -- more sense to be able to see which test is on which absolute line number.
        {'BufEnter,FocusGained,InsertLeave ', '*', 'set relativenumber'},
        {'BufLeave,FocusLost,InsertEnter', '*', 'set norelativenumber'}
    },
    _ft = {
        {'FileType', 'help', 'wincmd L'}    -- open help in vertical split
--        {'FileType', 'NvimTree', "set norelativenumber" } -- FIXME doesn't work
    },
    _markdown = {
        {'FileType', 'markdown', 'setlocal wrap'},
        {'FileType', 'markdown', 'setlocal spell'}
    },
    _autoread = {
        -- Triger `autoread` when files changes on disk
        -- https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
        -- https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
        { 'FocusGained,BufEnter,CursorHold,CursorHoldI', '*', "if mode() != 'c' | checktime | endif"},
        -- Notification after file change
        -- https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
        { 'FileChangedShellPost', '*', 'echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None'}
    },
    _TerminalBufferConfig = {
        --Configure terminal buffers
        { 'TermOpen', '*',  'setlocal nonumber norelativenumber nospell'},
        { 'TermOpen', '*',  'normal i'}
    },
    _dashboard = {
        {
            'FileType', 'dashboard',
            'setlocal nocursorline noswapfile synmaxcol& signcolumn=no norelativenumber nocursorcolumn nospell  nolist  nonumber bufhidden=wipe colorcolumn= foldcolumn=0 matchpairs= '
        },
        {
           'FileType', 'dashboard',
            'set showtabline=0 | autocmd BufLeave <buffer> set showtabline=2'
        }
    }
})

-- TODO
-- set .njk highlighting
--au BufNewFile,BufRead *.njk set ft=jinja


-- vim.cmd(
--         'command! LspCodeAction lua require("configs.global.utils").code_action()')
-- 
vim.cmd[[autocmd BufReadPost * lua goto_last_pos()]]
function goto_last_pos()
  local last_pos = vim.fn.line("'\"")
  if last_pos > 0 and last_pos <= vim.fn.line("$") then
    vim.api.nvim_win_set_cursor(0, {last_pos, 0})
  end
end



-- highlight yanked text for 200ms
vim.api.nvim_create_autocmd({"TextYankPost"}, {
  -- pattern = {"*.c", "*.h"},
  callback = function() vim.highlight.on_yank({higroup = 'Visual', timeout = 200}) end,
})

