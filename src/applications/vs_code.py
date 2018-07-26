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
from src.utils.bash import message


def install():
    if check_installed("code"):
        message("VS Code is already installed.")
        return

    url = "https://go.microsoft.com/fwlink/?LinkID=760868"
    output_file = "vscode.deb"

    message("Downloading VS Code...")
    response = requests.get(url, allow_redirects=True)
    message("Finished downloading VS Code.")
    with open(output_file, 'wb') as file:
        file.write(response.content)
        install_dpkg(output_file)
    os.remove(output_file)
