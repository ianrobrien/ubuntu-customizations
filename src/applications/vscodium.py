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
from src.utils.apt import check_installed, install_dpkg
from src.utils.bash import message, run_bash_command


def install():
    if check_installed("vscodium"):
        message("VSCodium is already installed.")
        return

    url = "https://github.com/VSCodium/vscodium/releases/download/1.33.1/vscodium_1.33.1-1556929548_amd64.deb"
    output_file = "vscodium.deb"

    message("Downloading VSCodium...")
    response = requests.get(url, allow_redirects=True)
    message("Finished downloading VSCodium.")
    with open(output_file, 'wb') as file:
        file.write(response.content)
        install_dpkg(output_file)
    os.remove(output_file)

    # Install Extensions
    run_bash_command('vscodium --install-extension eamodio.gitlens')
    #run_bash_command('code --install-extension hoovercj.vscode-power-mode')
    run_bash_command('vscodium --install-extension ms-python.python')
    run_bash_command('vscodium --install-extension ms-vscode.cpptools')
    run_bash_command('vscodium --install-extension PKief.material-icon-theme')
    run_bash_command('vscodium --install-extension zhuangtongfa.Material-theme')
