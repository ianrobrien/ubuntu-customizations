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

# Constants
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
REPO_LOCATION="https://github.com/keeferrourke/capitaine-cursors.git"
THEME_NAME="capitaine-cursors"
GLOBAL_TARGET="/usr/system/icons/"
LOCAL_TARGET="/home/${user}/.icons/"

# Check for root
mode="local"
if [[ $UID -eq 0 ]]; then
    echo "Sudo permissions detected."
    while true; do
        read -r -p "Do you want to install the theme into ${GLOBAL_TARGET}? [y/n]: " answer
        case $answer in
            [Yy]* )
                mode="global"; break;;
            [Nn]* )            
                break;;
            * ) echo "Please answer [Y/y]es or [N/n]o.";;
        esac
    done
fi

# Variables
## Set variables based on mode
icons_dir=""
if [ "${mode}" == "global" ]; then
    icons_dir=${GLOBAL_TARGET}
elif [ "${mode}" == "local" ]; then
    icons_dir=${LOCAL_TARGET}
else
    echo "An unexpected error has occurred. The script will now exit."
    exit 1
fi
target="${icons_dir}capitaine-cursors"
temp="${DIR}/.${THEME_NAME}"
source="${temp}/dist"

echo "********************************************************************************"
echo "Installing ${THEME_NAME}..."

if [[ -d "${temp}" ]]; then
  echo "Deleting previous temp directory ${temp}"
  rm -rf ${temp}
fi

echo "Cloning ${THEME_NAME} repository into ${temp}"
git clone ${REPO_LOCATION} ${temp}

if [[ -d "${target}" ]]; then
  echo "Deleting previous installation at ${target}"
  rm -rf ${target}
fi

echo "Making target directory ${target}"
mkdir -p ${target}

echo "Copying theme from ${source} to ${target}"
cp -r ${source}/* ${target}
chown -R ${user}: ${target} 

echo "Deleting ${THEME_NAME} repository"
rm -rf ${temp}

echo "Setting ${THEME_NAME} as current theme"
gsettings set org.gnome.desktop.interface cursor-theme ${THEME_NAME}

echo "Installed ${THEME_NAME}."
echo "********************************************************************************"
