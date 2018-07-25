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
from src.utils.bash import query_yes_no

paths_to_link = ['.bin', '.vim', '.bash_aliases',
                 '.bashrc', '.inputrc', '.profile', '.vimrc',
                 '.config/Code/User/settings.json',
                 '.config/neofetch/config.conf']


def add_dotfile(source, destination):
    if destination.exists():
        if query_yes_no(f"Overwrite existing dotfile at {destination}?"):
            if destination.is_symlink():
                os.unlink(destination)
            else:
                os.remove(destination)

    if not destination.parent.exists():
        os.mkdir(destination.parent)

    os.symlink(source, destination)


def remove_dotfile(dotfile):
    if dotfile.exists():
        if dotfile.is_symlink():
            os.unlink(dotfile)
        elif dotfile.is_file():
            os.remove(dotfile)


def install():
    message("Installing dotfiles...")
    for path in paths_to_link:
        source = pathlib.Path('resources', 'dotfiles', path)
        if not source.exists():
            raise ValueError(f"The source file does not exist: '{source}'")
        add_dotfile(source.resolve(), pathlib.Path(pathlib.Path.home(), path))
    message("Dotfiles installed")


def uninstall():
    for path in paths_to_link:
        dotfile = pathlib.Path(pathlib.Path(pathlib.Path.home(), path))
        if not dotfile.exists():
            raise ValueError(f"The dotfile file does not exist: '{dotfile}'")
        remove_dotfile(dotfile)
