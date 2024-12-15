source ~/.cache/carapace/init.nu
source ~/.env.nu

# Prompt
$env.STARSHIP_SHELL = "nu"
$env.PROMPT_COMMAND = { || create_left_prompt }
$env.PROMPT_COMMAND_RIGHT = ""
$env.PROMPT_INDICATOR = ""
$env.PROMPT_INDICATOR_VI_INSERT = ": "
$env.PROMPT_INDICATOR_VI_NORMAL = "〉"
$env.PROMPT_MULTILINE_INDICATOR = "::: "
use ~/.cache/starship/init.nu

# Editor
alias s = sessions
alias v = nvim

# Dockers
alias dcu = docker-compose -f docker-compose.yml up -d
alias dcd = docker-compose -f docker-compose.yml down
alias dcpu = docker-compose -f docker-compose.prod.yml up -d
alias dcpd = docker-compose -f docker-compose.prod.yml down
def dpi [] {
    docker images | from ssv -a | sort-by STATUS | reverse
}
def dps [] {
    docker ps | from ssv -a | sort-by STATUS | reverse
}

# Git
alias dev = git checkout develop
alias gl = git pull
alias gp = git push -u origin HEAD
alias glo = git log
alias gst = git status
alias gco = git checkout
alias gdi = git diff
alias gre = git rebase
alias gcm = git commit -m 
alias gca = git commit --amend
alias parent = git log --first-parent

# Fun
alias download = aria2c -c -x 10 -s 10
alias g = lazygit
alias cp = xcp
# alias du = 'dust'
# alias ls = 'exa --icons=always --hyperlink --git-repos --git'

$env.config = {
    show_banner: false,
    edit_mode: vi,
    keybindings: [
        {
            name: reload_config
            modifier: none
            keycode: f5
            mode: [emacs vi_normal vi_insert]
            event: {
                send: executehostcommand,
                cmd: $"source '($nu.env-path)';source '($nu.config-path)'"
            }
        }
    ]
}
