#!/usr/bin/env zsh
# Based on:
#   [A Guide to the Zsh Completion with Examples](https://thevaluable.dev/zsh-completion-guide-examples/)

# +---------+
# | General |
# +---------+

# Create the parent directory if it doesn't exist
[[ -d "$XDG_CACHE_HOME"/zsh ]] || mkdir -p "$XDG_CACHE_HOME"/zsh

# export ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/zcompdump"

# Load more completions
fpath=(${ZDOTDIR}/plugins/zsh-completions/src $fpath)

# Should be called before compinit
zmodload zsh/complist

# Use hjlk in menu selection (during completion)
# Doesn't work well with interactive mode
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'l' vi-forward-char

autoload -Uz zrecompile # Load the automatic recompiler.
autoload -Uz compinit
_comp_options+=(globdots) # Complete dotfiles.

# On slow systems, checking the cached .zcompdump file to see if it must be
# regenerated adds a noticable delay to zsh startup.  This little hack restricts
# it to once a day.
#
# The globbing is a little complicated here:
#   - '#q' is an explicit glob qualifier that makes globbing work within zsh's [[ ]] construct.
#   - 'N' makes the glob pattern evaluate to nothing when it doesn't match (rather than throw a globbing error)
#   - '.' matches "regular files"
#   - 'mh+24' matches files (or directories or whatever) that are older than 24 hours.
#
# Details:
#   - Faster and enjoyable ZSH (maybe)
#      https://htr3n.github.io/2018/07/faster-zsh/
#   - https://gist.github.com/ctechols/ca1035271ad134841284
#   - How compinit works
#       https://zsh.sourceforge.io/Doc/Release/Completion-System.html
#   - For the (#q.N.....) syntax, search for "file access qualifier"
#       https://zsh.sourceforge.io/Doc/Release/Expansion.html#Filename-Generation
#   - For conditional expressions
#       http://zsh.sourceforge.net/Doc/Release/Conditional-Expressions.html

# TODO: For some reason globbind described above doesn't work for me.
# setopt LOCAL_OPTIONS EXTENDED_GLOB
# if [[ -n ${zcompdump}(#qN.mh+24) ]]; then

zcompdump="${XDG_CACHE_HOME}/zsh/zcompdump"

# -mtime +1 to catch a file more than 1 day old
if [ "$(find "${zcompdump}" -mtime +1)" ] ; then
  # The file is old and needs to be regenerated
  compinit -i -d "${zcompdump}"
  echo "Initializing completions on ${zcompdump}"
else
  compinit -C -d "${zcompdump}"
fi

# Inside parentheses is a subshell.
# These subshells let the script do parallel processing, in effect executing
# multiple subtasks simultaneously.
(
  if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
    # Compile the completion dump to increase startup speed.
    zcompile "$zcompdump"
    echo "Recompiled ${zcompdump}"
  fi
# Execute code in the background to not affect the current session
) &!

# +---------+
# | Options |
# +---------+

setopt MENU_COMPLETE  # Automatically highlight first element of completion menu
setopt AUTO_LIST      # Automatically list choices on ambiguous completion.

# +---------+
# | zstyles |
# +---------+

# Ztyle pattern
# :completion:<function>:<completer>:<command>:<argument>:<tag>

# Define completers
zstyle ':completion:*' completer _extensions _complete _approximate

# Use cache for commands using cache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"

# Allow you to select in a menu
zstyle ':completion:*' menu select

# Autocomplete options for cd instead of directory stack
zstyle ':completion:*' complete-options true

# Colors for files and directory
# zstyle ':completion:*:*:*:*:default' list-colors ${(s.:.)LS_COLORS}

# Complete with case insenstivity.
# See ZSHCOMPWID "completion matching control".
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
