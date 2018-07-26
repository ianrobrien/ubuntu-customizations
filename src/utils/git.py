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
import pathlib
import shutil

from src.utils.bash import run_bash_command


def clone_repo(repo_url):
    repo_name = None
    for token in repo_url.split("/"):
        if ".git" in token:
            repo_name = token[:-4]
    if repo_name is None:
        raise ValueError("Could not parse git repository name from URL")

    if pathlib.Path(repo_name).exists():
        shutil.rmtree(repo_name)

    run_bash_command(f'git clone {repo_url}')
    return pathlib.Path(repo_name).resolve()


def is_git_repo(parent):
    git_dir = pathlib.Path(parent, '.git')
    return git_dir.exists()


def is_github_repo(parent):
    git_config_path = pathlib.Path(parent, '.git/config')
    return git_config_path.exists() and 'github' in open(git_config_path).read()


def is_gitlab_repo(parent):
    git_config_path = pathlib.Path(parent, '.git/config')
    return git_config_path.exists() and 'gitlab' in open(git_config_path).read()
