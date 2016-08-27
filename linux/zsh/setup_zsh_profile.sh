# This script will set up profile variables for ZSH

# Destination Variables for profile files
profile_file=~/.profile
profile_bak_file=${profile_file}.bak

profile_d_dir=~/.profile.d
profile_d_bak_dir=${profile_d_dir}.bak

profile_d_src_dir=./profile/profile.d/.
profile_src_file=./profile/.profile

echo "Setting up ZSH profile..."

# copy over .profile (after backing it up) which will load everything else
if [ -f "$profile_file" ]; then
  echo "$profile_file exists. Creating backup ${profile_bak_file}"
  cp $profile_file $profile_bak_file
  rm $profile_file
fi
cp $profile_src_file $profile_file
echo "Successfuly wrote $profile_src_file to $profile_file"

# copy over .profile.d/ (after backing it up) which will load everything else
if [ -d "$profile_d_dir" ]; then
  echo "$profile_d_dir exists. Creating backup ${profile_d_bak_dir}"
  cp -r $profile_d_dir $profile_d_bak_dir
  rm -rf $profile_d_dir
fi
mkdir $profile_d_dir
cp -a $profile_d_src_dir $profile_d_dir
echo "Successfuly wrote $profile_d_src_dir to $profile_d_dir"

echo "Done setting up ZSH profile."
