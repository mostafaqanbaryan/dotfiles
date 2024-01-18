#!/bin/bash
lock=$(find "$HOME/Pictures/wallpapers" -type f -name "*.jpg"  -printf "\n%AD %AT %p" -type f -name "*.jpg" | sort -k1.8n -k1.1nr -k1 | tail -n 1 | awk '{ print $3 }')
if [ -z "$lock" ]; then
    lock="/$HOME/dotfiles/wallpaper.jpg"
fi
swaylock -e -f -F -k -l -c 000000 -s fill -i "$lock" --clock --inside-color 33333377 --indicator-radius 90 --indicator-thickness 4 --indicator $@
