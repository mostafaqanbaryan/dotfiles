#!/bin/bash

sudo dnf install \
    swappy \
    wl-clipboard \
    grim \
    wezterm \
    fish \
    starship \
    neovim \
    ranger \
    sway \
    waybar \
    rofi \
    highlight


# Fish
rm ~/.config/fish/functions -rf 2>&1 /dev/null
rm ~/.config/fish/completions -rf 2>&1 /dev/null
rm ~/.config/fish/config.fish 2>&1 /dev/null
ln -s ${PWD}/fish/completions ~/.config/fish/completions
ln -s ${PWD}/fish/functions ~/.config/fish/functions
ln -s ${PWD}/fish/config.fish ~/.config/fish/config.fish

# NVim
rm ~/.config/nvim -rf 2>&1 /dev/null
ln -s ${PWD}/nvim ~/.config/nvim

# Starship
rm ~/.config/starship.toml 2>&1 /dev/null
ln -s ${PWD}/starship.toml ~/.config/starship.toml

# Wezterm
rm ~/.wezterm.lua 2>&1 /dev/null
ln -s ${PWD}/wezterm.lua ~/.wezterm.lua
cp ${PWD}/terminal.jpg ~/terminal.jpg

# Ranger
rm ~/.config/ranger/ranger.conf 2>&1 /dev/null
mkdir ~/.config/ranger -p
ln -s ${PWD}/ranger.conf ~/.config/ranger/ranger.conf

# Fonts
rm -rf ~/.fonts 2>&1 /dev/null
ln -s ${PWD}/fonts ~/.fonts

# Services
mkdir ~/.config/systemd -p
ln -s ${PWD}/services/* ~/.config/systemd/user
systemctl daemon-reload --user
systemctl enable --now --user gnome-keyring-daemon

# WM
rm -rf ~/.config/sway 2>&1 /dev/null
ln -s ${PWD}/sway ~/.config/sway

# Bar
rm -rf ~/.config/waybar 2>&1 /dev/null
ln -s ${PWD}/waybar ~/.config/waybar
