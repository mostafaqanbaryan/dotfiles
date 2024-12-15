## SSH
$env.GNOME_KEYRING_CONTROL  = $env.XDG_RUNTIME_DIR | append "keyring" | str join "/"
$env.SSH_AUTH_SOCK          = $env.XDG_RUNTIME_DIR | append "gcr/ssh" | str join "/"
$env.PATH                   = $env.PATH | append ($env.HOME | append ".local/bin/" | str join "/") | str join ":"

## Default applications
$env.BROWSER = "brave"
$env.EDITOR  = "nvim"

## Create custom env file if not exists
bash -c "[ ! -f '/home/$env.USER/.env.nu' ] && touch ~/.env.nu"

## Autocomplete
$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
mkdir ~/.cache/carapace
carapace _carapace nushell | save --force ~/.cache/carapace/init.nu
