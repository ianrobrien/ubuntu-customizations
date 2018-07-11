#!/usr/bin/env bash
#
# Ian R. O'Brien
# https://gitlab.com/ianrobrien/ubuntu-customizations
#
#
# Usage: ./install-jetbrains-toolbox-app.sh

# Get the current user
[ $SUDO_USER ] && user=$SUDO_USER || user=`whoami`
TARGET_HOME="/home/${user}"

# Constants
version="jetbrains-toolbox-1.8.3868"
gz_file_name="${version}.tar.gz"
install_target="${TARGET_HOME}/.local/share/"

echo "********************************************************************************"
echo "Installing JetBrains Toolbox App..."

wget https://download.jetbrains.com/toolbox/${gz_file_name}
tar xvf ${gz_file_name}
cd ${version}
./jetbrains-toolbox
cd ..
rm -rf ${gz_file_name}
rm -rf ${version}

echo "Installed JetBrains Toolbox App."
echo "********************************************************************************"
