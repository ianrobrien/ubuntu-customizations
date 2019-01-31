# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Add Java to environment
export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64/"
export QT_QPA_PLATFORMTHEME=gtk2
export CHROME_BIN=/usr/bin/google-chrome
export GROOVY_HOME=~/.local/lib/groovy-2.5.5

# Update PATH
CHROME_DRIVER_HOME="/opt/chromedriver_linux64/"
NODE_HOME="/opt/node-v10.15.0-linux-x64/bin"
NPM_MODULES_HOME="/home/ianrobrien/.npm/bin"

PATH="${JAVA_HOME}:$PATH"
PATH="${CHOME_DRIVER_HOME}:$PATH"
PATH="${GROOVY_HOME}/bin:$PATH"
PATH="${NODE_HOME}:$PATH"
PATH="${NPM_MODULES_HOME}:$PATH"

