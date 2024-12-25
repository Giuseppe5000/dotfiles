#!/bin/sh
set -e

cd "$(dirname "$0")"

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

# ZSH
ln -s "$PWD"/.zshenv "$HOME"/.zshenv
ln -s "$PWD"/.zshrc "$HOME"/.zshrc
ln -s "$PWD"/.p10k.zsh "$HOME"/.p10k.zsh
chsh -s /usr/bin/zsh
