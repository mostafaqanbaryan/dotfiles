#!/bin/bash
pcal=$HOME/.local/bin/pcal
current=$($pcal -t)
calendar=$($pcal -m)
echo "{\"text\": \""$current"\", \"class\": \"custom-shamsi\", \"tooltip\": \"$calendar\"}" | sed 's/\s*\\n\s*\\n//'
