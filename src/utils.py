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


def is_root():
    return os.getuid() == 0


def get_current_user():
    bash_command = 'echo ${SUDO_USER:-$(whoami)}'
    username = subprocess.getoutput(bash_command)
    return username


def git_clone(repo_url):
    repo_name = None
    for token in repo_url.split("/"):
        if ".git" in token:
            repo_name = token[:-4]
    if repo_name is None:
        raise ValueError("Could not parse git repository name from URL")

    if pathlib.Path(repo_name).exists():
        shutil.rmtree(repo_name)

    bash_command = f'git clone {repo_url}'
    subprocess.call(bash_command.split())

    repo_path = pathlib.Path(repo_name).resolve()

    return repo_path


def query_yes_no(question, default="yes"):
    valid = {"yes": True, "y": True, "ye": True,
             "no": False, "n": False}
    if default is None:
        prompt = " [y/n] "
    elif default == "yes":
        prompt = " [Y/n] "
    elif default == "no":
        prompt = " [y/N] "
    else:
        raise ValueError(f"invalid default answer: '{default}'")

    while True:
        choice = input(question + prompt).lower()
        if default is not None and choice == '':
            return valid[default]
        elif choice in valid:
            return valid[choice]
        else:
            print("Please respond with 'yes' or 'no' (or 'y' or 'n').\n")


def copytree_delete_existing(source, destination):
    if (destination.exists()):
        print(f"Deleting existing destination directory {destination}")
        shutil.rmtree(destination)
    print(f"Copying {source} to {destination}")
    shutil.copytree(source, destination)
