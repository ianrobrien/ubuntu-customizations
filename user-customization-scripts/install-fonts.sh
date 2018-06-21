#!/usr/bin/env bash

###############################################################################
# Ian R. O'Brien
# https://gitlab.com/ianrobrien/ubuntu-customizations
#
# This script installs the capitaine-cursors mouse cursors theme into the
# current user's home directory, and enables it in gsettings
#
# Usage: ./install-fonts.sh
###############################################################################
echo "Installing fonts..."

font_source_dir=${PWD}/extras/fonts/RobotoCondensed-Regular.ttf
font_target_dir=${HOME}/.local/share/fonts

# Install Roboto from repository
echo ${font_target_dir}
mkdir -p ${font_target_dir}
cp ${font_source_dir} ${font_target_dir}
fc-cache -f -v

gsettings set "org.gnome.desktop.wm.preferences" "titlebar-font" "Roboto Condensed, 13"
gsettings set "org.gnome.desktop.interface" "font-name" "Roboto Condensed, 12"
gsettings set "org.gnome.desktop.interface" "document-font-name" "Sans 11"

echo "Installed fonts."
