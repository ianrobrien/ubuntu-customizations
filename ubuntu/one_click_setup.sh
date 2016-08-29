# This script will setup an environment with all the nice stuff I like
#   Applications
#     ZSH
#   Configurations
#     Profile scripts

pwd_dir=$(pwd)

# ZSH Stuff
zsh_dir=${pwd_dir}/zsh
zsh_config_script="setup_zsh_profile.sh"

#sudo apt-get update
#sudo apt-get upgrade
#sudo apt-get install redshift vim git

# ZSH: Download and install
cd ~
git clone https://github.com/robbyrussell/oh-my-zsh.git .oh-my-zsh
cd .oh-my-zsh/tools/
./install.sh
# copy theme, plugins, aliases

# ZSH: Set up profiles, aliases, etc
cd ${zsh_dir}
ls
./${zsh_config_script}
cd ..

#setup fonts
#setup color schemes
#download install chrome
#download install vs code
#download install atom
#download install intellij
#download install themes
#download install beyond compare
