#!/bin/bash

cd $HOME/.vim

git pull --rebase

# Let’s Vundle update all bundles
vim +BundleClean\! +qall
vim +BundleInstall\! +qall

