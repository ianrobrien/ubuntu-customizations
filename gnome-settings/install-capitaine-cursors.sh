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

# Constants
theme_name="capitaine-cursors"
target="${HOME}/.icons/capitaine-cursors"
temp="${PWD}/.${theme_name}"
source="${temp}/dist"
repo_location="https://github.com/keeferrourke/capitaine-cursors.git"
gsettings_schema="org.gnome.desktop.interface"
gsettings_key="cursor-theme"

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
gsettings set ${gsettings_schema} ${gsettings_key} ${theme_name}

echo "Finished installing ${theme_name}"