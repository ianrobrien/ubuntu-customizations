#!/usr/bin/env bash
#
# Ian R. O'Brien
# https://gitlab.com/ianrobrien/ubuntu-customizations
#
# This script installs the capitaine-cursors mouse cursors theme into the
# current user's home directory, and enables it in gsettings
#
# Usage: ./install-McOS-MJV-Dark-mode.sh

# Get the current user
[ $SUDO_USER ] && user=$SUDO_USER || user=`whoami`
themes_dir="/usr/share/themes/"

# Checks for root
if [[ $UID -ne 0 ]]; then
    echo "The script must be run as root to install in /usr/system/themes/."
    while true; do
        read -r -p "Do you want to continue in local mode?" answer
        case $answer in
            [Yy]* )
                themes_dir="/home/${user}/.themes/"; break;;
            [Nn]* ) exit;;
            * ) echo "Please answer [Y/y]es or [N/n]o.";;
        esac
    done
fi

echo "Installing themes into: ${themes_dir}"

# Constants
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
repo_url="https://github.com/ianrobrien/mc-os-themes.git"
repo_name="mc-os-themes"
repo_dir="${DIR}/.${repo_name}/"

selected_theme="McOS-MJV-dark"

echo "********************************************************************************"
echo "Installing ${selected_theme}..."

# clone repo
rm -rf ${repo_dir}
git clone ${repo_url} ${repo_dir}

themes=("Gnome-Mc-OS-YS-light-menu"
        "Gnome-Mc-OS-YS-light-menu-transparent"
        "McOS-HS"
        "McOS-HS-light-menu"
        "McOS-HS-light-menu-transparent"
        "McOS-HS-transparent"
        "McOS-MJV"
        "McOS-MJV-dark"
        "McOS-shell-dark"
        "McOS-shell-light"
        "McOS-shell-space-grey"
        "McOS-space-grey"
        "McOS-space-grey-transparent"
        "McOS-YS"
        "McOS-YS-transparent")
for theme in "${themes[@]}"
do
    echo "Deleting theme at: ${themes_dir}${theme}"
    rm -rf ${themes_dir}${theme}
    echo "Copying theme from: ${repo_dir}${theme} to ${themes_dir}"
    cp -R ${repo_dir}${theme} ${themes_dir}
done

echo "Setting ${theme_name} as current theme"
gsettings set org.gnome.desktop.wm.preferences theme ${selected_theme}
gsettings set org.gnome.desktop.interface gtk-theme ${selected_theme}
#gsettings set org.gnome.shell.extensions.user-theme name McOS-Dark-Shell

rm -rf ${repo_dir}

echo "Installed ${selected_theme}."
echo "*** REMEMBER TO SET THE SHELL THEME TO McOS-Dark-Shell ***"
echo "*** REMEMBER TO FIX FIREFOX: about:config [widget.content.gtk-theme-override | McOS-MJV] ***"
echo "********************************************************************************"
