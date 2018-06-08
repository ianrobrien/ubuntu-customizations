#!/usr/bin/env bash

###############################################################################
# Ian R. O'Brien
# https://gitlab.com/ianrobrien/development-configurations.git
#
#
# Usage: ./configure-ubuntu.sh
###############################################################################

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

wget http://www.scootersoftware.com/bcompare-4.2.4.22795_amd64.deb
gdebi -n bcompare-4.2.4.22795_amd64.deb
rm bcompare-4.2.4.22795_amd64.deb