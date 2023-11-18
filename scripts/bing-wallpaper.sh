#!/bin/sh
# 0 */6 * * * sh ~/.scripts/bing-wallpaper.sh

# exit on error
set -e

# set $SWAYSOCK if it's not set (for systemd or cron)
if [ -z "$SWAYSOCK" ]; then
  export SWAYSOCK=/run/user/$(id -u)/sway-ipc.$(id -u).$(pgrep -x sway).sock
fi

oldIFS="$IFS"
IFS="
"
tmp=/tmp/lockscreen.jpg
lockscreen=${LOCK_SCREEN_WALLPAPER_PATH:-"$HOME/Pictures/wallpapers"}
output=${WALLPAPER_OUTPUT:-"*"}
baseurl="https://www.bing.com/"
result=$(curl $baseurl"HPImageArchive.aspx?format=js&idx=0&n=20&mkt=en-US" -s)
images=$(echo $result | jq '.images[]')
urls=( $(echo $images | jq -r '.url') )
dates=( $(echo $images | jq -r '.startdate') )
counter=0
for url in "${urls[@]}"; do
    filename=$lockscreen/${dates[$counter]}.jpg
    counter=$[$counter+1]
    if [ ! -e $filename ]; then
        wget "$baseurl$url" -q -O $filename
    fi
done
IFS=$oldIFS
