#!/usr/bin/env bash
#
# Ian R. O'Brien
# https://gitlab.com/ianrobrien/ubuntu-customization
#
# This script installs the dot files into the users home directory
#
# Usage: ./install-dot-files.sh

# Get the current user
[ $SUDO_USER ] && user=$SUDO_USER || user=`whoami`

# Constants
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SOURCE=${DIR}/dotfiles/
TARGET_HOME="/home/${user}"

echo '********************************************************************************'
echo 'Copying dot files to home directory...'

# Create links to versioned dotfiles
declare -a LINK_TARGETS=(
  '.bash_aliases'
  '.bashrc'
  '.bin'
  '.var/app/com.visualstudio.code/config/Code/User/settings.json'
  '.config/neofetch'
  '.profile'
  '.inputrc'
  '.vim'
  '.vimrc'
)

for target in "${LINK_TARGETS[@]}"
do
  if [ -L $mda ]; then
    unlink ${TARGET_HOME}/${target}
  fi
  ln -sf ${SOURCE}${target} ${TARGET_HOME}/${target}
  chown -R ${user}: ${TARGET_HOME}/${target}
done

# Copy over any files that should not be linked
# declare -a COPY_TARGETS=(
#   '.gitconfig'
# )

# for target in "${COPY_TARGETS[@]}"
# do
#   cp ${SOURCE}${target} ${TARGET_HOME}/${target}
#   chown -R ${user}: ${TARGET_HOME}/${target}
# done

# Copy over gitconfig
while true; do
    read -r -p 'Do you want to copy over the gitconfig file? [y/n]: ' answer
    case $answer in
        [Yy]* )
            cp "${SOURCE}.gitconfig" "${TARGET_HOME}/.gitconfig"
            chown -R ${user}: "${TARGET_HOME}/.gitconfig"
            break;;
        [Nn]* )
            break;;
        * ) echo 'Please answer [Y/y]es or [N/n]o.';;
    esac
done

echo 'Finished copying dot files to home directory.'
echo 'Sourcing .bashrc to pick up latest changes.'
source ~/.bashrc

echo 'Finished installing dot files.'
echo '********************************************************************************'
