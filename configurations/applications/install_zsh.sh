# Application: oh my zsh
#
# Dependencies: zsh, powerline fonts

zsh_dir=$(dirname 0)/zsh
ohmyzsh_install_dir=~/.oh-my-zsh
echo ${ohmyzsh_install_dir}
echo $zsh_dir
zsh_config_script="setup_zsh_profile.sh"

echo "Installing application: oh my zsh"
echo "Installing dependency ZSH"
apt-get install zsh

# ZSH: Download and install
echo "Downloading and installing oh my zsh"
#git clone https://github.com/robbyrussell/oh-my-zsh.git ${ohmyzsh_install_dir}

# copy theme, plugins, aliases

# ZSH: Set up profiles, aliases, etc
echo "Setting up ZSH environment profile, variables, aliases"
. ${zsh_dir}/${zsh_config_script}

# Change the default shell to ZSH
echo "Changing default shell to ZSH"
#chsh -s /bin/zsh
