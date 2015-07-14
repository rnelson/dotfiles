#!/bin/sh

# Make necessary directories
mkdir -p ~/.vim/bundle
mkdir -p ~/.vim/colors

# Install Vundle
mkdir -p ~/.vim/bundle
if [[ ! -d ~/.vim/bundle/Vundle.vim ]]; then
    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

# Copy config files
cp -R files/vim/colors/* ~/.vim/colors
cp files/vimrc ~/.vimrc
cp files/zshrc ~/.zshrc
cp files/aliasrc ~/.aliasrc
cp files/tmux.conf ~/.tmux.conf