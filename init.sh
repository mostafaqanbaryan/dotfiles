#!/bin/bash
dconf load / < ./keybindings.conf

# Fish
ln -s ${PWD}/fish_prompt.fish ~/.config/fish/functions/fish_prompt.fish
ln -s ${PWD}/config.fish ~/.config/fish/config.fish

# Vim
ln -s ${PWD}/vim ~/.vim
ln -s ${PWD}/vimrc ~/.vimrc

# NVim
ln -s ${PWD}/nvim ~/.config/nvim

# Starship
ln -s ${PWD}/starship.toml ~/.config/starship.toml

# Wezterm
ln -s ${PWD}/wezterm.lua ~/.wezterm.lua
cp ${PWD}/terminal.jpg ~/terminal.jpg
