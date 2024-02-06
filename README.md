# Dotfiles
My current setup and tools I use:
- [EndeavourOS](https://endeavouros.com/)
- [Hyprland](https://hyprland.org/) as window manager
- [Waybar](https://github.com/Alexays/Waybar) as status bar
- [Wezterm](https://github.com/wez/wezterm) as my terminal
- [Monaco](https://github.com/cseelus/monego) fonts
- [Fish](https://github.com/fish-shell/fish-shell) as my shell
- [Starship](https://github.com/cseelus/monego) as prompt
- [Neovim](https://github.com/neovim/neovim) as my Editor/IDE
- [Ranger](https://github.com/ranger/ranger) as filemanager
- [Musikcube](https://github.com/clangen/musikcube) as my player
- [Rofi](https://github.com/davatorium/rofi) as launcher

## Softwares
- [FZF](https://github.com/junegunn/fzf) fuzzy in terminal
- [Grim](https://github.com/emersion/grim), [Slurp](https://github.com/emersion/slurp) and [Swappy](https://github.com/jtheoof/swappy) for taking screenshots in Sway
- [Termdown](https://github.com/trehn/termdown) beautiful countdown timer in terminal
- [NotificationCenter](https://github.com/ErikReider/SwayNotificationCenter) Sway notificaion center
- Highlight in ranger

## Setup
- Clone this repository to your SSD (For better performance of `VIM`)
- Run `ansible-playbook -K ansible/playbook.yml`
- You can add your `fish` config inside `~/env.fish`
- Enjoy!
