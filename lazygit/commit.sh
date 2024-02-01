echo $1
id=$(echo $2 | grep -o -e '[0-9]*')
if [ -n "$id" ]; then
    message="$1 [$id] $3"
else
    message="$1 $3"
fi
git commit $4 --message "$message"
