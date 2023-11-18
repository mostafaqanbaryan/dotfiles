#!/bin/bash
lock=$(find "$HOME/Pictures/wallpapers" -type f -name "*.jpg" | sort -k2M | tail -n 1)
if [ -z "$lock" ]; then
    lock="/$HOME/dotfiles/wallpaper.jpg"
fi
swaylock -e -f -F -k -l -c 000000 -s fill -i "$lock" --clock --inside-color 33333377 --indicator-radius 90 --indicator-thickness 4 --indicator $@
