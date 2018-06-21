#!/usr/bin/env bash
#
# Ian R. O'Brien
# https://gitlab.com/ianrobrien/ubuntu-customizations
#
# This script installs the capitaine-cursors mouse cursors theme into the
# current user's home directory, and enables it in gsettings
#
# Usage: ./install-capitaine-cursors.sh

# User Check
if [[ $EUID = 0 ]]
  then echo "Please run this script without sudo permissions"
  exit
fi

# Constants
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

theme_name="capitaine-cursors"
target="${HOME}/.icons/capitaine-cursors"
temp="${DIR}/.${theme_name}"
source="${temp}/dist"
repo_location="https://github.com/keeferrourke/capitaine-cursors.git"

echo "********************************************************************************"
echo "Installing ${theme_name}..."

if [[ -d "${target}" ]]; then
  echo "Deleting previous installation at ${target}"
  rm -rf ${target}
fi

if [[ -d "${temp}" ]]; then
  echo "Deleting previous temp directory ${temp}"
  rm -rf ${temp}
fi

echo "Making target directory ${target}"
mkdir -p ${target}

echo "Cloning ${theme_name} repository into ${temp}"
git clone ${repo_location} ${temp}

echo "Copying theme from ${source} to ${target}"
cp -r ${source}/* ${target}

echo "Deleting ${theme_name} repository"
rm -rf ${temp}

echo "Setting ${theme_name} as current theme"
gsettings set "org.gnome.desktop.interface" "cursor-theme" ${theme_name}

echo "Installed ${theme_name}."
echo "********************************************************************************"
