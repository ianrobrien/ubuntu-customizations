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
from src.utils.applications import check_installed
from src.utils.applications import install_dpkg
from src.utils.bash import message
from urllib import request


def install():
    if check_installed("bcompare"):
        message("Beyond Compare is already installed.")
        return

    output_file = 'bcompare-4.2.6.23150_amd64.deb'
    url = f'http://www.scootersoftware.com/{output_file}'

    message("Downloading Beyond Compare...")
    request.urlretrieve(url, output_file)
    message("Finished downloading Beyond Compare.")
    install_dpkg(output_file)
    os.remove(output_file)
