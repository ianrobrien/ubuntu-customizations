#!/usr/bin/env bash
#
# Ian R. O'Brien
# https://gitlab.com/ianrobrien/ubuntu-customizations
#
#
# Usage: ./install-flatpak-apps.sh

# User Check
if [[ $EUID -ne 0 ]]; then
   echo 'This script must be run as root' 1>&2
   exit 1
fi

# Get the current user
[ $SUDO_USER ] && user=$SUDO_USER || user=`whoami`

# Constants
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

sudo add-apt-repository ppa:alexlarsson/flatpak
sudo apt update
sudo apt install flatpak

# Visual Studio Code
flatpak install flathub com.visualstudio.code
flatpak run com.visualstudio.code

# Spotify
flatpak install flathub com.spotify.Client

# LibreOffice
flatpak install flathub org.libreoffice.LibreOffice