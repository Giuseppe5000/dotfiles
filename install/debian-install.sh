#!/bin/bash

# Sudo check
if ! $(sudo -l &> /dev/null); then
    echo 'Error: root privileges are needed to run this script'
    exit -1
fi

# Install all packets
sudo apt update
sudo apt -y install $(sed -e '/^\s*#.*$/d' -e '/^\s*$/d' aptpkg.txt)

cd $(dirname $0)
cd ..

# Configs
mkdir $HOME/.config
mv .config/* $HOME/.config

# Emacs config
mv .emacs.org $HOME

# Vim config
mv .vimrc $HOME
mv .clang-format $HOME

# GnuPG
mv .gnupg $HOME

# NetworkManager MAC randomization conf
# sudo mv etc/NetworkManager/conf.d/wifi_rand_mac.conf /etc/NetworkManager/conf.d/

# Cursor
mv .icons $HOME

# Create user dirs
xdg-user-dirs-update

# Wallpapers
mv Wallpapers $HOME/Pictures

# ZSH
mv .zshenv $HOME
mv .zshrc-debian $HOME/.zshrc
mv .p10k.zsh $HOME

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
