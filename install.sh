#!/usr/bin/env bash

###############################################################################
# Ian R. O'Brien
# https://gitlab.com/ianrobrien/development-configurations.git
#
#
# Usage: ./configure-ubuntu.sh
###############################################################################

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Default Applications
apt update && apt install -y \
                vim \
                filezilla thunderbird \
                htop gdebi \
                gnome-tweak-tool fonts-firacode \
                git docker.io

# Manual Applications
${PWD}/application-installation-scripts/install-visual-studio-code.sh
${PWD}/application-installation-scripts/install-beyond-compare.sh
${PWD}/application-installation-scripts/install-intellij-idea.sh

## Dot Files
${PWD}/install-dot-files.sh

## Cosmetics
${PWD}/gnome-settings/install-capitaine-cursors.sh
${PWD}/gnome-settings/install-arc-gtk-theme.sh
${PWD}/gnome-settings/install-papirus-icon-theme.sh
