#!/bin/sh
set -e

cd "$(dirname "$0")"

# Install all packets
su -c "apt update && apt -y install $(sed '/^[[:blank:]]*#/d;s/#.*//' aptpkg.txt |tr '\n' ' ')"

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

# Cursor
mv .icons "$HOME"

# Create user dirs
LC_ALL=C.UTF-8 xdg-user-dirs-update --force

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
greenclip_url="$(curl -s https://api.github.com/repos/erebe/greenclip/releases/latest | grep browser_download_url | cut -d '"' -f 4 | head -n 1)"
wget "$greenclip_url" -O "$HOME"/.local/bin/greenclip
chmod +x "$HOME"/.local/bin/greenclip

# Cliphist (sway)
cliphist_url="$(curl -s https://api.github.com/repos/sentriz/cliphist/releases/latest | grep browser_download_url | grep amd64 | cut -d '"' -f 4)"
wget "$cliphist_url" -O "$HOME"/.local/bin/cliphist
chmod +x "$HOME"/.local/bin/cliphist

# Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME"/.powerlevel10k

# Nerd Fonts
mkdir -p "$HOME"/.local/share/fonts
nerdfonts_url="$(curl -s https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest | grep browser_download_url)"
wget "$(echo "$nerdfonts_url" | grep IosevkaTerm.tar.xz | cut -d '"' -f 4)"
wget "$(echo "$nerdfonts_url" | grep DejaVuSansMono.tar.xz | cut -d '"' -f 4)"
tar xvf IosevkaTerm.tar.xz -C "$HOME"/.local/share/fonts
tar xvf DejaVuSansMono.tar.xz -C "$HOME"/.local/share/fonts
rm IosevkaTerm.tar.xz DejaVuSansMono.tar.xz
fc-cache -f

# Enable some services
su -c 'systemctl enable NetworkManager && systemctl enable firewalld && systemctl disable bluetooth && systemctl disable cups && systemctl disable tor && cp /usr/share/doc/offlineimap3/examples/systemd/offlineimap.service /etc/systemd/user/'
systemctl --user daemon-reload
systemctl --user enable syncthing
systemctl --user enable offlineimap

# Set zsh as default shell
chsh -s /usr/bin/zsh
