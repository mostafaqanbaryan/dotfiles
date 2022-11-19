#!/bin/bash
# dconf dump / > ./keybindings.conf.bak
# dconf load / < ./keybindings.conf

# Fish
rm ~/.config/fish/functions/fish_prompt.fish
ln -s ${PWD}/fish_prompt.fish ~/.config/fish/functions/fish_prompt.fish
rm ~/.config/fish/config.fish
ln -s ${PWD}/config.fish ~/.config/fish/config.fish

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
