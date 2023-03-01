#!/bin/bash
# dconf dump / > ./keybindings.conf.bak
# dconf load / < ./keybindings.conf
#
sudo dnf install \
    swappy \
    wl-clipboard \
    grim

# Add ssh hostname to wezterm
echo "
    Host * !*git*
        ServerAliveInterval 60
        RequestTTY force
        RemoteCommand printf \"\033Ptmux;\033\033]1337;SetUserVar=SSH_ENV=$(hostname | base64)\007\033\\\"; cat /run/motd.dynamic; $SHELL
" >> ~/.ssh/config

# Fish
rm ~/.config/fish/functions -rf
rm ~/.config/fish/completions -rf
rm ~/.config/fish/config.fish
ln -s ${PWD}/fish/completions ~/.config/fish/completions
ln -s ${PWD}/fish/functions ~/.config/fish/functions
ln -s ${PWD}/fish/config.fish ~/.config/fish/config.fish

# NVim
rm ~/.config/nvim -rf
ln -s ${PWD}/nvim ~/.config/nvim

# Starship
rm ~/.config/starship.toml
ln -s ${PWD}/starship.toml ~/.config/starship.toml

# Wezterm
rm ~/.wezterm.lua
ln -s ${PWD}/wezterm.lua ~/.wezterm.lua
cp ${PWD}/terminal.jpg ~/terminal.jpg

# Ranger
rm ~/ranger.conf
ln -s ${PWD}/ranger.conf ~/.config/ranger/ranger.conf

# Services
ln -s ${PWD}/services ~/.config/systemd/user
systemctl daemon-reload --user
systemctl enable --now --user gnome-keyring-daemon

# WM
ln -s ${PWD}/sway/config ~/.config/sway/config
