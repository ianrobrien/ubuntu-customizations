#!/usr/bin/env bash
#
# Ian R. O'Brien
# https://gitlab.com/ianrobrien/ubuntu-customizations
#
#
# Usage: ./install-neofetch.sh

# Constants
REPO_NAME="neofetch"
REPO_URL="https://github.com/dylanaraps/${REPO_NAME}.git"

# User Check
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

echo "This script isn't yet completed. Exiting..."
exit 1


git clone ${REPO_URL} ${HOME}/.local/share
