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
from src.utils.bash import message


def copy_directory_contents(src, dest):
    src_files = os.listdir(src)
    for file_name in src_files:
        full_file_name = os.path.join(src.resolve(), file_name)
        if (os.path.isfile(full_file_name)):
            print(f'copying {full_file_name} to {dest}')
            shutil.copy(full_file_name, dest)


def copytree_delete_existing(source, destination):
    if (destination.exists()):
        message(f"Deleting existing destination directory {destination}")
        shutil.rmtree(destination)
    message(f"Copying {source} to {destination}")
    shutil.copytree(source, destination)
