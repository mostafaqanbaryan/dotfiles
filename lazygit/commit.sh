echo $1
if [ -n "$2" ]; then
    message="$1 [$2] $3"
else
    message="$1 $3"
fi
git commit $4 --message "$message"
