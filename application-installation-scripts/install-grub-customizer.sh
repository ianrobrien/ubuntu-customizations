#!/usr/bin/env bash
#
# Ian R. O'Brien
# https://gitlab.com/ianrobrien/ubuntu-customizations
#
#
# Usage: ./install-grub-customizer

# User Check
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

echo "********************************************************************************"
echo "Installing Grub Customizer..."

sudo add-apt-repository ppa:danielrichter2007/grub-customizer
sudo apt-get update
sudo apt-get install grub-customizer

echo "Installed Grub Customizer."
echo "********************************************************************************"
