#!/bin/bash

# Sudo check
if ! $(sudo -l &> /dev/null); then
    echo 'Error: root privileges are needed to run this script'
    exit -1
fi

cd $(dirname $0)

# Install all packets
sudo apt update
sudo apt -y install $(sed -e '/^\s*#.*$/d' -e '/^\s*$/d' aptpkg.txt)
if [[ $? > 0 ]]
then
    exit
fi

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

# NetworkManager MAC randomization conf
# sudo mv etc/NetworkManager/conf.d/wifi_rand_mac.conf /etc/NetworkManager/conf.d/

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

# Greenclip
mkdir -p $HOME/.local/bin
wget https://github.com/erebe/greenclip/releases/download/v4.2/greenclip -O $HOME/.local/bin/greenclip
chmod +x $HOME/.local/bin/greenclip

# Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.powerlevel10k

# Nerd Fonts
mkdir -p $HOME/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/IosevkaTerm.tar.xz
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/DejaVuSansMono.tar.xz
tar xvf IosevkaTerm.tar.xz -C $HOME/.local/share/fonts
tar xvf DejaVuSansMono.tar.xz -C $HOME/.local/share/fonts
rm IosevkaTerm.tar.xz DejaVuSansMono.tar.xz
fc-cache -f

# Enable some services
sudo systemctl enable NetworkManager
sudo systemctl enable firewalld
systemctl --user enable syncthing
sudo cp /usr/share/doc/offlineimap3/examples/systemd/offlineimap.service /etc/systemd/user/
systemctl --user daemon-reload
systemctl --user enable offlineimap

# Set zsh as default shell
chsh -s /usr/bin/zsh
