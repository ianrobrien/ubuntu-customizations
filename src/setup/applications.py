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
from src.applications import beyond_compare
from src.applications import grub_customizer
from src.applications import vs_code
from src.utils.bash import query_yes_no


def install_system_applications():
    subprocess.call(['apt', 'update'])
    subprocess.call(['apt', 'install', '-y',
                     'vim',
                     'keepassxc',
                     'htop',
                     'gdebi',
                     'git',
                     'docker.io',
                     'openjdk-11-jre',
                     'openjdk-11-jdk',
                     'openjdk-8-jdk',
                     'openjdk-8-jre',
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
    if query_yes_no("Install applications from apt?"):
        install_system_applications()
    if query_yes_no("Install VS Code?"):
        vs_code.install()
    if query_yes_no("Install Beyond Compare?"):
        beyond_compare.install()
    if query_yes_no("Install Grub Customzier?"):
        grub_customizer.install()