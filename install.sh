#!/bin/sh
set -xe
cd "$(dirname "$0")"

# Install some useful packages
useful_packages="cups curl firefox-esr firewall-config firewalld flameshot gromit-mpx \
keepassxc mpv rclone syncthing telegram-desktop thunderbird wget xournalpp zsh zsh-autosuggestions"
su -c "apt update && apt -y install $useful_packages"

# Symlink XDG configs
for dir in .config/*
do
    if [ -d "$dir" ] ; then
        mkdir -p ~/"$dir"
        for conf in "$dir"/*
        do
            # If symlink doesn't exist then create
            (ls ~/"$conf") || ln -s "$PWD"/"$conf" ~/"$conf"
        done
    fi
done

# Emacs config
(ls ~/.emacs.org) || ln -s "$PWD"/emacs.org ~/.emacs.org

# Vim config
(ls ~/.vimrc) || ln -s "$PWD"/.vimrc ~/.vimrc

# ZSH
(ls ~/.zshenv)        || ln -s "$PWD"/.zshenv ~/.zshenv
(ls ~/.zshrc)         || ln -s "$PWD"/.zshrc ~/.zshrc
(ls ~/.p10k.zsh)      || ln -s "$PWD"/.p10k.zsh ~/.p10k.zsh
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
    wget "$(echo "$nerdfonts_url" | grep IosevkaTerm.tar.xz | cut -d '"' -f 4)"
    tar xvf IosevkaTerm.tar.xz -C ~/.local/share/fonts
    rm IosevkaTerm.tar.xz
    fc-cache -f
fi

# Enable some services
su -c "systemctl enable firewalld --now && systemctl disable cups --now"
systemctl --user daemon-reload
systemctl --user enable syncthing --now
