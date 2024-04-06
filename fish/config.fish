function fish_greeting
    starship init fish | source
	zoxide init fish | source
	zellij_tab_name_update
end

source ~/env.fish

function zellij_tab_name_update --on-variable PWD
    if set -q ZELLIJ
        set tab_name ''
        set tab_name $PWD
        if test "$tab_name" = "$HOME"
            set tab_name "~"
        else
            set tab_name (basename "$tab_name")
        end
        zellij action rename-tab $tab_name >/dev/null
    end
end

function set_user_var
   printf "\033]1337;SetUserVar=%s=%s\007" $argv[1] (echo -n $argv[2] | base64)
end

# Editor
alias v "nvim"
alias s "sessions"

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
abbr projects "zellij -l projects attach --create Local"

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
# set -gx TERM wezterm
