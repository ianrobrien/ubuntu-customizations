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
import pathlib
import shutil
import subprocess

from src.utils.bash import message, run_bash_command
from src.utils.user import get_current_user, is_root_user


def take_ownership_root(path):
    take_ownership('root', path)


def take_ownership_current_user(path):
    take_ownership(get_current_user(), path)


def take_ownership(user, path):
    if user == 'root' and not is_root_user():
        raise EnvironmentError(
            "The current user must be root in order to take root ownership")
    run_bash_command(f'chown -R {user}: {path}')


def copy_directory_contents(source, destination):
    if not destination.exists():
        os.mkdir(destination)

    src_files = os.listdir(source)
    for file_name in src_files:
        full_file_name = os.path.join(source.resolve(), file_name)
        if (os.path.isfile(full_file_name)):
            shutil.copy(full_file_name, destination)


def copytree_delete_existing(source, destination):
    if (destination.exists()):
        shutil.rmtree(destination)
    shutil.copytree(source, destination)
