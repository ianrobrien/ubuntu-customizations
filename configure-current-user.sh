#!/usr/bin/env bash
#
# Ian R. O'Brien
# https://gitlab.com/ianrobrien/ubuntu-customizations
#
# Sections are organized by Gnome Tweak Tool settings and Gnome Settings
# How to find setting: gsettings list-recursively | grep ${wallpaper_name}
# Usage: ./configure-current-user.sh

# User Check
if [[ $EUID = 0 ]]
  then echo "Please run this script without sudo permissions"
  exit
fi

# Constants
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

extras_dir=${DIR}/extras/
wallpaper_source_dir=${extras_dir}wallpaper/
wallpaper_target_dir=${HOME}/Pictures/Wallpapers/
customization_scripts_dir=${DIR}/user-customization-scripts/
wallpaper_name="trolltunga-1920x1200.jpg"

echo "********************************************************************************"
echo "Customizing gnome..."

# Appearance
${customization_scripts_dir}install-McOS-themes.sh
${customization_scripts_dir}install-capitaine-cursors.sh
${customization_scripts_dir}install-fonts.sh

## Background and Lockscreen Image
mkdir -p ${wallpaper_target_dir}
cp ${wallpaper_source_dir}${wallpaper_name} ${wallpaper_target_dir}
gsettings set "org.gnome.desktop.background" "picture-uri" "file://${wallpaper_target_dir}${wallpaper_name}"
gsettings set "org.gnome.desktop.screensaver" "picture-uri" "file://${wallpaper_target_dir}${wallpaper_name}"

# Application Settings
${customization_scripts_dir}load-gnome-terminal-settings.sh
gsettings set "org.gnome.shell.extensions.dash-to-dock" "click-action" "minimize"

${DIR}/dotfiles/install-user-dot-files.sh

if ! [[ -x `(command -v idea)` ]]; then
    ${DIR}/application-installation-scripts/install-jetbrains-toolbox-app.sh
fi

echo "Customized gnome."
echo "********************************************************************************"
