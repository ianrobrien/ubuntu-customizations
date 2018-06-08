#!/usr/bin/env bash

###############################################################################
# Ian R. O'Brien
# https://gitlab.com/ianrobrien/development-configurations.git
#
# This script installs the capitaine-cursors mouse cursors theme into the
# current user's home directory, and enables it in gsettings
#
# Usage: ./install-capitaine-cursors.sh
###############################################################################

dconf load /org/gnome/terminal/ < ${PWD}/../application-settings/gnome-terminal/gnome-terminal-settings-backup.txt