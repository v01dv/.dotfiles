# Based on https://github.com/demure/dotfiles/blob/master/subbash/prompt
#
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

stty -ixon # Disable Ctrl+S and Ctrl+Q

### SHOPT
shopt -s autocd # Allows you to cd into directory merely by typing the directory name
shopt -s expand_aliases # expand aliases

shopt -s cdspell # autocorrects typos (eg: cd /ect becomes cd /etc)
shopt -s cmdhist # save multi-line commands in history as single line

# Sometimes you have multiple terminal windows open at the same time. By default,
# the window that closes last, will overwrite the bash history file, loosing the
# history of all the other terminal windows and ssh sessions in the process.
# This can be avoided by this little setting:
shopt -s histappend # merge session histories

# FZF Auto-completion
# ---------------
[[ $- == *i* ]] && source "/usr/share/fzf/completion.bash" 2> /dev/null

# paru autojump
[[ -s /etc/profile.d/autojump.sh ]] && source /etc/profile.d/autojump.sh

# FZF Key bindings
# ------------
source "/usr/share/fzf/key-bindings.bash"


# https://github.com/BrodieRobertson/dotfiles/blob/master/.bashrc
#
#export PS1="\[\e[33m\][\[\e[m\]\[\e[31m\]\u\[\e[m\]@\[\e[36m\]\h\[\e[m\]:\[\e[35m\]\w\[\e[m\]\[\e[33m\]]\[\e[m\] (\$(git branch 2>/dev/null | grep '^*' | colrm 1 2)) \$ "

# Prompt customization
parse_git_branch() {
   git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ ( \1)/'
#     git branch 2>/dev/null | grep '^*' | colrm 1 2
}

# Function to generate PS1 after CMDs
function __prompt_command()
{
  # Save the exit status of last command. This
  # needs to be done first otherwise exit status of
  # other commands will be stored in this variable.
  EXIT="$?"

  HIST='$((\! -1))'

  # PS1 needs to be reset or else it will
  # be appended every time to previous one.
  PS1=""

  local RCol='\[\e[0m\]'  # Text Reset

  # Regular                    Bold                          Underline
  local Bla='\[\e[0;30m\]';    local BBla='\[\e[1;30m\]';    local UBla='\[\e[4;30m\]';
  local Red='\[\e[0;31m\]';    local BRed='\[\e[1;31m\]';    local URed='\[\e[4;31m\]';
  local Gre='\[\e[0;32m\]';    local BGre='\[\e[1;32m\]';    local UGre='\[\e[4;32m\]';
  local Yel='\[\e[0;33m\]';    local BYel='\[\e[1;33m\]';    local UYel='\[\e[4;33m\]';
  local Blu='\[\e[0;34m\]';    local BBlu='\[\e[1;34m\]';    local UBlu='\[\e[4;34m\]';
  local Pur='\[\e[0;35m\]';    local BPur='\[\e[1;35m\]';    local UPur='\[\e[4;35m\]';
  local Cya='\[\e[0;36m\]';    local BCya='\[\e[1;36m\]';    local UCya='\[\e[4;36m\]';
  local Whi='\[\e[0;37m\]';    local BWhi='\[\e[1;37m\]';    local UWhi='\[\e[4;37m\]';

  # High Intensity                BoldHigh Intensity             Background                High Intensity Backgrounds
  local IBla='\[\e[0;90m\]';    local BIBla='\[\e[1;90m\]';    local On_Bla='\e[40m';    local On_IBla='\[\e[0;100m\]';
  local IRed='\[\e[0;91m\]';    local BIRed='\[\e[1;91m\]';    local On_Red='\e[41m';    local On_IRed='\[\e[0;101m\]';
  local IGre='\[\e[0;92m\]';    local BIGre='\[\e[1;92m\]';    local On_Gre='\e[42m';    local On_IGre='\[\e[0;102m\]';
  local IYel='\[\e[0;93m\]';    local BIYel='\[\e[1;93m\]';    local On_Yel='\e[43m';    local On_IYel='\[\e[0;103m\]';
  local IBlu='\[\e[0;94m\]';    local BIBlu='\[\e[1;94m\]';    local On_Blu='\e[44m';    local On_IBlu='\[\e[0;104m\]';
  local IPur='\[\e[0;95m\]';    local BIPur='\[\e[1;95m\]';    local On_Pur='\e[45m';    local On_IPur='\[\e[0;105m\]';
  local ICya='\[\e[0;96m\]';    local BICya='\[\e[1;96m\]';    local On_Cya='\e[46m';    local On_ICya='\[\e[0;106m\]';
  local IWhi='\[\e[0;97m\]';    local BIWhi='\[\e[1;97m\]';    local On_Whi='\e[47m';    local On_IWhi='\[\e[0;107m\]';

  # if [ $EXIT -eq 0 ]; then
  #     PS1+="${BIGre}${EXIT} ${RCol}"
  #   else
  #     PS1+="${Red}[${HIST}] ${RCol}"
  # fi

  # if logged in via ssh shows the ip of the client
  # if [ -n "$SSH_CLIENT" ]; then PS1+="${Cya}("${$SSH_CLIENT%% *}")${RCol}"; fi

  # basic information (user@host:path)
  # If root, just print the host in red. Otherwise, print the current user
  # and host in green.
  if [[ $EUID == 0 ]]; then
    PS1+="${Red}\h \W ->${RCol} "       ## Set prompt for root
  else
    # PS1+="${Cya}\u${RCol}${BPur}@\h${RCol}: ${BBlu}\w${RCol}"
    # PS1+="${BGre}\u${RCol}${BGre}@\h${RCol}: ${BBlu}\w${RCol}"  → ➜ ⟶
    # PS1+="${Pur}[${RCol}${Pur}\u${RCol}${Pur}@${RCol}${Pur}\h${RCol}${Pur}]${RCol}${Whi} → ${RCol}${BIBlu}\W${RCol}"
    # PS1+="${Whi}[${RCol}${Whi}\u${RCol}${Whi}@${RCol}${Whi}\h${RCol}${Whi}]${RCol}${Whi} → ${RCol}${BIBlu}\W${RCol}"
    PS1+="${Gre}[${RCol}${Gre}\u${RCol}${Gre}@${RCol}${Gre}\h${RCol}${Gre}]${RCol}${Whi}  ${RCol}${BIBlu}\W${RCol}"
  fi
  # PS1=$PS1"${Pur}$(parse_git_branch)${RCol}"

  ### Add Git Status ### {{{
  ## Inspired by http://www.terminally-incoherent.com/blog/2013/01/14/whats-in-your-bash-prompt/
  if [[ $(command -v git) ]]; then
      ## $GSP: git status porcelain
      local GSP="$(git status --porcelain=2 --branch 2>/dev/null)"

      if [ -n "${GSP}" ]; then
          ### Fetch Time Check ### {{{
          local LAST=$(stat -c %Y $(git rev-parse --git-dir 2>/dev/null)/FETCH_HEAD 2>/dev/null)
          if [ -n "${LAST}" ]; then
              local TIME=$(echo $(($(date +"%s") - ${LAST})))
              ## Check if more than 60 minutes since last
              if [ "${TIME}" -gt "3600" ]; then
                  local GF=1      ## Git Fetch True
              fi
            else
              local GF=1          ## Git Fetch True
          fi
          if [ -n "${GF}" ] && [ "${GF}" == "1" ]; then
              git fetch 2>/dev/null
              PS1+=' +'
              ## Refresh var
              local GSP="$(git status --porcelain=2 --branch 2>/dev/null)"
          fi
          ### End Fetch Check ### }}}

          ### Branch Indicator Color ### {{{
          ## GSP Change Color; Reuses GSP Modified code
          local GSPcc="$(grep -c "^[12] .M" <<< "${GSP}")"
          if [ "${GSPcc}" == "0" ]; then
              local GBC=$Gre                  ## Branch Color
            else
              local GBC=$Red                  ## Branch Color
          fi
          GBC=$Pur
          ### End Branch Indicator Color ### }}}

          ### Find Branch ### {{{
          ## GSP Current Branch; branch name in 3rd spot
          local GSPcb="$(awk '/branch.head/ {print $3}' <<< "${GSP}")"
          if [ -n "${GSPcb}" ]; then
              # GSPcb="${GSPcb}"              ## Add brackets for final output. Will now test against brackets as well.
              # if [ "${GSPcb}" == "master" ]; then
              #     local GSPcb="[M]"           ## Because why waste space
              # fi

              ## Test if in detached head state, and set output to first 8char of hash
              if [ "${GSPcb}" == "(detached)" ]; then
                  local GSPcb="$(awk '/branch.oid/ {print substr($3,0,8)}' <<< "${GSP}")"
              fi
            else
              ## Note: No braces applied to emphasis that there is an issue, and that you aren't in a branch named "ERROR".
              local GSPcb="ERROR"             ## It could happen?
          fi
          ### End Branch ### }}}

          PS1+="${GBC} (${RCol}"
          PS1+="${GBC} ${GSPcb} ${RCol}"       ## Add result to prompt

          ### Find Commit Status ### {{{
          ## GSP Commit Ahead; 3rd spot; Knock off leading symbol; Check exist and gt 0
          local GSPca="$(awk '/branch.ab/ {print substr($3,2)}' <<< "${GSP}")"
          if [ -n "${GSPca}" ] && [ "${GSPca}" -gt 0 ]; then
              PS1+="${Gre}⇡${RCol}${GSPca}"   ## Ahead ↑
          fi

          ## Needs a `git fetch` to be accurate
          ## GSP Commit Behind; 4rd spot; Knock off leading symbol; Check exist and gt 0
          local GSPcb="$(awk '/branch.ab/ {print substr($4,2)}' <<< "${GSP}")"
          if [ -n "${GSPcb}" ] && [ "${GSPcb}" -gt 0 ]; then
              PS1+="[${Red}⇣${RCol}${GSPcb}"   ## Behind ↓
          fi

          ## Read about "[ MARC]" from https://git-scm.com/docs/git-status
          ## GSP Modified
          local GSPm="$(grep -c "^[12] .M" <<< "${GSP}")"
          if [ "${GSPm}" -gt "0" ]; then
              # PS1+="${Pur}!${RCol}${GSPm}"    ## Modified
              PS1+="${Red}!${RCol}"    ## Modified
          fi

          ## GSP Untracked
          local GSPu="$(grep -c "^?" <<< "${GSP}")"
          if [ "${GSPu}" -gt "0" ]; then
              # PS1+="${Yel}?${RCol}${GSPu}"    ## Untracked
              PS1+="${Red}?${RCol}"    ## Untracked
          fi

          ## GSP Deleted
          local GSPd="$(grep -c "^[12] .D" <<< "${GSP}")"
          if [ "${GSPd}" -gt "0" ]; then
              # PS1+="${Red}x${RCol}${GSPd}"    ## Deleted
              PS1+="${Red}x${RCol}"    ## Deleted
          fi

          ## GSP Added
          local GSPa="$(grep -c "^[12] A" <<< "${GSP}")"
          if [ "${GSPa}" -gt "0" ]; then
              # PS1+="${Gre}+${RCol}${GSPa}"    ## Added``
              PS1+="${Red}+${RCol}"    ## Added``
          fi

          ## GSP Renamed
          local GSPr="$(grep -c "^[12] R" <<< "${GSP}")"
          if [ "${GSPr}" -gt "0" ]; then
              # PS1+="${Blu}»${RCol}${GSPr}"    ## Renamed >
              PS1+="${Red}»${RCol}"    ## Renamed >
          fi

          PS1+="${GBC})${RCol}"
          ### End Commit Status ### }}}
      fi
    else
      MISSING_ITEMS+="git-prompt, "
  fi
  ### End Git Status ### }}}


  # https://unicode-table.com/en/1F794/
  # U+1F794 = 🞔  (Name: White Square Containing Black Very Small Square; Block: Geometric Shapes Extended)
  # PS1+="${Whi}\n├╴🞔 ${RCol}"
  PS1+="${Whi} 🞔  ${RCol}"  ## End of PS1

  PS2+="${Blu}  >${RCol}"

}


# exit_code Should be first command in `PROMPT_COMMAND' to be executed or # else return status will always be 0/true as it will hold return status of
# previous command.

# First we check if prompt command is empty or not.
# If empty, just add `__prompt_command' to it. If non empty,
# make it `__prompt_command:$PROMPT_COMMAND'
[ -n "$PROMPT_COMMAND" ] && PROMPT_COMMAND="__prompt_command;$PROMPT_COMMAND" ||
    PROMPT_COMMAND="__prompt_command"

# PROMPT_COMMAND=__prompt_command

# Add aliases.
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliases" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliases"

eval "$(starship init bash)"

export N_PREFIX="$HOME/.local/share/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).
