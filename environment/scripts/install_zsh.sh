#!/usr/bin/env bash
platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
  platform='linux'
elif [[ "$unamestr" == CYGWIN* ]]; then
  platform='windows'
fi

cd ~

# clone the oh-my-zsh repo to ~/.oh-my-zsh
git clone https://github.com/robbyrussell/oh-my-zsh.git .oh-my-zsh

# copy the default config template
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

# copy over the custom themes
mkdir ~/.oh-my-zsh/custom/themes
cp ./01_oh_my_zsh/themes/* ~/.oh-my-zsh/custom/themes
sed -i -e 's/ZSH_THEME="robbyrussell"/ZSH_THEME="koselig"/g' ~/.zshrc

chsh -s /bin/zsh

cd ~
git clone https://github.com/powerline/fonts .powerline-fonts

cd ~/.powerline-fonts
if [[ $platform == 'linux' ]]; then
  ./install
elif [[ $platform == 'windows' ]];

fi
