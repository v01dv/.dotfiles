#!/bin/bash
# Profile file. Runs on login.
# Environmental variables are set here.

# [[ -f ~/.bashrc ]] && . ~/.config/shell/bashrc
[[ -f ~/.bashrc ]] && . ~/.bashrc

# Adds `~/.local/bin` to $PATH
export PATH="$PATH:$(du "$HOME/.local/bin" | cut -f2 | paste -sd ':')"
#export PATH="$PATH:${$(find ~/.local/bin -type d -printf %p:)%%:}"

# Default programs
export EDITOR="nvim" 	# $EDITOR use nvim in terminal
export VISUAL="nvim"   	# $VISUAL use nvim in GUI mode
export TERMINAL="st"
export BROWSER="firefox"
export READER="zathura"
export FILE="vifm"
export CODEEDITOR="vscodium"
export COLORTERM="truecolor"
export STATUSBAR="dwmblocks"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export IGNORE_CC_MISMATCH=1 
# This line will break some DMs.
# LightDM does not allow you to change this variable. 
# If you change it nonetheless, you will not be able to login. 
# Use startx instead or configure LightDM.
# Details: https://wiki.archlinux.org/index.php/XDG_Base_Directory
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority" 

# No duplicate entries
export HISTCONTROL=ignoredups:erasedups		
export HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/history"

# less/man colors
export PAGER="less"
export LESS=-R
export LESSHISTFILE="-"
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
export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"
export INPUTRC="${XDG_CONFIG_HOME:-$HOME/.config}/readline/inputrc"
# Note that this variable is respected by xinit, but not by startx.
export XINITRC="${XDG_CONFIG_HOME:-$HOME/.config}/x11/xinitrc"

export FZF_DEFAULT_OPTS="--layout=reverse --height 40%"
# https://github.com/ianchesal/nord-fzf 
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
    --color=fg:#e5e9f0,bg:#3b4252,hl:#81a1c1
    --color=fg+:#e5e9f0,bg+:#3b4252,hl+:#81a1c1
    --color=info:#eacb8a,prompt:#bf6069,pointer:#b48dac
    --color=marker:#a3be8b,spinner:#b48dac,header:#a3be8b'

export SUDO_ASKPASS="$HOME/.local/bin/dmenupass"
export PASSWORD_STORE_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/password-store"  # create password-store manually
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export GTK2_RC_FILES="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-2.0/gtkrc-2.0"
export ANSIBLE_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/ansible/ansible.cfg"

# Golang
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"

# This is the list for lf icons:
export LF_ICONS="di=📁:\
fi=📃:\
tw=🤝:\
ow=📂:\
ln=⛓:\
or=❌:\
ex=🎯:\
*.txt=✍:\
*.mom=✍:\
*.me=✍:\
*.ms=✍:\
*.png=🖼:\
*.webp=🖼:\
*.ico=🖼:\
*.jpg=📸:\
*.jpe=📸:\
*.jpeg=📸:\
*.gif=🖼:\
*.svg=🗺:\
*.tif=🖼:\
*.tiff=🖼:\
*.xcf=🖌:\
*.html=🌎:\
*.xml=📰:\
*.gpg=🔒:\
*.css=🎨:\
*.pdf=📚:\
*.djvu=📚:\
*.epub=📚:\
*.csv=📓:\
*.xlsx=📓:\
*.tex=📜:\
*.md=📘:\
*.r=📊:\
*.R=📊:\
*.rmd=📊:\
*.Rmd=📊:\
*.m=📊:\
*.mp3=🎵:\
*.opus=🎵:\
*.ogg=🎵:\
*.m4a=🎵:\
*.flac=🎼:\
*.mkv=🎥:\
*.mp4=🎥:\
*.webm=🎥:\
*.mpeg=🎥:\
*.avi=🎥:\
*.zip=📦:\
*.rar=📦:\
*.7z=📦:\
*.tar.gz=📦:\
*.z64=🎮:\
*.v64=🎮:\
*.n64=🎮:\
*.gba=🎮:\
*.nes=🎮:\
*.gdi=🎮:\
*.1=ℹ:\
*.nfo=ℹ:\
*.info=ℹ:\
*.log=📙:\
*.iso=📀:\
*.img=📀:\
*.bib=🎓:\
*.ged=👪:\
*.part=💔:\
*.torrent=🔽:\
*.jar=♨:\
*.java=♨:\
"

# Start graphical server on tty1 if not already running.
#[ "$(tty)" = "/dev/tty1" ] && ! pidof Xorg >/dev/null 2>&1  && exec startx
[ "$(tty)" = "/dev/tty1" ] && ! pidof Xorg >/dev/null 2>&1  && exec startx "$XDG_CONFIG_HOME/x11/xinitrc"
