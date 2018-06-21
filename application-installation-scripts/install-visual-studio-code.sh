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

echo "Installing VS Code..."

curl -sSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | apt-key add -
echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list
apt update && apt install -y code

target="${HOME}/.config/Code/User"
mkdir -p ${target}
cp "${PWD}/../application-settings/vscode/settings.json" ${target}

echo "Installed VS Code."
