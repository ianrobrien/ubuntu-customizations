#!/usr/bin/env bash

###############################################################################
# Ian R. O'Brien
# https://gitlab.com/ianrobrien/development-configurations.git
#
#
# Usage: ./install.sh
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
                fonts-firacode \
                git docker.io

# Manual Applications
if ! [[ -x `(command -v code)` ]]; then
    ${PWD}/application-installation-scripts/install-visual-studio-code.sh
fi
if ! [[ -x `(command -v bcompare)` ]]; then
    ${PWD}/application-installation-scripts/install-beyond-compare.sh
fi
if ! [[ -x `(command -v idea)` ]]; then
    ${PWD}/application-installation-scripts/install-intellij-idea.sh
fi

# Appearances
${PWD}/gnome-settings/install-capitaine-cursors.sh
${PWD}/gnome-settings/install-papirus-icon-theme.sh

# # Desktop Configuration
# current_desktop=`(echo $DESKTOP_SESSION)`
# echo "Performing ${current_desktop} customizations"
# case ${current_desktop} in
#     "KDE")
#         ;;
#     "ubuntu")        
         ${PWD}/gnome-settings/install-arc-gtk-theme.sh
         ${PWD}/gnome-settings/load-gnome-terminal-settings.sh
         sudo apt install -y gnome-tweak-tool
#         ;;
# esac
