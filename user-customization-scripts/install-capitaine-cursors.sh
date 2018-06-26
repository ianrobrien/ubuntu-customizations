#!/usr/bin/env bash
#
# Ian R. O'Brien
# https://gitlab.com/ianrobrien/ubuntu-customizations
#
# This script installs the capitaine-cursors mouse cursors theme into the
# current user's home directory, and enables it in gsettings
#
# Usage: ./install-capitaine-cursors.sh

# Get the current user
[ $SUDO_USER ] && user=$SUDO_USER || user=`whoami`
icons_dir="/usr/share/icons/"

# Checks for root
if [[ $UID -ne 0 ]]; then
    echo "The script must be run as root to install in /usr/system/icons/."
    while true; do
        read -r -p "Do you want to continue in local mode?" answer
        case $answer in
            [Yy]* )
                icons_dir="/home/${user}/.icons/"; break;;
            [Nn]* ) exit;;
            * ) echo "Please answer [Y/y]es or [N/n]o.";;
        esac
    done
fi

# Constants
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

theme_name="capitaine-cursors"
target="${icons_dir}capitaine-cursors"
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
chown -R ${user}: ${target} 

echo "Deleting ${theme_name} repository"
rm -rf ${temp}

echo "Setting ${theme_name} as current theme"
gsettings set org.gnome.desktop.interface cursor-theme ${theme_name}

echo "Installed ${theme_name}."
echo "********************************************************************************"
