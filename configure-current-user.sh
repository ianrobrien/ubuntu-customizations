#!/usr/bin/env bash

###############################################################################
# Ian R. O'Brien
# https://gitlab.com/ianrobrien/ubuntu-customizations
#
# Sections are organized by Gnome Tweak Tool settings and Gnome Settings
# How to find setting: gsettings list-recursively | grep ${wallpaper_name}
# Usage: ./configure-current-user.sh
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
gnome_customization_scripts=${PWD}/user-customization-scripts/
wallpaper_name="trolltunga-1920x1200.jpg"

# Appearance
${gnome_customization_scripts}install-McOS-MJV-Dark-mode.sh
${gnome_customization_scripts}install-capitaine-cursors.sh
${gnome_customization_scripts}install-fonts.sh

## Background and Lockscreen Image
mkdir -p ${wallpaper_target_dir}
cp ${wallpaper_source_dir}${wallpaper_name} ${wallpaper_target_dir}
gsettings set "org.gnome.desktop.background" "picture-uri" "file://${wallpaper_target_dir}${wallpaper_name}"
gsettings set "org.gnome.desktop.screensaver" "picture-uri" "file://${wallpaper_target_dir}${wallpaper_name}"

# Application Settings
${gnome_customization_scripts}load-gnome-terminal-settings.sh
gsettings set "org.gnome.shell.extensions.dash-to-dock" "click-action" "minimize"

# To Do:
## Splash Screen
## Login Screen
## Grub Theme

${PWD}/dotfiles/install-user-dot-files.sh

echo "Customized gnome."
