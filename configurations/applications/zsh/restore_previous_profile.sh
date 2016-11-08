# This script will set up profile variables for ZSH

# Destination Variables for profile files
profile_file=~/.profile
profile_bak_file=${profile_file}.bak

profile_d_dir=~/.profile.d
profile_d_bak_dir=${profile_d_dir}.bak

profile_d_src_dir=./profile/profile.d/.
profile_src_file=./profile/.profile

echo "Restoring previous profile..."

# copy over .profile (after backing it up) which will load everything else
if [ -f "$profile_file" ]; then
  echo "$profile_file exists. Deleting it prior to restoring ${profile_bak_file}"
  rm $profile_file
fi
if [ -f "$profile_bak_file" ]; then
  mv $profile_bak_file $profile_file
  echo "${profile_bak_file} successfully restored"
  rm $profile_bak_file
fi

# copy over .profile.d/ (after backing it up) which will load everything else
if [ -d "$profile_d_dir" ]; then
  echo "$profile_d_dir exists. Deleting it priror to restoring ${profile_bak_d_dir}"
  rm -rf $profile_d_dir/*
  cp -a $profile_d_bak_dir/. $profile_d_dir
  echo "${profile_d_dir} successfully restored"
  rm -rf $profile_d_bak_dir
fi

echo "Done restoring previous profile."
