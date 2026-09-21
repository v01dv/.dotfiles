#!/bin/sh

CURRENT_USER=$(/usr/bin/whoami)

# sudo pacman -S sox to have play command
play -v 0.3  "/home/$CURRENT_USER/.local/share/sounds/battery-low.oga"

