#!/usr/bin/env bash

###############################################################################
# Ian R. O'Brien
# https://gitlab.com/ianrobrien/ubuntu-customizations
#
# This script installs the capitaine-cursors mouse cursors theme into the
# current user's home directory, and enables it in gsettings
#
# How to save settings
#   dconf dump /org/gnome/terminal/ > ${PWD}/../application-settings/gnome-terminal/gnome-terminal-settings-backup.txt
#
# Usage: ./install-capitaine-cursors.sh
###############################################################################
echo "Loading gnome-terminal application settings..."

dconf load /org/gnome/terminal/ < ${PWD}/application-settings/gnome-terminal/gnome-terminal-settings-backup.txt

echo "Loaded gnome-terminal application settings."
