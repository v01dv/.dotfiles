#!/usr/bin/env zsh

fpath=("${ZDOTDIR}/plugins" $fpath)

# echo -e '\033[1;37mWHITE'
# echo -e '\033[0;30mBLACK'
# echo -e '\033[0;31mRED'
# echo -e '\033[0;34mBLUE'
# echo -e '\033[0;32mGREEN'
# TODO: Rewrite this as script
# echo -e "\033[0;32m$(cat ${ZDOTDIR}/banner0.txt) \n"

# source "${HOME}/.local/bin/wellcome-banner.sh"
# wellcome-banner
fastfetch

# TODO: Do I need this?
# If not running interactively, don't do anything
# [[ $- != *i* ]] && return

# –paging=never, preventing bat from opening in a pager.
# --style=plain, isabling line numbers and headers
export LESSOPEN='| bat --style=plain --color=always --paging=never %s'

# +------------+
# | PROFILING  |
# +------------+

# Uncoment this code and appropriate code at the bottom if you want to
# profile/debug zsh startup.
# After thet run: time ZSH_DEBUGRC=1 zsh -i -c exit
#   - https://gist.github.com/elalemanyo/cb3395af64ac23df2e0c3ded8bd63b2f
#   - https://www.dotruby.com/tapas/profiling-zsh-setup-with-zprof
#   - https://stevenvanbael.com/profiling-zsh-startup
if [[ -n "$ZSH_DEBUGRC" ]]; then
  zmodload zsh/zprof
fi

# +------------+
# | NAVIGATION |
# +------------+

# Some useful options (man zshoptions)
# http://zsh.sourceforge.net/Guide/zshguide02.html
setopt AUTOCD         # Automatically cd into typed directory.
setopt interactive_comments
# setopt NO_HUP # Exit zsh, but leave running jobs open

setopt CDABLE_VARS    # Change directory to a path stored in a variable.
setopt EXTENDED_GLOB  # Use extended globbing syntax.

unsetopt PROMPT_SP 2>/dev/null

stty stop undef   # Disable ctrl-s to freeze terminal.
zle_highlight=('paste:none') # This gets rid of a paste highlight


# [ -f "${ZDOTDIR}/zsh-vim-mode" ] && source "${ZDOTDIR}/zsh-vim-mode"
[ -f "${ZDOTDIR}/zsh-functions" ] && source "${ZDOTDIR}/zsh-functions"
# [ -f "${ZDOTDIR}/zsh-prompt" ] && source "${ZDOTDIR}/zsh-prompt"
# [ -f "${ZDOTDIR}/zsh-aliases" ] && source "${ZDOTDIR}/zsh-aliases"
# [ -d "${ZDOTDIR}/aliases" ] && source "${ZDOTDIR}/aliases/tmux.zsh"
# [ -d "${ZDOTDIR}/aliases" ] && source "${ZDOTDIR}/aliases/git.zsh"
# [ -d "${ZDOTDIR}/aliases" ] && source "${ZDOTDIR}/aliases/general.zsh"

# +--------+
# | COLORS |
# +--------+

# Override colors
# eval "$(dircolors -b $ZDOTDIR/dircolors)"
[ -d "${ZDOTDIR}/lib" ] && source "${ZDOTDIR}/colors.zsh"

# +-----+
# | FZF |
# +-----+

if [ $(command -v "fzf") ]; then
  source "${ZDOTDIR}/fzf.zsh"
fi

# +---------+
# | PLUGINS |
# +---------+

# To update
zsh_add_plugin "zsh-users/zsh-autosuggestions"
# zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "zdharma-continuum/fast-syntax-highlighting"
# Suggest aliases for commands
zsh_add_plugin "MichaelAquilina/zsh-you-should-use"
# Additional completion definitions
zsh_add_plugin "zsh-users/zsh-completions"

# Just for example of fuction using
# zsh_add_completion "esc/conda-zsh-completion" false

# TODO: Configure colors and add "\n" for zsh-you-should-use plugin
# echo -e "\033[0;90m\e[3mAlias Tip: \e[4m$tip\033[0m"
# export YSU_MESSAGE_FORMAT="$(tput setaf 1)Hey! I found this %alias_type for %command: %alias$(tput sgr0)\n"

# +---------+
# | HISTORY |
# +---------+

export HISTFILE="${XDG_CACHE_HOME}/zsh/history"
HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"
HISTSIZE=10000000
SAVEHIST=10000000
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.

# +---------+
# | ALIASES |
# +---------+
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliases" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliases"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/zshnameddirrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/zshnameddirrc"

# Source configs
# for f in "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliases"/*; do
#   source "$f"
# done

# +---------+
# | SCRIPTS |
# +---------+

source "${ZDOTDIR}/scripts.zsh"

# +------------+
# | COMPLETION |
# +------------+
source "${ZDOTDIR}/completion.zsh"

# +-----------+
# | VI KEYMAP |
# +-----------+

# Activate vi mode.
bindkey -v

# Remove mode switching delay.
export KEYTIMEOUT=1

# Change cursor
source "${ZDOTDIR}/cursor.zsh"

# +---------+
# | BINDING |
# +---------+

# ^[ is ESC
# $ bindkey - Look up system current bindkey setting
# $ zle -al - list all registered zle commands
#
# The -s flag to bindkey specifies that you are binding the key to a string, not a command:
#   bindkey [ options ] -s in-string out-string ...
# E.g. bindkey -s secret 'Oh no!'
# If you type `secret' fast enough the letters are swallowed up and `Oh no!' appears instead.
# If you pause long enough anywhere in the middle, the word is inserted just as normal.
# Details:
#   - https://zsh.sourceforge.io/Guide/zshguide04.html
#   - https://zsh.sourceforge.io/Doc/Release/Zsh-Line-Editor.html

# +---------------------------------+
# | Simply mapping escape sequences |
# +---------------------------------+

# FIX: Do I need this? Should it be different for every terminal?
# 'bindkey' '-s' '^[OM'    '^M'
# 'bindkey' '-s' '^[Ok'    '+'
# 'bindkey' '-s' '^[Om'    '-'
# 'bindkey' '-s' '^[Oj'    '*'
# 'bindkey' '-s' '^[Oo'    '/'
# 'bindkey' '-s' '^[OX'    '='
# 'bindkey' '-s' '^[OA'    '^[[A'
# 'bindkey' '-s' '^[OB'    '^[[B'
# 'bindkey' '-s' '^[OD'    '^[[D'
# 'bindkey' '-s' '^[OC'    '^[[C'
# 'bindkey' '-s' '^[OH'    '^[[H'
# 'bindkey' '-s' '^[[1~'   '^[[H'
# 'bindkey' '-s' '^[[7~'   '^[[H'
# 'bindkey' '-s' '^[OF'    '^[[F'
# 'bindkey' '-s' '^[[4~'   '^[[F'
# 'bindkey' '-s' '^[[8~'   '^[[F'
# 'bindkey' '-s' '^[[3\^'  '^[[3;5~'
# 'bindkey' '-s' '^[^[[3~' '^[[3;3~'
# 'bindkey' '-s' '^[[1;9C' '^[[1;3C'
# 'bindkey' '-s' '^[^[[C'  '^[[1;3C'
# 'bindkey' '-s' '^[[1;9D' '^[[1;3D'
# 'bindkey' '-s' '^[^[[D'  '^[[1;3D'
# 'bindkey' '-s' '^[Od'    '^[[1;5D'
# 'bindkey' '-s' '^[Oc'    '^[[1;5C'


# '^[[3~' is the escape code for the delete key.
# To get this code:
#   - run cat, then press the key you wanted, and it prints out the escape code, e.g.
#     $ cat
#     ^[[3~
#   - Or just use command: showkey -a
if [[ "$TERM" == "st-256color" ]]; then
  typeset -gA keys=(
    Home                 '^[[H'
    End                  '^[[4~'
    Insert               '^[[4h'
    Delete               '^[[P'
    Backspace            '^?'
  )
else
  # For the rest og the terminal (like wezterm, kitty, alacritty etc.)
  # because they are using another escape codes for some keys.
  typeset -gA keys=(
    Home                 '^[[H'
    End                  '^[[F'
    Insert               '^[[2~'
    Delete               '^[[3~'
    Backspace            '^?'
  )
fi

# [Backspace] - delete backward
bindkey -v '^?' backward-delete-char
# bindkey -M viins '^?' backward-delete-char
# bindkey -M vicmd '^?' backward-delete-char

# [Home] - Go to beginning of line
bindkey -M viins "${keys[Home]}"       beginning-of-line
bindkey -M vicmd "${keys[Home]}"       beginning-of-line

# [End] - Go to end of line
bindkey -M viins "${keys[End]}"       end-of-line
bindkey -M vicmd "${keys[End]}"       end-of-line

# [Delete] - delete forward
bindkey -M viins "${keys[Delete]}"       delete-char
bindkey -M vicmd "${keys[Delete]}"       delete-char


# Edit the current command line in $EDITOR
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd '^v' edit-command-line
bindkey '^v' edit-command-line

bindkey -s '^a' '^ubc -lq\n'
# bindkey -s '^o' '^uzi\n'
# bindkey -s '^o' '^ucd "$(dirname "$(fzf)")"\n'

bindkey -s '^f' 'tmux-sessionizer\n'
bindkey -s '^z' 'zi\n'

bindkey '^ ' autosuggest-accept
bindkey '^n' autosuggest-accept

#--------------------------------------------------------------------------
# Miscellaneous
#--------------------------------------------------------------------------

# For completions to work, the above line must be added after compinit is called.
# You may have to rebuild your cache by running rm ~/.zcompdump*; compinit.
eval "$(zoxide init zsh)"

# +------+
# | Node |
# +------+

# Added by n-install (see http://git.io/n-install-repo).
export N_PREFIX="$HOME/.local/share/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"


# +--------+
# | PROMPT |
# +--------+

eval "$(starship init zsh)"


# +---------------------+
# | SYNTAX HIGHLIGHTING |
# +---------------------+

# export FAST_WORK_DIR="${ZDOTDIR}/plugins/fsh/"
# Theme must be located at $XDG_CONFIG_HOME/fsh
# Use fast-theme XDG:catppuccin_frappe to change the theme.
 # fast-theme ~/.config/zsh/plugins/fsh/catppuccin-frappe.ini
# export $FAST_WORK_DIR="${ZDOTDIR}/plugins/fsh"
source "${ZDOTDIR}/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
source "${ZDOTDIR}/plugins/fsh/catppuccin-frappe_theme.zsh"
source "${ZDOTDIR}/plugins/fsh/sv-orple_theme.zsh"

# Note that your must source it before loading the zsh-syntax-highlighting plugin.
# source "${ZDOTDIR}/catppuccin_frappe-zsh-syntax-highlighting.zsh"
# source "${ZDOTDIR}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"


# Based on:
#   https://github.com/preaction/dot-files/blob/master/bin/tmx
# Start TMUX session each time a terminal is open. A new session is created with a new window.
# All sessions share the same set of windows. Detaching the session will kill it.
# if [[ -x `which tmux` ]]; then
#     tmx login
# fi

if [[ -n "$ZSH_DEBUGRC" ]]; then
  zprof
fi
