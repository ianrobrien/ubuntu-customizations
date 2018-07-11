#!/usr/bin/env bash
#
# Ian R. O'Brien
# https://gitlab.com/ianrobrien/ubuntu-customizations
#
# This script installs the fonts into the
# current user's home directory, and enables it in gsettings
#
# Usage: ./install-fonts.sh

# Get the current user
[ $SUDO_USER ] && user=$SUDO_USER || user=`whoami`
TARGET_HOME="/home/${user}"

# Constants
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
FONT_NAME='RobotoCondensed-Regular.ttf'
FONT_SOURCE_DIR=${DIR}/../extras/fonts/${FONT_NAME}
FONT_TARGET_DIR=${TARGET_HOME}/.local/share/fonts/

echo '********************************************************************************'
echo 'Installing fonts...'

if [ ! -f ${FONT_TARGET_DIR}${FONT_NAME} ]; then
    mkdir -p ${FONT_TARGET_DIR}
    cp ${FONT_SOURCE_DIR}${FONT_NAME} ${FONT_TARGET_DIR}
    chown -R ${user}: ${FONT_TARGET_DIR}
    fc-cache -f -v
fi

gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Roboto Condensed, 13'
gsettings set org.gnome.desktop.interface font-name 'Roboto Condensed, 12'
gsettings set org.gnome.desktop.interface document-font-name 'Sans 11'

# Set the monospace-font to firacode if it is installed
if [[ $(dpkg -l | grep fonts-firacode) ]]; then
    gsettings set org.gnome.desktop.interface monospace-font-name 'Fira Code 12'
fi

echo 'Installed fonts.'
echo '********************************************************************************'
