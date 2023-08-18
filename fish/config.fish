function fish_greeting
    starship init fish | source
end

source ~/env.fish

alias PHPERROR 'sudo tail -f /var/log/php-fpm/www-error.log'
alias nethogs 'sudo nethogs'
alias kodi 'kodi-standalone --windowing=x11'

# Editor
alias vim "set -q ZELLIJ && nvim || zellij"
set -x EDITOR "nvim"
abbr v "vim"

# Dockers
abbr dcu "docker-compose -f docker-compose.yml up -d"
abbr dcd "docker-compose -f docker-compose.yml down"
abbr dcpu "docker-compose -f docker-compose.prod.yml up -d"
abbr dcpd "docker-compose -f docker-compose.prod.yml down"

# Git
abbr gu "git pull"
abbr gp "git push -u origin HEAD"
abbr gl "git log"
abbr gst "git status"
abbr gco "git checkout"
abbr gdi "git diff"
abbr gre "git rebase"
abbr gcm 'git commit -m "'
abbr gca "git commit --amend"
abbr parent "git log --first-parent"

# Ctrl+Backspace
bind \b backward-kill-word

# Ctrl+Delete
bind \e\[3\;5~ kill-word

# Search by Ctrl+p and Ctrl+n
bind \cp history-search-backward
bind -M insert \cp history-search-backward
bind  \cn history-search-forward
bind -M insert \cn history-search-forward

# Complete command
bind \ce end-of-line
bind -M insert \ce end-of-line
bind \ca forward-bigword
bind -M insert \ca forward-bigword

# Fun
alias coffee 'termdown "3m" && sh -c "speaker-test -t sine -f 1000 -l 1 & sleep .5 && kill -9 \$!" 2>&1 > /dev/null'
alias download 'aria2c -c -x 10 -s 10'
alias kodi 'kodi --standalone --windowing=x11'

## SSH
set -Ux GNOME_KEYRING_CONTROL /run/user/1000/keyring
set -Ux SSH_AUTH_SOCK /run/user/1000/keyring/ssh

## Vi Mode
fish_vi_key_bindings
set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_visual underscore
