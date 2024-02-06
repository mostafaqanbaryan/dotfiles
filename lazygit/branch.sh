echo $1
id=$(echo $2 | grep -o -e '[0-9]*')
if [ -n "$id" ]; then
    branch="$1/T$id-$3"
else
    branch="$1/$3"
fi
git checkout -b $branch
