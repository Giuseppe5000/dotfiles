#!/bin/sh

cd "$(dirname "$0")" || exit

# Install all packets
su -c "apt update && apt -y install $(sed '/^[[:blank:]]*#/d;s/#.*//' aptpkg.txt |tr '\n' ' ')" || exit

cd ..

# XDG configs
for dir in .config/*
do
    if [ -d "$dir" ] ; then
        mkdir -p "$HOME"/"$dir"
        for conf in "$dir"/*
        do
            ln -s "$PWD"/"$conf" "$HOME"/"$conf"
        done
    fi
done

# Emacs config
ln -s "$PWD"/.emacs.org "$HOME"/.emacs.org

# Vim config
ln -s "$PWD"/.vimrc "$HOME"/.vimrc

# GnuPG
mkdir -p "$HOME"/.gnupg
ln -s "$PWD"/.gnupg/gpg-agent.conf "$HOME"/.gnupg/gpg-agent.conf

# NetworkManager MAC randomization conf
# su -c 'mv etc/NetworkManager/conf.d/wifi_rand_mac.conf /etc/NetworkManager/conf.d/'

# Cursor
mv .icons "$HOME"

# Create user dirs
xdg-user-dirs-update

# Wallpapers
mv Wallpapers "$HOME"/Pictures

# ZSH
ln -s "$PWD"/.zshenv "$HOME"/.zshenv
ln -s "$PWD"/.zshrc "$HOME"/.zshrc
ln -s "$PWD"/.p10k.zsh "$HOME"/.p10k.zsh

# Firefox user.js
timeout 10s firefox --headless # Gen profile folder
PROFILE_PATH=$(grep '^Path=.*default-esr$' "$HOME"/.mozilla/firefox/profiles.ini | cut -c 6-)
ln -s "$PWD"/user.js "$HOME"/.mozilla/firefox/"$PROFILE_PATH"/user.js

# Greenclip (i3)
mkdir -p "$HOME"/.local/bin
wget https://github.com/erebe/greenclip/releases/download/v4.2/greenclip -O "$HOME"/.local/bin/greenclip
chmod +x "$HOME"/.local/bin/greenclip

# Cliphist (sway)
wget https://github.com/sentriz/cliphist/releases/download/v0.1.2/v0.1.2-linux-amd64 -O "$HOME"/.local/bin/cliphist
chmod +x "$HOME"/.local/bin/cliphist

# Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME"/.powerlevel10k

# Nerd Fonts
mkdir -p "$HOME"/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/IosevkaTerm.tar.xz
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/DejaVuSansMono.tar.xz
tar xvf IosevkaTerm.tar.xz -C "$HOME"/.local/share/fonts
tar xvf DejaVuSansMono.tar.xz -C "$HOME"/.local/share/fonts
rm IosevkaTerm.tar.xz DejaVuSansMono.tar.xz
fc-cache -f

# Enable some services
su -c 'systemctl enable NetworkManager && systemctl enable firewalld && cp /usr/share/doc/offlineimap3/examples/systemd/offlineimap.service /etc/systemd/user/'
systemctl --user daemon-reload
systemctl --user enable syncthing
systemctl --user enable offlineimap

# Set zsh as default shell
chsh -s /usr/bin/zsh
