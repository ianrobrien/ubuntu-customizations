#!/usr/bin/env bash

###############################################################################
# Ian R. O'Brien
# https://gitlab.com/ianrobrien/ubuntu-customizations
#
# This script installs the capitaine-cursors mouse cursors theme into the
# current user's home directory, and enables it in gsettings
#
# Usage: ./install-McOS-MJV-Dark-mode.sh
###############################################################################
# Constants
repo_location="https://github.com/paullinuxthemer/Mc-OS-themes.git"
repo_name="Mc-OS-themes"
repo_dir="${PWD}/.${repo_name}/"

theme_name_application="McOS-MJV"
dark_mode="-Dark-mode"
source_dir_application_theme=${repo_dir}${theme_name_application}
target_dir_application_theme="${HOME}/.themes/${theme_name_application}"

theme_name_shell="McOS-Dark-Shell"
source_dir_shell_theme=${repo_dir}McOS-Shell-themes/${theme_name_shell}
target_dir_shell_theme="${HOME}/.themes/${theme_name_shell}"

echo "Installing ${theme_name_application}..."

# clone repo
rm -rf ${repo_dir}
git clone ${repo_location} ${repo_dir}

# Install Application Theme (Light)
rm -rf ${target_dir_application_theme}
mkdir -p ${target_dir_application_theme}
cp -r ${source_dir_application_theme}/* ${target_dir_application_theme}

# Install Application Theme (Dark)
rm -rf ${target_dir_application_theme}${dark_mode}
mkdir -p ${target_dir_application_theme}${dark_mode}
cp -r ${source_dir_application_theme}${dark_mode}/* ${target_dir_application_theme}${dark_mode}

# Install Shell Theme
rm -rf ${target_dir_shell_theme}
mkdir -p ${target_dir_shell_theme}
cp -r ${source_dir_shell_theme}/* ${target_dir_shell_theme}

echo "Deleting ${repo_name} repository"
rm -rf ${repo_dir}

echo "Setting ${theme_name} as current theme"
gsettings set org.gnome.desktop.wm.preferences theme ${theme_name_application}${dark_mode}
gsettings set org.gnome.desktop.interface gtk-theme ${theme_name_application}${dark_mode}
#gsettings set org.gnome.shell.extensions.user-theme name McOS-Dark-Shell

echo "Installed ${theme_name_application}."
echo "*** REMEMBER TO FIX FIREFOX: about:config [widget.content.gtk-theme-override | McOS-MJV] ***"