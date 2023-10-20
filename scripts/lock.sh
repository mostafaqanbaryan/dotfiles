#!/bin/bash
lock=$(find "/$HOME/Pictures/wallpapers" -type f -name "*.jpg" | shuf -n 1)
if [ -z "$lock" ]; then
    lock="/$HOME/dotfiles/wallpaper.jpg"
fi
swaylock -e -f -F -k -l -c 000000 -s fill -i "$lock" --clock --indicator $@
