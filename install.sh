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
mkdir $HOME/.config
mv .config/* $HOME/.config

# Ly
sudo rm /etc/ly/config.ini
sudo mv etc/ly/config.ini /etc/ly/

# Cursor
mv .icons $HOME

# Theme
mv .themes $HOME

# Create user dirs
LC_ALL=it_IT.UTF-8 xdg-user-dirs-update --force

# Wallpaper
mv background.jpg $HOME/Immagini

# ZSH
mv .zshenv $HOME
mv .zshrc $HOME
mv .p10k.zsh $HOME

# Notes
touch $HOME/.notes

# Enable display manager and networkmanager
sudo systemctl enable ly
sudo systemctl enable NetworkManager
