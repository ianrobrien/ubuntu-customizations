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
from src.utils.apt import check_installed, install_from_ppa
from src.utils.bash import message, run_bash_command


def install():
    if check_installed("libreoffice"):
        message("Libre Office is already installed.")
        return

    # This command is in the PPA but Ubuntu lacks an installation candidate
    #run_bash_command('sudo apt-get install python-software-properties')
    install_from_ppa('ppa:libreoffice/ppa',
                     'libreoffice')
