function fish_greeting
    starship init fish | source
	zoxide init fish | source
end

# Editor
function vim
    tmux set-option -g status-style bg=#232136
    PHP_CS_FIXER_IGNORE_ENV=1 nvim $argv
    tmux set-option -g status-style bg=default
end
alias v "vim"
alias s "sessions"

# Dockers
abbr dcu "docker compose -f docker-compose.yml up -d"
abbr dcd "docker compose -f docker-compose.yml down"
abbr dcpu "docker compose -f docker-compose.prod.yml up -d"
abbr dcpd "docker compose -f docker-compose.prod.yml down"

# Git
abbr gl "git pull"
abbr gp "git push -u origin HEAD"
abbr glo "git log"
abbr gst "git status"
abbr gco "git checkout"
abbr gd "git diff"
abbr gre "git rebase"
abbr gcm 'git commit -m "'
abbr gca "git commit --amend"
abbr parent "git log --first-parent"
abbr dev "git checkout develop"


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
bind \ca forward-word
bind -M insert \ca forward-word

# Fun
alias download 'aria2c -c -x 10 -s 10'
alias kodi 'kodi --standalone --windowing=x11'
alias g 'lazygit'
alias cp 'xcp'
alias du 'dust'
alias ls 'exa --icons=always --hyperlink --git-repos --git'
alias search 'yazi (realpath (fzf))'

## SSH
set -Ux GNOME_KEYRING_CONTROL /run/user/1000/keyring
set -Ux SSH_AUTH_SOCK /run/user/1000/keyring/ssh

## Vi Mode
fish_vi_key_bindings
set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_visual underscore

## Rust
set -Ua fish_user_paths $HOME/.cargo/bin

set -x PATH "$PATH:$HOME/.local/bin"
set -x SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/gcr/ssh"

## Default applications
set -gx BROWSER brave
set -gx EDITOR nvim

# Override
if ! test -f "$HOME/.env.fish" 
    touch $HOME/.env.fish
end
source $HOME/.env.fish
