#!/bin/bash

cd $HOME/.vim

git pull

# Update vundle as it only submodule
git submodule init
git submodule update

# Some service dirs
[ -d tmp ] || mkdir -p tmp/backup tmp/swap tmp/undo

# Let’s Vundle update all bundles
vim -c ':BundleInstall!' -c ':q' -c ':q'

