#!/usr/bin/env bash

###############################################################################
# Ian R. O'Brien
# https://gitlab.com/ianrobrien/ubuntu-customizations
#
#
# How to save settings
#   dconf dump /org/gnome/terminal/ > ${PWD}/../application-settings/gnome-terminal/gnome-terminal-settings-backup.txt
#
# Usage: ./load-gnome-terminal-settings.sh
###############################################################################
echo "Loading gnome-terminal application settings..."

dconf load /org/gnome/terminal/ < ${PWD}/application-settings/gnome-terminal/gnome-terminal-settings-backup.txt

echo "Loaded gnome-terminal application settings."
