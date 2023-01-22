#!/bin/bash
# dconf dump / > ./keybindings.conf.bak
# dconf load / < ./keybindings.conf

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
