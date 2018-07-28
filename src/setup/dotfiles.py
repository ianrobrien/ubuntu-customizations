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
from src.utils.bash import message, query_yes_no, run_bash_command
from src.utils.filesystem import take_ownership_current_user
from src.utils.user import get_current_user

dotfiles = ['.bin', '.vim', '.bash_aliases',
            '.bashrc', '.inputrc', '.profile', '.vimrc',
            '.config/Code/User/settings.json',
            '.config/neofetch/config.conf']


def add_dotfile(source, destination):
    if destination.exists():
        if query_yes_no(f"Overwrite existing dotfile at {destination}?"):
            if destination.is_symlink():
                os.unlink(destination)
            else:
                if destination.is_file():
                    os.remove(destination)
                elif destination.is_dir():
                    shutil.rmtree(destination)
        else:
            return

    if not destination.parent.exists():
        os.makedirs(destination.parent)

    os.symlink(source, destination)
    take_ownership_current_user(destination)


def install():
    message("Installing dotfiles...")
    for path in dotfiles:
        source = pathlib.Path('resources', 'dotfiles', path)
        if not source.exists():
            raise ValueError(f"The source file does not exist: '{source}'")
        add_dotfile(source.resolve(), pathlib.Path(pathlib.Path.home(), path))
    message("Dotfiles installed")
