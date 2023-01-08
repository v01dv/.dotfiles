#!/bin/sh
# Profile file. Runs on login.
# Environmental variables are set here.

# If you don't plan on reverting to bash, you can remove the link in ~/.profile
# to clean up.

# Adds `~/.local/bin` to $PATH
export PATH="$PATH:$(du "$HOME/.local/bin" | cut -f2 | paste -sd ':')"
#export PATH="$PATH:${$(find ~/.local/bin -type d -printf %p:)%%:}"

# Default programs
export EDITOR="nvim" 	# $EDITOR use nvim in terminal
export VISUAL="nvim"   	# $VISUAL use nvim in GUI mode
export TERMINAL="kitty"
export BROWSER="firefox"
export READER="zathura"
export FILE="vifm"
export CODEEDITOR="vscodium"
export COLORTERM="truecolor"
export STATUSBAR="dwmblocks"

# ~/ Clean-up:
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export IGNORE_CC_MISMATCH=1 

export HISTFILE="$XDG_DATA_HOME/history" # FIX: Do we realy need it here if we already configured it in .zshrc 

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
export LESS=-R
# export LESSHISTFILE="-"
export LESS_TERMCAP_mb="$(printf '%b' '[1;31m')"	# begin bold
export LESS_TERMCAP_md="$(printf '%b' '[1;36m')"	# begin blink
export LESS_TERMCAP_me="$(printf '%b' '[0m')"		# reset bold/blink
export LESS_TERMCAP_so="$(printf '%b' '[01;44;33m')"	# begin reverse video
export LESS_TERMCAP_se="$(printf '%b' '[0m')"		# reset reverse video
export LESS_TERMCAP_us="$(printf '%b' '[1;32m')"	# begin underline
export LESS_TERMCAP_ue="$(printf '%b' '[0m')"		# reset underline

# sudo pacman -S highlight
export LESSOPEN="| /usr/bin/highlight -O ansi %s 2>/dev/null"

# Other program settings:
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
# Note that this variable is respected by xinit, but not by startx.
export XINITRC="$XDG_CONFIG_HOME/x11/xinitrc"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

export FZF_DEFAULT_OPTS="--layout=reverse --border --height 40%"
# Frappe https://github.com/catppuccin/fzf
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS" 
--color=bg+:#414559,bg:#303446,spinner:#f2d5cf,hl:#e78284 
--color=fg:#c6d0f5,header:#e78284,info:#ca9ee6,pointer:#f2d5cf
--color=marker:#f2d5cf,fg+:#c6d0f5,prompt:#ca9ee6,hl+:#e78284"

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

export QT_QPA_PLATFORMTHEME="gtk2" # Have QT use gtk2 theme.
export MOZ_USE_XINPUT2="1" # Mozilla smooth scrolling/touchpads.
export _JAVA_AWT_WM_NONREPARENTING=1 # Fix for Java applications in dwm

# Golang
export GOPATH="$XDG_DATA_HOME/go"

export DOTFILES="$HOME/.dotfiles"
export STOW_FOLDERS="x11,shell"

# Start graphical server on tty1 if not already running.
#[ "$(tty)" = "/dev/tty1" ] && ! pidof Xorg >/dev/null 2>&1  && exec startx

# Add prime-switch here based on 
# https://github.com/Askannz/optimus-manager/issues/205#issuecomment-627364593
# https://bbs.archlinux.org/viewtopic.php?id=255752  (Post #8)
[ "$(tty)" = "/dev/tty1" ] && ! pidof -s Xorg >/dev/null 2>&1  && sudo /usr/bin/prime-switch && exec startx "$XINITRC"
