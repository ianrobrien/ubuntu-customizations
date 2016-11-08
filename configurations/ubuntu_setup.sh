# This script will setup an environment with all the nice stuff I like
#   Applications
#   Configurations

current_directory=$(dirname $0)
install_scripts_dir=${current_directory}/applications/install_*.sh

#$(sudo apt-get update)
#$(sudo apt-get upgrade)

# Load Applications
for install_script in ${install_scripts_dir}; do
  . ${install_script}
  echo ${install_script}
done

#setup fonts
#setup color schemes
#download install chrome
#download install vs code
#download install atom
#download install intellij
#download install themes
#download install beyond compare
