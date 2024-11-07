#!/bin/sh
# Profile file. Runs on login.
# Environmental variables are set here.

# If you don't plan on reverting to bash, you can remove the link in ~/.profile
# to clean up.

# Adds `~/.local/bin` to $PATH
export PATH="$PATH:$(du "$HOME/.local/bin" | cut -f2 | paste -sd ':')"
# export PATH="$PATH:/opt/cuda/bin"
# export LD_LIBRARY_PATH=/opt/cuda/lib64\
#                         ${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
#export PATH="$PATH:${$(find ~/.local/bin -type d -printf %p:)%%:}"
# export CUDA_HOME="/opt/cuda"

# Default programs
export EDITOR="nvim" 	# $EDITOR use nvim in terminal
export VISUAL="nvim"   	# $VISUAL use nvim in GUI mode
export TERMINAL="st"
export BROWSER="librewolf"

# TODO: Remove aftre some period of time
# export READER="zathura"
# export FILE="vifm"
# export CODEEDITOR="nvim"
# export COLORTERM="truecolor"
# export STATUSBAR="dwmblocks"

# XDG
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export IGNORE_CC_MISMATCH=1

# This line will break some DMs.
# LightDM does not allow you to change this variable.
# If you change it nonetheless, you will not be able to login.
# Use startx instead or configure LightDM.
# Details: https://wiki.archlinux.org/index.php/XDG_Base_Directory
# export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"

# Use nvim as manpager `:h Man`
export MANPAGER='nvim +Man!'
export MANWIDTH=999

# less/man colors
export PAGER="less"
# Alternative pagers:
#   - https://github.com/walles/moar
#     export PAGER="moar"
#   - https://github.com/lucc/nvimpager
#     export PAGER="nvimpager"
#   - https://github.com/I60R/page
#     export PAGER="page -q 90000 -z 90000"

# export LESSHISTFILE="-" # Disable less history.
export LESS=-R
# Man page bold
export LESS_TERMCAP_mb="$(printf '%b' '[1;31m')"	# begin bold
export LESS_TERMCAP_md="$(printf '%b' '[1;36m')"	# begin blink
export LESS_TERMCAP_me="$(printf '%b' '[0m')"		# reset bold/blink
# Status bar and search hits
export LESS_TERMCAP_so="$(printf '%b' '[01;44;33m')"	# begin reverse video
export LESS_TERMCAP_se="$(printf '%b' '[0m')"		# reset reverse video
# Man page underline
export LESS_TERMCAP_us="$(printf '%b' '[1;32m')"	# begin underline
export LESS_TERMCAP_ue="$(printf '%b' '[0m')"		# reset underline

# sudo pacman -S highlight
# TODO: Moved to bat, so maybe just delete this ?
# export LESSOPEN="| /usr/bin/highlight -O ansi %s 2>/dev/null"

# Configure less to use bat.
# –-paging=never, preventing bat from opening in a pager.
# --style=plain, isabling line numbers and headers
export LESSOPEN="| bat --style=plain --paging=never --color=always %s"

# Other program settings:
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
# Note that this variable is respected by xinit, but not by startx.
export XINITRC="$XDG_CONFIG_HOME/x11/xinitrc"
export CURL_HOME="${XDG_CONFIG_HOME}/curlrc"
export DOCKER_CONFIG="${XDG_CONFIG_HOME}/docker"
# export GIT_CONFIG="${XDG_CONFIG_HOME}/git/.gitconfig"

# zsh
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
# export ZSH_COMPDUMP="${XDG_CACHE_HOME}/zsh/zcompdump"

# fzf
# Details:
#   - https://thevaluable.dev/fzf-shell-integration/
#   - https://thevaluable.dev/practical-guide-fzf-example/

# NOTE: fzf will use this default command if and only if you don’t give any input.

# Use the CLI find (default) to get all files, excluding any filepath
# containing the string "git".
# export FZF_DEFAULT_COMMAND='find . -type f ! -path "*git*"'

# Use the CLI fd to respect ignore files (like '.gitignore'),
# display hidden files, and exclude the '.git' directory.
# export FZF_DEFAULT_COMMAND='fd . --hidden --exclude ".git"'

# Use the CLI ripgrep to respect ignore files (like '.gitignore'),
# display hidden files, and exclude the '.git' directory.
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -n 10'"

# export FZF_DEFAULT_OPTS="--layout=reverse --border --height 40%"

# FZF_COLORS="bg+:-1,\
# fg:gray,\
# fg+:white,\
# border:black,\
# spinner:0,\
# hl:yellow,\
# header:blue,\
# info:green,\
# pointer:red,\
# marker:blue,\
# prompt:gray,\
# hl+:red"


# Frappe https://github.com/catppuccin/fzf
FZF_COLORS="bg+:#414559,\
bg:#303446,\
spinner:#f2d5cf,\
hl:#e78284,\
fg:#c6d0f5,\
header:#e78284,\
info:#ca9ee6,\
pointer:#f2d5cf,\
marker:#f2d5cf,\
fg+:#c6d0f5,\
prompt:#ca9ee6,\
hl+:#e78284"

export FZF_DEFAULT_OPTS="--height 60% \
--border rounded \
--layout reverse \
--color '$FZF_COLORS' \
--prompt='>' \
--pointer ▶ \
--marker ⇒"

# --prompt '∷ ' \
# --pointer='→' \
# --marker='♡' \

# Old config
# export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS"
# --color=bg+:#414559,bg:#303446,spinner:#f2d5cf,hl:#e78284
# --color=fg:#c6d0f5,header:#e78284,info:#ca9ee6,pointer:#f2d5cf
# --color=marker:#f2d5cf,fg+:#c6d0f5,prompt:#ca9ee6,hl+:#e78284"

export DICS="/usr/share/stardict/dic/"
export SUDO_ASKPASS="$HOME/.local/bin/dmenupass"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"  # create password-store manually
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
export CARGO_HOME="$XDG_DATA_HOME/cargo"

export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export N_PREFIX="$XDG_DATA_HOME/n"

export NOTMUCH_CONFIG="$XDG_CONFIG_HOME/notmuch-config"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc-2.0"
export ANSIBLE_CONFIG="$XDG_CONFIG_HOME/ansible/ansible.cfg"
export ELECTRUMDIR="$XDG_DATA_HOME/electrum"

# QT5 Fix
# TODO: Add proper coniguration for QT5
export QT_QPA_PLATFORMTHEME="qt5ct"

export QT_QPA_PLATFORMTHEME="gtk2" # Have QT use gtk2 theme.
export MOZ_USE_XINPUT2="1" # Mozilla smooth scrolling/touchpads.
export _JAVA_AWT_WM_NONREPARENTING=1 # Fix for Java applications in dwm

# Golang
export GOPATH="$XDG_DATA_HOME/go"

export DOTFILES="$HOME/.dotfiles"
export STOW_FOLDERS="x11,shell"

[ ! -f "$XDG_CONFIG_HOME/shell/shortcutrc" ] && setsid -f shortcuts >/dev/null 2>&1

# Cloud
# source $CLOUD/dotfiles/common/env


# Start graphical server on tty1 if not already running.
#[ "$(tty)" = "/dev/tty1" ] && ! pidof Xorg >/dev/null 2>&1  && exec startx

# Add prime-switch here based on
# https://github.com/Askannz/optimus-manager/issues/205#issuecomment-627364593
# https://bbs.archlinux.org/viewtopic.php?id=255752  (Post #8)
[ "$(tty)" = "/dev/tty1" ] && ! pidof -s Xorg >/dev/null 2>&1  && sudo /usr/bin/prime-switch && exec startx "$XINITRC"
