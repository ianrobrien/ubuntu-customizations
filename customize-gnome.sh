#!/usr/bin/env bash

###############################################################################
# Ian R. O'Brien
# https://gitlab.com/ianrobrien/ubuntu-customizations
#
# Sections are organized by Gnome Tweak Tool settings and Gnome Settings
# How to find setting: gsettings list-recursively | grep ${wallpaper_name}
# Usage: ./install.sh
###############################################################################
if [[ $EUID = 0 ]]
  then echo "Please run this script without sudo permissions"
  exit
fi

echo "Customizing gnome..."

# Constants
extras_dir=${PWD}/extras/
wallpaper_source_dir=${extras_dir}wallpaper/
wallpaper_target_dir=${HOME}/Pictures/Wallpapers/
gnome_install_scripts=${PWD}/user-customization-scripts/
wallpaper_name="trolltunga-1920x1200.jpg"

# Appearance
## Application and Shell Theme
${gnome_install_scripts}install-McOS-MJV-Dark-mode.sh
## Cursors
${gnome_install_scripts}install-capitaine-cursors.sh
# Fonts
${gnome_install_scripts}install-fonts.sh
## Background and Lockscreen Image
mkdir -p ${wallpaper_target_dir}
cp ${wallpaper_source_dir}${wallpaper_name} ${wallpaper_target_dir}
gsettings set "org.gnome.desktop.background" "picture-uri" "file://${wallpaper_target_dir}${wallpaper_name}"
gsettings set "org.gnome.desktop.screensaver" "picture-uri" "file://${wallpaper_target_dir}${wallpaper_name}"

# Application Settings
${gnome_install_scripts}load-gnome-terminal-settings.sh

# General Gnome Settings
gsettings set "org.gnome.shell.extensions.dash-to-dock" "click-action" "minimize"

# To Do:
## Splash Screen
## Login Screen
## Grub Theme

echo "Customized gnome."
