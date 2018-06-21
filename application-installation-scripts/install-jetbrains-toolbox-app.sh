#!/usr/bin/env bash

###############################################################################
# Ian R. O'Brien
# https://gitlab.com/ianrobrien/ubuntu-customizations
#
#
# Usage: ./install-intellij-idea.sh
###############################################################################
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

echo "Installing JetBrains Toolbox App..."

version="jetbrains-toolbox-1.8.3868"
gz_file_name="${version}.tar.gz"
install_target="/home/ianrobrien/.local/share/"

wget https://download.jetbrains.com/toolbox/${gz_file_name}
tar xvf ${gz_file_name}
cd ${version}
./jetbrains-toolbox
cd ..
rm -rf ${gz_file_name}
rm -rf ${version}

echo "Installed JetBrains Toolbox App."
