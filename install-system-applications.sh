#!/usr/bin/env bash
#
# Ian R. O'Brien
# https://gitlab.com/ianrobrien/ubuntu-customizations
#
# Usage: ./install-system-applications.sh

# User Check
if [[ $EUID -ne 0 ]]; then
   echo 'This script must be run as root' 1>&2
   exit 1
fi

# Get the current user
[ $SUDO_USER ] && user=$SUDO_USER || user=`whoami`

# Constants
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Applications
sudo apt update && apt install -y \
    vim \
    keepassxc \
    htop gdebi \
    git docker.io openjdk-11-jre openjdk-11-jdk openjdk-8-jdk openjdk-8-jre \
    gnome-tweak-tool gnome-system-monitor gnome-calculator pinta \
    fortunes cowsay lolcat \
    fonts-firacode \
    make gcc curl

# # Application Settings


# Manual Applications (TODO: consider replacing with flatpak or snaps)
if ! [[ -x `(command -v bcompare)` ]]; then
    while true; do
        read -r -p 'Do you want to install Beyond Compare? [y/n]: ' answer
        case $answer in
            [Yy]* )
                ${DIR}/application-installation-scripts/install-beyond-compare.sh; break;;
            [Nn]* )
                break;;
            * ) echo 'Please answer [Y/y]es or [N/n]o.';;
        esac
    done
fi
if ! [[ -x `(command -v grub-customizer)` ]]; then
    while true; do
        read -r -p 'Do you want to install Grub Customizer? [y/n]: ' answer
        case $answer in
            [Yy]* )
                ${DIR}/application-installation-scripts/install-grub-customizer.sh; break;;
            [Nn]* )
                break;;
            * ) echo 'Please answer [Y/y]es or [N/n]o.';;
        esac
    done
fi
# if ! [[ -x `(command -v idea)` ]]; then
#     su -c ${DIR}/application-installation-scripts/install-jetbrains-toolbox-app.sh -s /bin/sh ${user}
# fi

# Grub Theme
while true; do
    read -r -p 'Do you want to install the Preiketolen grub theme? [y/n]: ' answer
    case $answer in
        [Yy]* )
            sudo cp -R ${DIR}/extras/grub-themes/preikestolen /boot/grub/themes/
            sudo grep "GRUB_THEME=" /etc/default/grub 2>&1 >/dev/null && sed -i '/GRUB_THEME=/d' /etc/default/grub
            echo "GRUB_THEME=\"/boot/grub/themes/preikestolen/theme.txt\"" >> /etc/default/grub
            sudo update-grub
            break;;
        [Nn]* )
            break;;
        * ) echo 'Please answer [Y/y]es or [N/n]o.';;
    esac
done

# Login Screen
#sudo cp /usr/share/gnome-shell/theme/ubuntu.css /usr/share/gnome-shell/theme/ubuntu.css.bak
# sudo cp /usr/share/gnome-shell/theme/ubuntu.css ${DIR}/extras/gdm-themes/trolltunga/ubuntu.css.bak
# sudo cp ${DIR}/extras/gdm-themes/trolltunga/ubuntu.css /usr/share/gnome-shell/theme/ubuntu.css
# sudo cp ${DIR}/extras/gdm-themes/trolltunga/trolltunga-1920x1200-blurred.jpg /usr/share/backgrounds/

## Splash Screen
