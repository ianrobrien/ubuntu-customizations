# This script will set up profile variables for ZSH
# Destination Variables for profile files
profile="$HOME/.profile"
profile_bak="${profile}.bak"
profile_d="$HOME/.profile.d"
profile_d_bak="${profile_d}.bak"
zshrc="$HOME/.zshrc"
zshrc_bak="${zshrc}.bak"

# Delete all backups
echo "Deleting all profile backups and folders"
if [ -d ${profile_d_bak} ]; then
  rm -rf ${profile_d_bak}
fi
if [ -f ${profile_bak} ]; then
  rm ${profile_bak}
fi

# .profile ###############################################
if [ -f "${profile}" ]; then
  echo "${profile} exists. Creating backup ${profile_bak}"
  mv ${profile} ${profile_bak}
fi
# copy new .profile
cp ./scripts/.profile ${profile}
echo "Successfuly wrote ./scripts/.profile to ${profile}"
#########################################################

# ZSHRC ##################################################
if [ -f "${zshrc}" ]; then
  echo "${zshrc} exists. Creating backup ${zshrc_bak}"
  mv ${zshrc} ${zshrc_bak}
fi
# copy new .profile
cp ./scripts/.zshrc ${zshrc}
echo "Successfuly wrote ./scripts/.zshrc to ${zshrc}"
#########################################################

# .profile.d ##################################################################
if [ -d "${profile_d}" ]; then
  echo "${profile_d} directory exists. Creating backup ${profile_d_bak}"
  mv ${profile_d} ${profile_d_bak}
fi
mkdir ${profile_d}
cp -a ./scripts/profile.d/* ${profile_d}
echo "Successfuly wrote .scripts/profile.d/* to ${profile_d}"
###############################################################################

echo "Done setting up ZSH profile."
