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

# Constants
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
repo_url="https://github.com/ianrobrien/mc-os-themes.git"
repo_name="mc-os-themes"
repo_dir="${DIR}/.${repo_name}/"
themes_dir="${HOME}/.themes/"

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
    rm -rf ${themes_dir}${theme}
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
