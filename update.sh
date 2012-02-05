#!/bin/bash

cd $HOME/.vim

git pull

# Some service dirs
[ -d tmp ] || mkdir -p tmp/backup tmp/swap tmp/undo

# Let’s Vundle update all bundles
vim -c ':BundleInstall!' -c ':q' -c ':q'

