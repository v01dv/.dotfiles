cursor() {
    # See https://ttssh2.osdn.jp/manual/4/en/usage/tips/vim.html for cursors
    cursor_block='\e[2 q'
    cursor_beam='\e[6 q'

    function zle-keymap-select {
        if [[ ${KEYMAP} == vicmd ]] ||
            [[ $1 = 'block' ]]; then
            echo -ne $cursor_block
        elif [[ ${KEYMAP} == main ]] ||
            [[ ${KEYMAP} == viins ]] ||
            [[ ${KEYMAP} = '' ]] ||
            [[ $1 = 'beam' ]]; then
            echo -ne $cursor_beam
        fi
    }

    zle-line-init() {
        echo -ne $cursor_beam
    }

# If you have a problem with End and Home key
#    zle-line-init () {
#       # Default zle-line-init
#       if (( $+terminfo[smkx] ))
#       then
#               echoti smkx
#       fi
#       zle editor-info
#
#       # Modify cursor!
#       zle -K viins
#   }

    zle -N zle-keymap-select
    zle -N zle-line-init


# Change cursor shape for different vi modes.
#
# For cursors details:
#   https://ttssh2.osdn.jp/manual/4/en/usage/tips/vim.html for cursors
#   https://invisible-island.net/xterm/ctlseqs/ctlseqs.html#h4-Functions-using-CSI-_-ordered-by-the-final-character-lparen-s-rparen:CSI-Ps-SP-q.1D81
# Set cursor style (DECSCUSR), VT520.
#   0 - blinking block.
#   1 - blinking block (default).
#   2 - steady block.
#   3 - blinking underline.
#   4 - steady underline.
#   5 - blinking bar, xterm.
#   6 - steady bar, xterm.
# function zle-keymap-select () {
#     case $KEYMAP in
#         vicmd) echo -ne '\e[1 q';;      # block
#         viins|main) echo -ne '\e[5 q';; # beam
#     esac
# }
# zle -N zle-keymap-select

# zle-line-init() {
#     zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
#     echo -ne "\e[5 q"
# }
# zle -N zle-line-init

# # Use beam shape cursor on startup.
# echo -ne '\e[5 q'

# # Use beam shape cursor for each new prompt.
# preexec() { echo -ne '\e[5 q' ;}















}

cursor
