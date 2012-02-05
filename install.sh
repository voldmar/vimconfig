#!/bin/bash

cd $HOME

[ -d .vim ] && mv .vim .vim.old
[ -e .vimrc ] && mv .vimrc .vimrc.old

git clone git@github.com:voldmar/vimconfig.git .vim
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
ln -s .vim/vimrc .vimrc
cd .vim
./update.sh

