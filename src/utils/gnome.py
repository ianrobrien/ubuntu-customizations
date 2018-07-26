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
from src.utils.bash import run_bash_command, run_bash_command_in_shell
from src.utils.git import is_github_repo, is_gitlab_repo


def set_folder_icon(folder, icon_path):
    command = f'sudo su -- ianrobrien -c \'gio set -t string {folder} metadata::custom-icon file://{icon_path}\''
    #command = f'sudo su -- ianrobrien -c \'gio set {folder} metadata::custom-icon-name folder-gitlab\''
    run_bash_command_in_shell(command)


def set_folder_icons_repositories(path):
    if not pathlib.Path('/usr/share/icons/Papirus/').exists:
        raise EnvironmentError(
            "This option requires papirus-icon-theme to be installed to /usr/share/icons/Papirus")

    gitlab_icon = pathlib.Path(
        '/usr/share/icons/Papirus/48x48/places/folder-gitlab.svg')
    github_icon = pathlib.Path(
        '/usr/share/icons/Papirus/48x48/places/folder-github.svg')

    # This is probably not the most efficient way to do this:
    for root, dirs, files in os.walk(path):
        path = root.split(os.sep)
        for dir in dirs:
            if dir == '.git':
                if is_github_repo(root):
                    print(f'GitHub repo: {root}')
                    set_folder_icon(root, github_icon)
                elif is_gitlab_repo(root):
                    print(f'GitLab repo: {root}')
                    set_folder_icon(root, gitlab_icon)
