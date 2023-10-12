#!/bin/sh
# 0 */6 * * * ~/.config/sway/scripts/bing_wallpaper.sh

# exit on error
set -e

# set $SWAYSOCK if it's not set (for systemd or cron)
if [ -z "$SWAYSOCK" ]; then
  export SWAYSOCK=/run/user/$(id -u)/sway-ipc.$(id -u).$(pgrep -x sway).sock
fi

tmp=/tmp/lockscreen.jpg
lockscreen=${LOCK_SCREEN_WALLPAPER_PATH:-"$HOME/wallpapers/"}
output=${WALLPAPER_OUTPUT:-"*"}
baseurl="https://www.bing.com/"
wluri=$(curl $baseurl"HPImageArchive.aspx?format=js&idx=0&n=20&mkt=en-US" -s | jq '.images[].url' --raw-output | shuf -n 1)
wget "$baseurl$wluri" -P $lockscreen
