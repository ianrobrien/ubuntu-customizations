#!/usr/bin/env bash
#
# Ian R. O'Brien
# https://gitlab.com/ianrobrien/ubuntu-customizations
#
# Sections are organized by Gnome Tweak Tool settings and Gnome Settings
# How to find setting: gsettings list-recursively | grep ${WALLPAPER_NAME}
# Usage: ./configure-gnome.sh

# Constants

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CUSTOMIZATION_SCRIPTS_DIR=${DIR}/user-customization-scripts/
EXTRAS_DIR=${DIR}/extras/
WALLPAPER_SOURCE_DIR=${EXTRAS_DIR}wallpaper/
WALLPAPER_TARGET_DIR=${HOME}/Pictures/Wallpapers/
WALLPAPER_NAME='trolltunga-1920x1200.jpg'

echo '********************************************************************************'
echo 'Customizing gnome...'

# Appearance

## Theme

${CUSTOMIZATION_SCRIPTS_DIR}install-mcos-themes.sh

## Cursors

${CUSTOMIZATION_SCRIPTS_DIR}install-capitaine-cursors.sh

## Fonts

${CUSTOMIZATION_SCRIPTS_DIR}install-fonts.sh

## Background and Lockscreen Image

mkdir -p ${WALLPAPER_TARGET_DIR}
cp ${WALLPAPER_SOURCE_DIR}${WALLPAPER_NAME} ${WALLPAPER_TARGET_DIR}
gsettings set org.gnome.desktop.background picture-uri "file://${WALLPAPER_TARGET_DIR}${WALLPAPER_NAME}"
gsettings set org.gnome.desktop.screensaver picture-uri "file://${WALLPAPER_TARGET_DIR}${WALLPAPER_NAME}"

# Application Settings

${CUSTOMIZATION_SCRIPTS_DIR}load-gnome-terminal-settings.sh
gsettings set org.gnome.shell.extensions.dash-to-dock click-action minimize

echo 'Customized gnome.'
echo '********************************************************************************'
