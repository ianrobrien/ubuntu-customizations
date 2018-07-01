#!/usr/bin/env bash
#
# Ian R. O'Brien
# https://gitlab.com/ianrobrien/ubuntu-customization
#
# This script installs the capitaine-cursors mouse cursors theme into the
# current user's home directory, and enables it in gsettings
#
# Usage: ./install-capitaine-cursors.sh

# Get the current user
[ $SUDO_USER ] && user=$SUDO_USER || user=`whoami`

# Constants
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SOURCE=${DIR}/dotfiles/

echo '********************************************************************************'
echo 'Copying dot files to home directory...'

# Copy over single files (TODO: loop)
declare -a LINK_TARGETS=(
  '.bash_aliases'
  '.bashrc'
  '.bin'
  #'.config/Code/User/settings.json'   
  '.var/app/com.visualstudio.code/config/Code/User/settings.json'
  '.config/neofetch" '
  '.profile'
  '.inputrc'
  '.vim'
  '.vimrc'
)

for target in "${LINK_TARGETS[@]}"
do
  unlink ${HOME}/${target}
  ln -sf ${SOURCE}${target} ${HOME}/${target}
  chown -R ${user}: ${HOME}/${target}
done

declare -a COPY_TARGETS=(
  '.gitconfig'
)

for target in "${COPY_TARGETS[@]}"
do
  cp ${SOURCE}${target} ${HOME}/${target}
  chown -R ${user}: ${HOME}/${target}
done

echo 'Finished copying dot files to home directory.'
echo 'Sourcing .bashrc to pick up latest changes.'
source ~/.bashrc

echo 'Finished installing dot files.'
echo '********************************************************************************'
