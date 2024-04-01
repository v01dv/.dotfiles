#!/usr/bin/env sh
# Details:
#   - https://thevaluable.dev/fzf-shell-integration/
#   - https://github.com/Phantas0s/.dotfiles/blob/master/zsh/fzf.zsh

# CTRL-r search history of shell commands
#
# CTRL-t list files+folders in current directory and output the selection to STDOUT
#   e.g.
#     - type git add and press CTRL-t
#     - elect a few files using Tab
#     - finally Enter
#
# ALT-c is useful if you want to search for and move into a subdirectory.

source /usr/share/fzf/key-bindings.zsh

# NOTE: Do I really need this ALT-c? If I am using zoxide (zi)
# Rebind ALT-c to CTRL-e because I am using ALT-c for copying the selecting text
# to the clipboard
bindkey -rM vicmd '\ec'
bindkey -rM viins '\ec'

zle     -N              fzf-cd-widget
bindkey -M vicmd '\C-e' fzf-cd-widget
bindkey -M viins '\C-e' fzf-cd-widget

source /usr/share/fzf/completion.zsh

# fzf Scripts
# source $DOTFILES/zsh/scripts_fzf.zsh

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  # fd --hidden --follow --exclude ".git" . "$1"
  rg --files --glob "!.git" "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
   fd --type d --hidden --follow --exclude ".git" "$1"
}

