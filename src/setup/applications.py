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
import os
import requests
import shutil
import subprocess
from src.utils import query_yes_no
from urllib import request


def check_installed(application_name):
    return subprocess.call(['which', application_name]) == 0


def install_dpkg(dpkg):
    subprocess.call(['dpkg', '-i', dpkg])
    subprocess.call(['apt', 'install', '-f'])


def uninstall_dpkg(dpkg):
    subprocess.call(['apt', 'remove', dpkg])


def install_beyond_compare():
    if check_installed("bcompare"):
        print("Beyond Compare is already installed")
        return

    output_file = 'bcompare-4.2.6.23150_amd64.deb'
    url = f'http://www.scootersoftware.com/{output_file}'

    print("Downloading Beyond Compare...")
    request.urlretrieve(url, output_file)
    print("Finished downloading Beyond Compare.")
    install_dpkg(output_file)
    os.remove(output_file)


def install_vs_code():
    if check_installed("code"):
        print("VS Code is already installed")
        return

    url = "https://go.microsoft.com/fwlink/?LinkID=760868"
    output_file = "vscode.deb"

    print("Downloading VS Code...")
    response = requests.get(url, allow_redirects=True)
    print("Finished downloading VS Code.")
    with open(output_file, 'wb') as file:
        file.write(response.content)
        install_dpkg(output_file)
    os.remove(output_file)


def install_grub_customizer():
    if check_installed("grub-customizer"):
        print("Grub Customizer is already installed")
        return

    # sudo add-apt-repository ppa: danielrichter2007/grub-customizer
    # sudo apt-get update
    # sudo apt-get install grub-customizer


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
    if query_yes_no("Install system applications?"):
        install_system_applications()
    if query_yes_no("Install VS Code?"):
        install_vs_code()
    if query_yes_no("Install Beyond Compare?"):
        install_beyond_compare()


def uninstall():
    if query_yes_no("Uninstall VS Code?", "no"):
        uninstall_dpkg("code")
    if query_yes_no("Uninstall Beyond Compare?", "no"):
        uninstall_dpkg("bcompare")
