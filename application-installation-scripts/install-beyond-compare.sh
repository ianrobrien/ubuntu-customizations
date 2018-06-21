#!/usr/bin/env bash
#
# Ian R. O'Brien
# https://gitlab.com/ianrobrien/ubuntu-customizations
#
#
# Usage: ./install-beyond-compare.sh

# User Check
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Constants
version="4.2.5.23088"
architecture="amd64"
package_name="bcompare-${version}_${architecture}.deb"

echo "********************************************************************************"
echo "Installing Beyond Compare..."

wget http://www.scootersoftware.com/${package_name}
gdebi -n ${package_name}
rm ${package_name}

echo "Installed Beyond Compare."
echo "********************************************************************************"
