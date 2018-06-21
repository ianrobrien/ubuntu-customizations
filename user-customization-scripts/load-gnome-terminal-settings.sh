#!/usr/bin/env bash
#
# Ian R. O'Brien
# https://gitlab.com/ianrobrien/ubuntu-customizations
#
#
# How to save settings
#   dconf dump /org/gnome/terminal/ > gnome-terminal-settings-backup.txt
#
# Usage: ./load-gnome-terminal-settings.sh

# User Check
if [[ $EUID = 0 ]]
  then echo "Please run this script without sudo permissions"
  exit
fi

# Constants
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "********************************************************************************"
echo "Loading gnome-terminal application settings..."

dconf load /org/gnome/terminal/ < ${DIR}/../application-settings/gnome-terminal.txt

echo "Loaded gnome-terminal application settings."
echo "********************************************************************************"
