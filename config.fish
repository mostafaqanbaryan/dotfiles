function fish_greeting
    please
    starship init fish | source
end

source ~/env.fish

alias PHPERROR 'sudo tail -f /var/log/php-fpm/www-error.log'
alias nethogs 'sudo nethogs'

# Editor
alias vim "nvim"
set -x EDITOR "nvim"
abbr v "nvim"

# Dockers
abbr dcu "docker-compose -f docker-compose.yml up -d"
abbr dcd "docker-compose -f docker-compose.yml down"

# Git
abbr gu "git pull"
abbr gp "git push -u origin HEAD"
abbr gl "git log"
abbr gs "git status"
abbr gco "git checkout"
abbr gd "git diff"
abbr gr "git rebase"
abbr gc 'git commit -m "'
abbr ga "git commit --amend"
abbr parent "git log --first-parent"

# Ctrl+Backspace
bind \b backward-kill-word

# Ctrl+Delete
bind \e\[3\;5~ kill-word

# Fun
alias coffee 'termdown "3m" && sh -c "speaker-test -t sine -f 1000 -l 1 & sleep .5 && kill -9 \$!" 2>&1 > /dev/null'

# Get vim session
function getVimSession
    set -l branch_name (git branch 2>/dev/null | sed -n '/\* /s///p')
    set -l branch_name (echo $branch_name | sed -En 's/^(feature|bugFix|hotFix)\///p')
    set -l branch_name (echo $branch_name | sed -En 's/(-v[0-9]+|AfterMerge)?$//p')
    vim -S ~/sessions/$branch_name.vim
end
bind \cS getVimSession
