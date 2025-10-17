#!/bin/sh
set -xe
cd "$(dirname "$0")"

# Install some useful packages
useful_packages="curl firewall-config firewalld flameshot keepassxc rclone syncthing xournalpp zsh zsh-autosuggestions"
su -c "apt update && apt -y install $useful_packages"

# Vim config
(ls ~/.vimrc) || ln -s "$PWD"/vimrc ~/.vimrc

# Emacs config
(ls ~/.emacs.org) || ln -s "$PWD"/emacs.org ~/.emacs.org

# ZSH
(ls ~/.zshenv)        || ln -s "$PWD"/zshenv ~/.zshenv
(ls ~/.zshrc)         || ln -s "$PWD"/zshrc ~/.zshrc
(ls ~/.p10k.zsh)      || ln -s "$PWD"/p10k.zsh ~/.p10k.zsh
(ls ~/.powerlevel10k) || git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k

if [ "$SHELL" != "/usr/bin/zsh" ]
then
    chsh -s /usr/bin/zsh
fi

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
su -c "systemctl enable firewalld --now"
systemctl --user daemon-reload
systemctl --user enable syncthing --now

# Git remote conf
git remote set-url origin git@github.com:Giuseppe5000/dotfiles.git
