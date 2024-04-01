#!/usr/bin/env zsh

# Use wider color range
# export TERM=xterm-256color

# Enable dircolors.
if type -p dircolors &>/dev/null; then
    #  Enable custom colors if it exists.
    [ -e "${XDG_CONFIG_HOME}/dircolors" ] && \
    eval "$(dircolors -b "${XDG_CONFIG_HOME}/dircolors")" || \
    eval "$(dircolors -b)"
fi

# d=.dircolors
# test -r $d && eval "$(dircolors $d)"

# export LS_COLORS="$(vivid -m 8-bit generate catppuccin-frappe)"

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
