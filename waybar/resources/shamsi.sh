#!/bin/bash
pcal=$HOME/.config/waybar/resources/./pcal.sh
current=$($pcal -t)
calendar=$($pcal -m)
echo "{\"text\": \""$current"\", \"class\": \"custom-shamsi\", \"tooltip\": \"$calendar\"}" | sed 's/\s*\\n\s*\\n//'
