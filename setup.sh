#!/usr/bin/env bash

# Make necessary directories
mkdir -p ~/.vim/bundle
mkdir -p ~/.vim/colors

## Install Vundle
if [[ ! -d ~/.vim/bundle/Vundle.vim ]]; then
    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

# Copy config files
cp files/vimrc ~/.vimrc
cp files/zshrc ~/.zshrc
cp files/aliasrc ~/.aliasrc
cp files/tmux.conf ~/.tmux.conf

# Install vim plugins; do this before copying .vimrc
# or else the 
vim +PluginInstall +qall

# Set up the vim color scheme
echo '' >> ~/.vimrc
echo '" Turn on syntax highlighting' >> ~/.vimrc
echo 'let g:solarized_termcolors=256' >> ~/.vimrc
echo 'set t_Co=256' >> ~/.vimrc
echo 'syntax enable' >> ~/.vimrc
echo 'syntax on' >> ~/.vimrc
echo 'set background=dark' >> ~/.vimrc
echo 'colorscheme solarized' >> ~/.vimrc
