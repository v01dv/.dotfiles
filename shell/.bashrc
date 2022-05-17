# If not running interactively, don't do anything
[[ $- != *i* ]] && return

stty -ixon # Disable Ctrl+S and Ctrl+Q

### SHOPT
shopt -s autocd # Allows you to cd into directory merely by typing the directory name
shopt -s expand_aliases # expand aliases


# FZF Auto-completion
# ---------------
[[ $- == *i* ]] && source "/usr/share/fzf/completion.bash" 2> /dev/null

# FZF Key bindings
# ------------
source "/usr/share/fzf/key-bindings.bash"



# https://github.com/BrodieRobertson/dotfiles/blob/master/.bashrc 
#
#export PS1="\[\e[33m\][\[\e[m\]\[\e[31m\]\u\[\e[m\]@\[\e[36m\]\h\[\e[m\]:\[\e[35m\]\w\[\e[m\]\[\e[33m\]]\[\e[m\] (\$(git branch 2>/dev/null | grep '^*' | colrm 1 2)) \$ "


# Prompt customization
parse_git_branch() {
   git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
#     git branch 2>/dev/null | grep '^*' | colrm 1 2
}
PS1='\[\e[1;32m\]\u@\h: \[\e[m\]'
PS1=$PS1'\e[1;34m\]\w\[\e[m'
PS1=$PS1"\[\e[0;33m\]\$(parse_git_branch)\[\e[m\]"
PS1=$PS1'\n'
PS1=$PS1'\[\e[1;31m\]├╴🝕 \[\e[m\]'


PS2='\[\e[1;34m\]  >\[\e[m\]'



#PS1='\[\e[1;34m\]┌─[\[\e[m\]'
#PS1=$PS1'\[\e[1;32m\]\u\[\e[m\]'
#PS1=$PS1'\[\e[1;32m\]@\[\e[m\]'
#PS1=$PS1'\[\e[0;32m\]\h\[\e[m\]'
#PS1=$PS1'\[\e[1;34m\]]\[\e[m\]'
#PS1=$PS1'\[\e[1;34m\]──[\[\e[m\]'
#PS1=$PS1'\[\e[1;36m\]\w\[\e[m\]'
##PS1=$PS1'\[\e[1;34m\]]\[\e[m\]'
##PS1=$PS1'\[\e[0;37m\] - \[\e[m\]'
##PS1=$PS1'\[\e[1;34m\][\[\e[m\]'
##PS1=$PS1"\[\e[0;33m\]$(date +'%a %b %d, %I:%M')\[\e[m\]"
#PS1=$PS1"\[\e[0;33m\]\$(parse_git_branch)\[\e[m\]"
#PS1=$PS1'\[\e[1;34m\]]\[\e[m\]'
#PS1=$PS1'\n'

#PS1=$PS1'\[\e[1;34m\]└─[\[\e[m\]'
#PS1=$PS1'\[\e[1;35m\]\$\[\e[m\]'
#PS1=$PS1'\[\e[1;34m\]]>\[\e[m\]'
#PS1=$PS1'\[\e[1;34m\]⟶ ➜ \[\e[m\]'

#PS2='\[\e[1;34m\]     >\[\e[m\]'


# Add bash aliases.
[[ -f ~/.config/shell/bash_aliases ]] && . ~/.config/shell/bash_aliases


alias luamake=/home/voldv/.config/nvim/language-servers/lua-language-server/3rd/luamake/luamake
