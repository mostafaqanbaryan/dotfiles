#!/bin/bash
lock=$(find "/$HOME/wallpapers" -type f -name "*.jpg" | shuf -n 1)
swaylock -e -f -F -k -l -c 000000 -s fill -i "$lock" --clock --indicator $@
