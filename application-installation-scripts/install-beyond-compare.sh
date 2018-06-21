#!/usr/bin/env bash

###############################################################################
# Ian R. O'Brien
# https://gitlab.com/ianrobrien/ubuntu-customizations
#
#
# Usage: ./configure-ubuntu.sh
###############################################################################
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

echo "Installing Beyond Compare..."

version="bcompare-4.2.5.23088_amd64.deb"

wget http://www.scootersoftware.com/${version}
gdebi -n ${version}
rm ${version}

echo "Installed Beyond Compare."
