function fish_greeting
    starship init fish | source
end

function wezterm_set_user_var
# if type base64 2>/dev/null
      # <https://github.com/tmux/tmux/wiki/FAQ#what-is-the-passthrough-escape-sequence-and-how-do-i-use-it>
      printf "\033Ptmux;\033\033]1337;SetUserVar=%s=%s\007\033\\" "$argv[1]" (echo -n "$argv[2]" | base64)
# end
end

source ~/env.fish

alias PHPERROR 'sudo tail -f /var/log/php-fpm/www-error.log'
alias nethogs 'sudo nethogs'
alias kodi 'kodi-standalone --windowing=x11'

# Show hostname of remote server in Wezterm
function ssh
    /usr/bin/ssh -F ~/.ssh/ssh_config $argv && wezterm_set_user_var SSH_ENV 
end

# Editor
alias vim "nvim"
set -x EDITOR "nvim"
abbr v "nvim"

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

# Fun
alias coffee 'termdown "3m" && sh -c "speaker-test -t sine -f 1000 -l 1 & sleep .5 && kill -9 \$!" 2>&1 > /dev/null'
alias download 'aria2c -c -x 10 -s 10'

## SSH
set -Ux GNOME_KEYRING_CONTROL /run/user/1000/keyring
set -Ux SSH_AUTH_SOCK /run/user/1000/keyring/ssh

## Vi Mode
fish_vi_key_bindings
set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_visual underscore

# Search by Ctrl+p and Ctrl+n
bind -M insert \cp history-search-backward
bind -M insert \cn history-search-forward
