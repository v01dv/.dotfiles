#--------------------------------------------------------------------------
# Configuration
#--------------------------------------------------------------------------

# some useful options (man zshoptions)
setopt autocd		# Automatically cd into typed directory.
stty stop undef		# Disable ctrl-s to freeze terminal.
setopt interactive_comments
zle_highlight=('paste:none') # This gets rid of a paste highlight  

# Load aliases and shortcuts if existent.
# [ -f "${ZDOTDIR}/zsh-vim-mode" ] && source "${ZDOTDIR}/zsh-vim-mode" 
[ -f "${ZDOTDIR}/zsh-functions" ] && source "${ZDOTDIR}/zsh-functions" 
[ -f "${ZDOTDIR}/zsh-prompt" ] && source "${ZDOTDIR}/zsh-prompt" 
[ -f "${ZDOTDIR}/zsh-aliases" ] && source "${ZDOTDIR}/zsh-aliases" 

# Note that your must source it before loading the zsh-syntax-highlighting plugin.
# source "${ZDOTDIR}/catppuccin_frappe-zsh-syntax-highlighting.zsh"

# Plugins
zsh_add_plugin "zsh-users/zsh-autosuggestions"
# zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "zdharma-continuum/fast-syntax-highlighting"

# History in cache directory:
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE="$XDG_DATA_HOME"/zsh/history
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Tab complete including hidden files.

#--------------------------------------------------------------------------
# vi mode
#--------------------------------------------------------------------------
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

#--------------------------------------------------------------------------
# Keybindings
#--------------------------------------------------------------------------

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp -uq)"
    trap 'rm -f $tmp >/dev/null 2>&1 && trap - HUP INT QUIT TERM PWR EXIT' HUP INT QUIT TERM PWR EXIT
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' '^ulfcd\n'
bindkey -s '^a' '^ubc -lq\n'
# bindkey -s '^f' '^ucd "$(dirname "$(fzf)")"\n'
bindkey '^[[P' delete-char

# Key-bindings
bindkey -s '^f' 'zi\n'
bindkey -s '^z' 'zi\n'
# bindkey "^p" up-line-or-beginning-search # Up
# bindkey "^n" down-line-or-beginning-search # Down

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
bindkey -M vicmd '^[[P' vi-delete-char
bindkey -M vicmd '^e' edit-command-line
bindkey -M visual '^[[P' vi-delete

bindkey '^ ' autosuggest-accept
bindkey '^n' autosuggest-accept

#--------------------------------------------------------------------------
# Miscellaneous
#--------------------------------------------------------------------------

# echo -e '\033[1;37mWHITE'
# echo -e '\033[0;30mBLACK'
# echo -e '\033[0;31mRED'
# echo -e '\033[0;34mBLUE'
# echo -e '\033[0;32mGREEN'
# TODO: Rewrite this as script
echo -e "\033[0;32m$(cat ${ZDOTDIR}/banner0.txt) \n"

# For completions to work, the above line must be added after compinit is called. 
# You may have to rebuild your cache by running rm ~/.zcompdump*; compinit.
eval "$(zoxide init zsh)"

export N_PREFIX="$HOME/.local/share/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

# FZF
# Ctrl+t list files+folders in current directory (e.g., type git add , press Ctrl+t, select a few files using Tab, finally Enter)
# Ctrl+r search history of shell commands
# Alt+c fuzzy change directory
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh

eval "$(starship init zsh)"
