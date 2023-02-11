function fish_greeting
    starship init fish | source
end

source ~/env.fish

alias PHPERROR 'sudo tail -f /var/log/php-fpm/www-error.log'
alias nethogs 'sudo nethogs'
alias kodi 'kodi-standalone --windowing=x11'

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

# Fun
alias coffee 'termdown "3m" && sh -c "speaker-test -t sine -f 1000 -l 1 & sleep .5 && kill -9 \$!" 2>&1 > /dev/null'
alias download 'aria2c -c -x 10 -s 10'

# Get vim session
function getVimSession
    set -l branch_name (git branch 2>/dev/null | sed -n '/\* /s///p')
    set -l branch_name (echo $branch_name | sed -En 's/^(feature|bugFix|hotFix)\///p')
    set -l branch_name (echo $branch_name | sed -En 's/(-v[0-9]+|AfterMerge)?$//p')
    vim -S ~/sessions/$branch_name.vim
end
bind \cS getVimSession

## https://github.com/flameshot-org/flameshot/blob/master/docs/Sway%20and%20wlroots%20support.md
export SDL_VIDEODRIVER=wayland
export _JAVA_AWT_WM_NONREPARENTING=1
export QT_QPA_PLATFORM=wayland
export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_DESKTOP=sway

## SSH
set -Ux GNOME_KEYRING_CONTROL /run/user/1000/keyring
set -Ux SSH_AUTH_SOCK /run/user/1000/keyring/ssh
