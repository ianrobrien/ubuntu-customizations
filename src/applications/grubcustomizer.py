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
from src.utils.bash import message


def install():
    if check_installed("grub-customizer"):
        message("Grub Customizer is already installed.")
        return

    install_from_ppa('ppa:danielrichter2007/grub-customizer',
                     'grub-customizer')
