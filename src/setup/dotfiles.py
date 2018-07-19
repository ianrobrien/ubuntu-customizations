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
from src.utils.bash import message

paths_to_link = ['.bin', '.vim', '.bash_aliases',
                 '.bashrc', '.inputrc', '.profile', '.vimrc',
                 '.config/Code/User/settings.json',
                 '.config/neofetch/config.conf']


def add_dotfile(source, destination):
    message("Destination " + str(destination))
    if destination.is_symlink():
        if destination.exists():
            message(f"Unlinking existing link {destination}")
            os.unlink(destination)
    elif destination.is_file():
        if destination.exists():
            message(f"Deleting existing file {destination}")
            os.remove(destination)

    if not destination.parent.exists():
        message(f"Creating parent directories for dotfile {source}")
        os.mkdir(destination.parent)

    message(f"Creating symbolic link for path {source} at {destination}")
    os.symlink(source, destination)


def remove_dotfile(dotfile):
    message("Destination " + str(dotfile))
    if dotfile.is_symlink():
        if dotfile.exists():
            message(f"Unlinking existing link {dotfile}")
            os.unlink(dotfile)
    elif dotfile.is_file():
        if dotfile.exists():
            message(f"Deleting existing file {dotfile}")
            os.remove(dotfile)


def install():
    for path in paths_to_link:
        source = pathlib.Path('resources', 'dotfiles', path)
        if not source.exists():
            raise ValueError(f"The source file does not exist: '{source}'")
        add_dotfile(source.resolve(), pathlib.Path(pathlib.Path.home(), path))


def uninstall():
    for path in paths_to_link:
        dotfile = pathlib.Path(pathlib.Path(pathlib.Path.home(), path))
        if not dotfile.exists():
            raise ValueError(f"The dotfile file does not exist: '{dotfile}'")
        remove_dotfile(dotfile)
