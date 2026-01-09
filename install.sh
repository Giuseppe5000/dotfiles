#!/bin/sh
set -xe
cd "$(dirname "$0")"

# Install some useful packages
useful_packages="curl emacs firewall-config firewalld flameshot keepassxc rclone syncthing xournalpp"
sudo apt update && sudo apt -y install $useful_packages

# Emacs config
ln -sf "$PWD"/emacs.org ~/.emacs.org

# Install fonts
if [ ! -e ~/.local/share/fonts/IosevkaTermNerdFont-Regular.ttf ]
then
    mkdir -p ~/.local/share/fonts
    nerdfonts_url="$(curl -s https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest | grep browser_download_url)"
    curl -LO "$(echo "$nerdfonts_url" | grep IosevkaTerm.tar.xz | cut -d '"' -f 4)"
    tar xvf IosevkaTerm.tar.xz -C ~/.local/share/fonts
    rm IosevkaTerm.tar.xz
    fc-cache -f
fi

# Enable some services
sudo systemctl enable firewalld --now
systemctl --user daemon-reload
systemctl --user enable syncthing --now

# Git remote conf
git remote set-url origin git@github.com:Giuseppe5000/dotfiles.git

# Download GitHub repos in ~/Projects
mkdir -p ~/Projects
cd ~/Projects

REPOS=$(curl -s https://api.github.com/users/Giuseppe5000/repos)
URLS=$(echo "$REPOS" | grep -o '\"clone_url\": \"[^\"]*\"' | sed 's/\"clone_url\": \"//;s/\"//')

for url in $URLS; do
    git clone "$url"
done
