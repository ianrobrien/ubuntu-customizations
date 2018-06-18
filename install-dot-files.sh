#!/usr/bin/env bash

###############################################################################
# Ian R. O'Brien
# https://gitlab.com/ianrobrien/development-configurations.git
#
# This script installs the capitaine-cursors mouse cursors theme into the
# current user's home directory, and enables it in gsettings
#
# Usage: ./install-capitaine-cursors.sh
###############################################################################

source="${PWD}/dot-files"

echo "Copying dot files to home directory..."

ln -sf ${source}/bin ${HOME}/.bin
ln -sf ${source}/.bash_aliases ${HOME}/.bash_aliases
ln -sf ${source}/.bashrc ${HOME}/.bashrc
ln -sf ${source}/.gitconfig ${HOME}/.gitconfig
ln -sf ${source}/.vimrc ${HOME}/.vimrc
ln -sf ${source}/.vim ${HOME}/.vim

# for file in ${source}/*
# do
#     echo "Copying ${file} to ${HOME}/.${file##*/}"
#     cp ${file} ${HOME}/.${file##*/}
# done

echo "Finished copying dot files to home directory."
echo "Sourcing .bashrc to pick up latest changes."
source ~/.bashrc
echo "Finished installing dot files."
