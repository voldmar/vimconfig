#!/bin/bash

cd $HOME

[ -d .vim ] && mv .vim .vim.old
[ -e .vimrc ] && mv .vimrc .vimrc.old

git clone git@github.com:voldmar/vimconfig.git .vim
ln -s .vim/vimrc .vimrc
cd .vim
./update.sh

