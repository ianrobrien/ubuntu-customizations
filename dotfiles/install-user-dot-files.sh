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
source="${DIR}"

echo "********************************************************************************"
echo "Copying dot files to home directory..."

# Copy over single files (TODO: loop)
declare -a link_targets=(
  ".bash_aliases"
  ".bashrc"
  ".bin"
  ".config/Code/User/settings.json"
  ".config/neofetch"  
  ".profile"
  ".inputrc"
  ".vim"
  ".vimrc"
)

for target in "${link_targets[@]}"
do
  unlink ${HOME}/${target}
  ln -sf ${source}/${target} ${HOME}/${target}
  chown -R ${user}: ${HOME}/${target}
done

declare -a copy_targets=(
  ".gitconfig"
)

for target in "${copy_targets[@]}"
do
  cp ${source}/${target} ${HOME}/${target}
  chown -R ${user}: ${HOME}/${target}
done

echo "Finished copying dot files to home directory."
echo "Sourcing .bashrc to pick up latest changes."
source ~/.bashrc
echo "Finished installing dot files."
echo "********************************************************************************"
