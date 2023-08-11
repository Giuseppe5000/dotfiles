#!/bin/bash

# Paru
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd ..

# Install all packets
paru -S --needed $(sed -e '/^\s*#.*$/d' -e '/^\s*$/d' pacmanpkg.txt)

# Configs
mv .config/* $HOME/.config
sudo mv etc/* /etc

# Cursor
mv .icons $HOME

# Wallpaper
mv background.jpg $HOME/Immagini

# ZSH
mv .zshenv $HOME
mv .zshrc $HOME
