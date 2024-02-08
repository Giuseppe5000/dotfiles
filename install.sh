#!/bin/bash

# Sudo check
if ! $(sudo -l &> /dev/null); then
    echo 'Error: root privileges are needed to run this script'
    exit -1
fi

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

# Vim config
mv .vimrc $HOME
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
mv .clang-format $HOME

# GnuPG
mv .gnupg $HOME

# Ly
sudo mv etc/ly/config.ini /etc/ly/config.ini

# NetworkManager MAC randomization conf
sudo mv etc/NetworkManager/conf.d/wifi_rand_mac.conf /etc/NetworkManager/conf.d/

# Cursor
mv .icons $HOME

# Create user dirs
LC_ALL=it_IT.UTF-8 xdg-user-dirs-update --force

# Wallpapers
mv Wallpapers $HOME/Immagini

# ZSH
mv .zshenv $HOME
mv .zshrc $HOME
mv .p10k.zsh $HOME

# Enable some services
sudo systemctl enable ly
sudo systemctl enable NetworkManager
sudo systemctl enable firewalld
systemctl --user enable syncthing

# Set zsh as default shell
chsh -s /usr/bin/zsh
