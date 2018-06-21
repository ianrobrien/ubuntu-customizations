#!/usr/bin/env bash
#
# Ian R. O'Brien
# https://gitlab.com/ianrobrien/ubuntu-customizations
#
# Usage: ./install-system-applications.sh

# User Check
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Constants
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Applications
sudo apt update && apt install -y \
    vim \
    filezilla thunderbird libreoffice keepassxc \
    htop gdebi \
    git docker.io openjdk-11-jre openjdk-11-jdk openjdk-8-jdk openjdk-8-jre \
    gnome-tweak-tool gnome-system-monitor gnome-calculator pinta \
    fortunes cowsay lolcat papirus-icon-theme fonts-firacode

# Application Settings
gsettings set "org.gnome.desktop.interface" "icon-theme" "Papirus"
gsettings set "org.gnome.desktop.interface" "monospace-font-name" "Fira Code 12"

# Manual Applications
if ! [[ -x `(command -v code)` ]]; then
    ${DIR}/application-installation-scripts/install-visual-studio-code.sh
fi
if ! [[ -x `(command -v bcompare)` ]]; then
    ${DIR}/application-installation-scripts/install-beyond-compare.sh
fi
if ! [[ -x `(command -v grub-customizer)` ]]; then
    ${DIR}/application-installation-scripts/install-grub-customizer.sh
fi
if ! [[ -x `(command -v idea)` ]]; then
    ${DIR}/application-installation-scripts/install-jetbrains-toolbox-app.sh
fi

To Do (Probably in system settings)
# Splash Screen
# Login Screen
# Grub Theme
