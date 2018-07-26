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
import shutil
from src.utils.bash import run_bash_command
from src.utils.git import clone_repo


def install():
    repo_path = clone_repo(
        'https://github.com/dylanaraps/neofetch.git')
    cwd = os.getcwd()
    os.chdir(repo_path)
    run_bash_command(f'sudo make install')
    os.chdir(cwd)
    shutil.rmtree(repo_path)
