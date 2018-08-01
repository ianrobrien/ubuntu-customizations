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
from src.utils.bash import run_bash_command
from src.utils.bash import run_bash_command_in_shell


def check_installed(application_name):
    return run_bash_command_in_shell(f'which {application_name} > /dev/null 2>&1') == 0


def install_dpkg(dpkg):
    run_bash_command(f'gdebi {dpkg}')


def uninstall_dpkg(dpkg):
    run_bash_command(f'apt remove {dpkg}')


def install_from_ppa(ppa_name, application_name):
    run_bash_command(
        f'add-apt-repository {ppa_name}')
    run_bash_command('apt update')
    run_bash_command(f'apt install -y {application_name}')
