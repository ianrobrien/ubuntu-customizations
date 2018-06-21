#!/usr/bin/env bash
#
# Ian R. O'Brien
# https://gitlab.com/ianrobrien/ubuntu-customizations
#
#
# Usage: ./install-intellij-idea.sh

# Constants
version="jetbrains-toolbox-1.8.3868"
gz_file_name="${version}.tar.gz"
install_target="${HOME}/.local/share/"

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
