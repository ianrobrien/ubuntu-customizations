#!/usr/bin/env bash

###############################################################################
# Ian R. O'Brien
# https://gitlab.com/ianrobrien/ubuntu-customizations
#
#
# Usage: ./install-neofetch.sh
###############################################################################
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

repo_location="https://github.com/dylanaraps/neofetch.git"
repo_name="neofetch"

git clone ${repo_location} ${HOME}/.local/share
