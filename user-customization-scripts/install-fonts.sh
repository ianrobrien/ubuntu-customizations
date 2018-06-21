#!/usr/bin/env bash
#
# Ian R. O'Brien
# https://gitlab.com/ianrobrien/ubuntu-customizations
#
# This script installs the capitaine-cursors mouse cursors theme into the
# current user's home directory, and enables it in gsettings
#
# Usage: ./install-fonts.sh

# Get the current user
[ $SUDO_USER ] && user=$SUDO_USER || user=`whoami`

# Constants
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
font_name="RobotoCondensed-Regular.ttf"
font_source_dir=${DIR}/../extras/fonts/${font_name}
font_target_dir=${HOME}/.local/share/fonts/

echo "********************************************************************************"
echo "Installing fonts..."

if [ ! -f ${font_target_dir}${font_name} ]; then
    mkdir -p ${font_target_dir}
    cp ${font_source_dir}${font_name} ${font_target_dir}
    chown -R ${user}: ${font_target_dir}
    fc-cache -f -v
fi

gsettings set org.gnome.desktop.wm.preferences titlebar-font "Roboto Condensed, 13"
gsettings set org.gnome.desktop.interface font-name "Roboto Condensed, 12"
gsettings set org.gnome.desktop.interface document-font-name "Sans 11"

echo "Installed fonts."
echo "********************************************************************************"
