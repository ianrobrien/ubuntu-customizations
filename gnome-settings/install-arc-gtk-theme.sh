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

if [[ $EUID > 0 ]]
  then echo "Please run as root"
  exit
fi

apt install -y vim arc-theme
gsettings set org.gnome.desktop.interface gtk-theme "Arc"