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

for file in ${source}/*
do
    echo "Copying ${file} to ${HOME}/.${file##*/}"
    cp ${file} ${HOME}/.${file##*/}
done

grep -q -F 'source one-dark-bash-prompt' ${HOME}/.bashrc || cat  >> ${HOME}/.bashrc <<EOF
source ${HOME}/.one-dark-bash-prompt
EOF

echo "Finished copying dot files to home directory."
echo "Sourcing .bashrc to pick up latest changes."
source ~/.bashrc
echo "Finished installing dot files."
