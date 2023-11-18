#!/bin/bash

# Scripts
ln -s ${PWD}/scripts ~/.scripts
mkdir ~/Pictures/wallpapers

# Fish
sudo pacman -S \
    fish
rm -rf ~/.config/fish/functions 2&>1 /dev/null
rm -rf ~/.config/fish/completions 2&>1 /dev/null
rm -rf ~/.config/fish/config.fish 2&>1 /dev/null
ln -s ${PWD}/fish/completions ~/.config/fish/completions
ln -s ${PWD}/fish/functions ~/.config/fish/functions
ln -s ${PWD}/fish/config.fish ~/.config/fish/config.fish

# NVim
sudo pacman -S \
    neovim \
    bat \
    ripgrep \
    noto-fonts-emoji \
    fzf
rm ~/.config/nvim -rf 2&>1 /dev/null
ln -s ${PWD}/nvim ~/.config/nvim

# Starship
sudo pacman -S \
    starship
rm ~/.config/starship.toml 2&>1 /dev/null
ln -s ${PWD}/starship.toml ~/.config/starship.toml

# Wezterm
sudo pacman -S \
    wezterm
rm ~/.wezterm.lua 2&>1 /dev/null
ln -s ${PWD}/wezterm.lua ~/.wezterm.lua
cp ${PWD}/terminal.jpg ~/terminal.jpg

# Filemanager
yay -S ranger python-pynvim ueberzug
rm ~/.config/ranger/ranger.conf 2>&1 /dev/null
mkdir ~/.config/ranger -p
ln -s ${PWD}/ranger.conf ~/.config/ranger/ranger.conf

# WM
sudo pacman -S \
    wl-clipboard \
    cliphist \
    rofi \
    highlight \
    pass \
    swayidle \
    xdg-desktop-portal-wlr \
    xdg-desktop-portal-hyprland \
    xdg-desktop-portal-gtk \
    pipwire \
    wireplumber \
    zellij

yay -Sy \
    swaylock-effects-git \
    google-chrome \
    swww \
    qalculate-gtk \
    waypaper

rm -rf ~/.config/hypr 2&>1 /dev/null
ln -s ${PWD}/hypr ~/.config/hypr

rm -rf ~/.config/zellij 2&>1 /dev/null
ln -s ${PWD}/zellij ~/.config/zellij

# Bar
sudo pacman -S \
    waybar \
    swappy \
    grim \
    slurp \
    pavucontrol
rm -rf ~/.config/waybar 2&>1 /dev/null
ln -s ${PWD}/waybar ~/.config/waybar

# Network manager by Rofi
ln -s ${PWD}/networkmanager-dmenu ~/.config/networkmanager-dmenu

# Rofi themes for powermenu and launcher
pushd /tmp && git clone --depth=1 https://github.com/adi1090x/rofi.git && cd /tmp/rofi
chmod +x setup.sh
./setup.sh
popd
rm -rf /tmp/rofi

# Fonts
# https://github.com/rastikerdar/vazir-code-font/releases
# https://www.nerdfonts.com/font-downloads > Symbols Nerd Font | Symbols Only
rm -rf ~/.fonts 2&>1 /dev/null
ln -s ${PWD}/fonts ~/local/share/.fonts

# Services
sudo pacman -S \
    gnome-keyring
mkdir ~/.config/systemd -p
ln -s ${PWD}/services/* ~/.config/systemd/user
systemctl daemon-reload --user
systemctl enable --now --user gnome-keyring-daemon
