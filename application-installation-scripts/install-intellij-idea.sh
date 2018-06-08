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

wget https://download.jetbrains.com/idea/ideaIC-2018.1.4.tar.gz
tar xvf ideaIC-2018.1.4.tar.gz
mv idea-IC-181.5087.20/ /home/ianrobrien/.local/share/
rm ideaIC-2018.1.4.tar.gz