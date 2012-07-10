#!/bin/bash

cd $HOME/.vim

git pull --rebase

# Some service dirs
[ -d tmp ] || mkdir -p tmp/backup tmp/swap tmp/undo

# Let’s Vundle update all bundles
vim +BundleClean\! +qall
vim +BundleInstall\! +qall

