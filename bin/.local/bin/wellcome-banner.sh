#!/bin/sh

# ¯\_(ツ)_/¯
# Based on:
#   https://gitlab.com/jschx/ufetch
#   https://github.com/linuxdabbler/debinfo/blob/master/debinfo
#   https://gitlab.com/jschx/ufetch/-/blob/main/ufetch-arch?ref_type=heads
#   https://github.com/KittyKatt/screenFetch/blob/master/screenfetch-dev

# Requires: awk
#
# Optional dependencies: curl (wheather downloading)


# Uncomment if you want to use some of these variables.
#
# user=${USER:-$(id -un)}
# host="$(read -r hostname < /etc/hostname)"
# distro=$(lsb_release -sd)
# packages="$(pacman -Q | wc -l)"
# shell="$(basename "${SHELL}")"

# Print local weather
# timeout=0.5
# weather="$(curl -s -m $timeout "https://wttr.in?format=%C+%t,+%p+%w")"

# Print last login in the format: "Last Login: Day Month Date HH:MM on tty"
# last_login="$(last | grep "^$USER " | head -1 | awk '{print ""$4" "$5" "$6" "$7" on "$2}')"

# Source: https://github.com/dylanaraps/pfetch/blob/master/pfetch#L691
#
# Store the output of 'uname' to avoid calling it multiple times
# throughout the script. 'read <<EOF' is the simplest way of reading
# a command into a list of variables.
read -r os kernel arch <<-EOF
  $(uname -srm)
EOF

# uptime="$(uptime -p | sed 's/up //')"
# uptime="$(uptime -p | sed 's/up //' | sed 's/,//g')"
# uptime="$(uptime -p | awk '{printf "%dd %dh %dm", $2, $4, $2}')"
uptime="$(uptime -p | awk '{gsub(/up /,""); {gsub(/ days?,?/,"d")}; {gsub(/ hours?,?/,"h")}; {gsub(/ minutes?,?/,"m")}; print}')"

# Users who are currently logged in
# logins=$(w -s | head -n 1 |  cut --delimiter=',' --fields=3 | sed 's/^[[:space:]]*//')
logins="$(w -s | awk -F ',' 'NR==1 {sub(/^[ ]+/,"",$3); print $3}')"

# Calculate processes
psa="$(ps -A h | wc -l)"
psu="$(ps --user $USER h | wc -l)"
verb='are'
if [ $psu -lt 2 ]; then
	if [ $psu -eq 0 ]; then
		psu='none'
	else
		verb='is'
  fi
fi

ip_address="$(ip route get 8.8.8.8 | awk -F"src " 'NR==1{split($2,a," ");print a[1]}')"
ip_interface="$(ip route get 8.8.8.8 | awk -F"dev " 'NR==1{split($2,a," ");print a[1]}')"

read -r disk_total disk_used disk_usage_in_persent <<-EOF
  $(btrfs filesystem df -g / | awk '/^Data,/ {gsub(/[^0-9.]/," "); printf "%.2f %.2f %.0f", $1, $2, $2/$1*100}')
EOF

# For details of the joutnalctl commnad see: https://wiki.archlinux.org/title/Systemd/Journal
read -r log_emergency_count log_alert_count log_critical_count log_error_count <<-EOF
  $(journalctl -b -p 3 -o cat --output-fields=PRIORITY --since now |
  awk 'BEGIN { emerg=0; alert=0; crit=0; err=0 }
      $1 == 0 {emerg++}
      $1 == 1 {alert++}
      $1 == 2 {crit++}
      $1 == 3 {err++}
    END { print emerg, alert, crit, err }')
EOF

read -r mem_total mem_used mem_usage_in_persent swap_total swap_used swap_usage_in_persent <<-EOF
  $(free -k |
    awk '/^Mem:/ { mem_total=$2/1024/1024; mem_used=$3/1024/1024 } /^Swap:/ { swap_total=$2/1024/1024; swap_used=$3/1024/1024 }
    END { printf "%.2f %.2f %.0f%% %.2f %.2f %.0f%%", mem_total, mem_used, (mem_used / mem_total * 100), swap_total, swap_used, (swap_used / swap_total * 100)}')
EOF

## DEFINE COLORS

#########################
  # local RCol='\[\e[0m\]'  # Text Reset

  # # Regular                    Bold                          Underline
  # local Bla='\[\e[0;30m\]';    local BBla='\[\e[1;30m\]';    local UBla='\[\e[4;30m\]';
  # local Red='\[\e[0;31m\]';    local BRed='\[\e[1;31m\]';    local URed='\[\e[4;31m\]';
  # local Gre='\[\e[0;32m\]';    local BGre='\[\e[1;32m\]';    local UGre='\[\e[4;32m\]';
  # local Yel='\[\e[0;33m\]';    local BYel='\[\e[1;33m\]';    local UYel='\[\e[4;33m\]';
  # local Blu='\[\e[0;34m\]';    local BBlu='\[\e[1;34m\]';    local UBlu='\[\e[4;34m\]';
  # local Pur='\[\e[0;35m\]';    local BPur='\[\e[1;35m\]';    local UPur='\[\e[4;35m\]';
  # local Cya='\[\e[0;36m\]';    local BCya='\[\e[1;36m\]';    local UCya='\[\e[4;36m\]';
  # local Whi='\[\e[0;37m\]';    local BWhi='\[\e[1;37m\]';    local UWhi='\[\e[4;37m\]';

  # # High Intensity                BoldHigh Intensity             Background                High Intensity Backgrounds
  # local IBla='\[\e[0;90m\]';    local BIBla='\[\e[1;90m\]';    local On_Bla='\e[40m';    local On_IBla='\[\e[0;100m\]';
  # local IRed='\[\e[0;91m\]';    local BIRed='\[\e[1;91m\]';    local On_Red='\e[41m';    local On_IRed='\[\e[0;101m\]';
  # local IGre='\[\e[0;92m\]';    local BIGre='\[\e[1;92m\]';    local On_Gre='\e[42m';    local On_IGre='\[\e[0;102m\]';
  # local IYel='\[\e[0;93m\]';    local BIYel='\[\e[1;93m\]';    local On_Yel='\e[43m';    local On_IYel='\[\e[0;103m\]';
  # local IBlu='\[\e[0;94m\]';    local BIBlu='\[\e[1;94m\]';    local On_Blu='\e[44m';    local On_IBlu='\[\e[0;104m\]';
  # local IPur='\[\e[0;95m\]';    local BIPur='\[\e[1;95m\]';    local On_Pur='\e[45m';    local On_IPur='\[\e[0;105m\]';
  # local ICya='\[\e[0;96m\]';    local BICya='\[\e[1;96m\]';    local On_Cya='\e[46m';    local On_ICya='\[\e[0;106m\]';
  # local IWhi='\[\e[0;97m\]';    local BIWhi='\[\e[1;97m\]';    local On_Whi='\e[47m';    local On_IWhi='\[\e[0;107m\]';

#########################
# export PS1="\[$(tput bold)$(tput setb 4)$(tput setaf 7)\]\u@\h:\w $ \[$(tput sgr0)\]"
#
# tput Color Capabilities:

# tput setab [1-7] – Set a background color using ANSI escape
# tput setb [1-7] – Set a background color
# tput setaf [1-7] – Set a foreground color using ANSI escape
# tput setf [1-7] – Set a foreground color
#
# tput Text Mode Capabilities:

# tput bold – Set bold mode
# tput dim – turn on half-bright mode
# tput smul – begin underline mode
# tput rmul – exit underline mode
# tput rev – Turn on reverse mode
# tput smso – Enter standout mode (bold on rxvt)
# tput rmso – Exit standout mode
# tput sgr0 – Turn off all attributes
#
# Color Code for tput:

# 0 – Black
# 1 – Red
# 2 – Green
# 3 – Yellow
# 4 – Blue
# 5 – Magenta
# 6 – Cyan
# 7 – White

################
# PS1='\[\033[1;32m\]\u@\h\[\033[1;34m\] \w >\[\033[0m\] '

# similarly in zsh:

# PS1=$'%{\e[1;32m%}%n@%m%{\e[1;34m%} %3~> %{\e[0m%}'
#####################
# From https://github.com/KittyKatt/screenFetch/blob/master/screenfetch-dev

# errorOut () {
# 	printf '\033[1;37m[[ \033[1;31m! \033[1;37m]] \033[0m%s\n' "$1"
# }

# colorize () {
# 	printf $'\033[0m\033[38;5;%sm' "$1"
# }
# # Some 256 colors
# dark_orange="$(colorize '202')"
#########################

# probably don't change these
if [ -x "$(command -v tput)" ]; then
	bold="$(tput bold 2> /dev/null)"
	black="$(tput setaf 0 2> /dev/null)"
	red="$(tput setaf 1 2> /dev/null)"
	green="$(tput setaf 2 2> /dev/null)"
	yellow="$(tput setaf 3 2> /dev/null)"
	blue="$(tput setaf 4 2> /dev/null)"
	magenta="$(tput setaf 5 2> /dev/null)"
	cyan="$(tput setaf 6 2> /dev/null)"
	white="$(tput setaf 7 2> /dev/null)"
	reset="$(tput sgr0 2> /dev/null)"
fi

# you can change these
lc="${reset}${blue}"          # labels
nc="${reset}${bold}${magenta}"  # user and hostname
ic="${reset}${white}"         # info
c0="${reset}${blue}"          # first color
c1="${reset}${red}"           # second color

## OUTPUT

# ${c0}                                    ${nc}${USER}${ic}@${nc}${host}${reset}

cat <<EOF
${c0} ╭───────────────╮  ${lc}kernel.........: ${ic}${kernel}${reset}
${c0} │ wellcome back │  ${lc}uptime.........: ${ic}${uptime}${reset}
${c0} │ commander_    │  ${lc}processes......: ${ic}${psa} total and ${psu} ${verb} yours${reset}
${c0} ╰───────────────╯  ${lc}memory.........: ${ic}${mem_usage_in_persent:-?} (${mem_used:-?} / ${mem_total:-?})${reset}
${c0}             /      ${lc}disk...........: ${ic}${disk_usage_in_persent:-?}% (${disk_used:-?} / ${disk_total:-?})${reset}
${c0}     /\_/\  /       ${lc}swap...........: ${ic}${swap_usage_in_persent:-?} (${swap_used:-?} / ${swap_total:-?})${reset}
${c0} \  (=${c1}^${reset}･${c1}^${c0}=)         ${lc}local ip.......: ${ic}${ip_address:-?} (${ip_interface:-?})${reset}
${c0}  |  >   <          ${lc}logins.........: ${ic}currently ${logins:-?} logged in${reset}
${c0}  \_(_(m)(m)        ${lc}system logs....: ${ic}emerg ${log_emergency_count:-?} alert ${log_alert_count:-?} crit ${log_critical_count:-?} err ${log_error_count:-?} ${reset}

EOF
