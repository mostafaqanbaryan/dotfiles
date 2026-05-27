#!/bin/bash
pcal=$HOME/.local/bin/pcal
current=$($pcal -t | sed "s/\([0-9]*\)\-/<big>\1<\/big>\\\n/")
calendar=$($pcal -m)
echo "{\"text\": \""$current"\", \"class\": \"custom-shamsi\", \"tooltip\": \"$calendar\"}" | sed 's/\s*\\n\s*\\n//'
