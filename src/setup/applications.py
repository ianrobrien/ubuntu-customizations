# Copyright (c) 2018-present, Ian R. O'Brien
#
# Licensed under the MIT License (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://opensource.org/licenses/MIT
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
##############################################################################
import subprocess

from src.applications import (beyond_compare, flatpak, grub_customizer,
                              keepassxc, neofetch, vs_code)
from src.utils.bash import query_yes_no, run_bash_command


def install_system_applications():
    run_bash_command('apt update')
    subprocess.call(['apt', 'install', '-y',
                     'vim',
                     'htop',
                     'gdebi',
                     'git',
                     'docker.io',
                     'openjdk-11-jre',
                     'openjdk-11-jdk',
                     'openjdk-8-jdk',
                     'openjdk-8-jre',
                     'qt5-style-plugins',
                     'gnome-tweak-tool',
                     'gnome-system-monitor',
                     'gnome-calculator',
                     'pinta',
                     'fortunes',
                     'cowsay',
                     'lolcat',
                     'fonts-firacode',
                     'make',
                     'gcc',
                     'curl',
                     ])


def install():
    if query_yes_no("Install Applications from apt?"):
        install_system_applications()
    if query_yes_no("Install VS Code from deb package? (https://go.microsoft.com/fwlink/?LinkID=760868)"):
        vs_code.install()
    if query_yes_no("Install Beyond Compare from deb package? (http://www.scootersoftware.com/)"):
        beyond_compare.install()
    if query_yes_no("Install Grub Customzier from PPA? (ppa:danielrichter2007/grub-customizer)"):
        grub_customizer.install()
    if query_yes_no("Install KeePassXC from PPA? (ppa:phoerious/keepassxc)"):
        keepassxc.install()
    if query_yes_no("Install Flatpak from PPA? (ppa:alexlarsson/flatpak)"):
        flatpak.install()
    if query_yes_no("Install neofetch from GitHub? (https://github.com/dylanaraps/neofetch)"):
        neofetch.install()
