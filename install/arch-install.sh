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

cd $(dirname $0)

# Install all packets
paru -S --needed $(sed -e '/^\s*#.*$/d' -e '/^\s*$/d' pacmanpkg.txt)

cd ..

# XDG configs
for dir in .config/*
do
    if [ -d "$dir" ] ; then
        mkdir -p $HOME/$dir
        for conf in $dir/*
        do
            ln -s $PWD/$conf $HOME/$conf
        done
    fi
done

# Emacs config
ln -s $PWD/.emacs.org $HOME/.emacs.org

# Vim config
ln -s $PWD/.vimrc $HOME/.vimrc
ln -s $PWD/.clang-format $HOME/.clang-format

# GnuPG
mkdir -p $HOME/.gnupg
ln -s $PWD/.gnupg/gpg-agent.conf $HOME/.gnupg/gpg-agent.conf

# Ly
sudo mv etc/ly/config.ini /etc/ly/config.ini

# NetworkManager MAC randomization conf
sudo mv etc/NetworkManager/conf.d/wifi_rand_mac.conf /etc/NetworkManager/conf.d/

# Cursor
mv .icons $HOME

# Create user dirs
xdg-user-dirs-update

# Wallpapers
mv Wallpapers $HOME/Pictures

# ZSH
ln -s $PWD/.zshenv $HOME/.zshenv
ln -s $PWD/.zshrc-debian $HOME/.zshrc
ln -s $PWD/.p10k.zsh $HOME/.p10k.zsh

# Enable some services
sudo systemctl enable ly
sudo systemctl enable NetworkManager
sudo systemctl enable firewalld
systemctl --user enable syncthing
systemctl --user enable offlineimap

# Set zsh as default shell
chsh -s /usr/bin/zsh
