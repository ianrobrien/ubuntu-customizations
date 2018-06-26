#!/usr/bin/env bash
#
# Ian R. O'Brien
# https://gitlab.com/ianrobrien/ubuntu-customizations
#
# Usage: ./configure-gnome.sh

# Constants
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Global variables
mode=global

# Checks for root
if [[ $UID -ne 0 ]]; then
    echo "The script must be run as root to install in /usr/system/."
    while true; do
        read -r -p "Do you want to continue in local mode? [y/n] " answer
        case $answer in
            [Yy]* )
                mode=local; break;;
            [Nn]* ) exit;;
            * ) echo "Please answer [Y/y]es or [N/n]o.";;
        esac
    done
fi

echo "Running configure-gnome in ${mode} mode"

# themes

