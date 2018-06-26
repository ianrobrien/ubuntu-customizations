#!/usr/bin/env bash
#
# Ian R. O'Brien
# https://gitlab.com/ianrobrien/ubuntu-customizations
#
# This script installs the capitaine-cursors mouse cursors theme into the
# current user's home directory, and enables it in gsettings
#
# Usage: ./install-McOS-MJV-Dark-mode.sh

# User Variables
SELECTED_THEME='McOS-MJV-dark'
REPO_NAME='mc-os-themes'

# Get the current user
[ $SUDO_USER ] && user=$SUDO_USER || user=`whoami`

# Constants
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
REPO_URL="https://github.com/ianrobrien/${REPO_NAME}.git"
GLOBAL_TARGET='/usr/share/themes/'
LOCAL_TARGET="/home/${user}/.themes"

# Check for root
mode='local'
if [[ $UID -eq 0 ]]; then
    echo 'Sudo permissions detected.'
    while true; do
        read -r -p 'Do you want to install the theme into /usr/system/themes/? [y/n]: ' answer
        case $answer in
            [Yy]* )
                mode='global'; break;;
            [Nn]* )            
                break;;
            * ) echo 'Please answer [Y/y]es or [N/n]o.';;
        esac
    done
fi

# Variables
themes_dir=''

# Set variables based on mode
if [ "${mode}" == 'global' ]; then
    themes_dir=${GLOBAL_TARGET}
elif [ "${mode}" == 'local' ]; then
    themes_dir=${LOCAL_TARGET}
else
    echo 'An unexpected error has occurred. The script will now exit.'
    exit 1
fi

# Constants
repo_dir="${DIR}/.${REPO_NAME}/"

echo '********************************************************************************'
echo "Installing ${SELECTED_THEME}..."
echo "Installing themes into: ${themes_dir}"

# clone repo
rm -rf ${repo_dir}
git clone ${REPO_URL} ${repo_dir}

themes=('Gnome-Mc-OS-YS-light-menu'
        'Gnome-Mc-OS-YS-light-menu-transparent'
        'McOS-HS'
        'McOS-HS-light-menu'
        'McOS-HS-light-menu-transparent'
        'McOS-HS-transparent'
        'McOS-MJV'
        'McOS-MJV-dark'
        'McOS-shell-dark'
        'McOS-shell-light'
        'McOS-shell-space-grey'
        'McOS-space-grey'
        'McOS-space-grey-transparent'
        'McOS-YS'
        'McOS-YS-transparent'
)
for theme in "${themes[@]}"
do
    echo "Deleting theme at: ${themes_dir}${theme}"
    rm -rf ${themes_dir}${theme}
    echo "Copying theme from: ${repo_dir}${theme} to ${themes_dir}"
    cp -R ${repo_dir}${theme} ${themes_dir}
done

echo "Setting ${theme_name} as current theme"
gsettings set org.gnome.desktop.wm.preferences theme ${SELECTED_THEME}
gsettings set org.gnome.desktop.interface gtk-theme ${SELECTED_THEME}
#gsettings set org.gnome.shell.extensions.user-theme name McOS-Dark-Shell

rm -rf ${repo_dir}

echo "Installed ${SELECTED_THEME}."
echo '*** REMEMBER TO SET THE SHELL THEME TO McOS-Dark-Shell ***'
echo '*** REMEMBER TO FIX FIREFOX: about:config [widget.content.gtk-theme-override | McOS-MJV] ***'
echo '********************************************************************************'
