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

# Emacs
mv .emacs.org $HOME

# GnuPG
mv .gnupg $HOME

# Ly
sudo rm /etc/ly/config.ini
sudo mv etc/ly/config.ini /etc/ly/

# NetworkManager MAC randomization conf
sudo mv etc/NetworkManager/conf.d/wifi_rand_mac.conf /etc/NetworkManager/conf.d/

# Cursor
mv .icons $HOME

# Theme
mv .themes $HOME

# Create user dirs
LC_ALL=it_IT.UTF-8 xdg-user-dirs-update --force

# Wallpapers
mv Wallpapers $HOME/Immagini

# ZSH
mv .zshenv $HOME
mv .zshrc $HOME
mv .p10k.zsh $HOME

# Notes
touch $HOME/.notes

# Enable some services
sudo systemctl enable ly
sudo systemctl enable NetworkManager
sudo systemctl enable firewalld
systemctl --user enable emacs
systemctl --user enable offlineimaps
