#!/bin/bash

cd $HOME/.vim
git pull > /dev/null
git submodule init > /dev/null
git submodule update > /dev/null

