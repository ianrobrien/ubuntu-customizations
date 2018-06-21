#!/usr/bin/env bash

###############################################################################
# Ian R. O'Brien
# https://gitlab.com/ianrobrien/ubuntu-customization
#
# This script installs the capitaine-cursors mouse cursors theme into the
# current user's home directory, and enables it in gsettings
#
# Usage: ./install-capitaine-cursors.sh
###############################################################################
source="${PWD}/dotfiles"

echo "Copying dot files to home directory..."

# Copy over directories (delete them first otherwise recursive link is created) (TODO: loop)
unlink ${HOME}/.bin
ln -sf ${source}/.bin ${HOME}/.bin

unlink ${HOME}/.vim
ln -sf ${source}/.vim ${HOME}/.vim

unlink ${HOME}/.config/neofetch
ln -sf ${source}/.config/neofetch ${HOME}/.config/neofetch

# Copy over single files (TODO: loop)
ln -sf ${source}/.bash_aliases ${HOME}/.bash_aliases
ln -sf ${source}/.bashrc ${HOME}/.bashrc
cp ${source}/.gitconfig ${HOME}/.gitconfig
ln -sf ${source}/.profile ${HOME}/.profile
ln -sf ${source}/.inputrc ${HOME}/.inputrc
ln -sf ${source}/.vimrc ${HOME}/.vimrc

echo "Finished copying dot files to home directory."
echo "Sourcing .bashrc to pick up latest changes."
source ~/.bashrc
echo "Finished installing dot files."
