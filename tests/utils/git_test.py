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
from unittest import TestCase
from src.utils.user import get_current_user
from src.utils.git import is_git_repo
from src.utils.git import is_github_repo
from src.utils.git import is_gitlab_repo
import pathlib


class GitTest(TestCase):

    @classmethod
    def test_is_git_repo(cls):
        assert is_git_repo(pathlib.Path(
            '/home/ianrobrien/Development/ubuntu-customizations'))
        assert not is_git_repo(pathlib.Path.home())

    @classmethod
    def test_is_github_repo(cls):
        assert is_github_repo(pathlib.Path(
            '/home/ianrobrien/Development/papirus-icon-theme'))
        assert not is_gitlab_repo(pathlib.Path(
            '/home/ianrobrien/Development/papirus-icon-theme'))
        assert not is_github_repo(pathlib.Path.home())

    @classmethod
    def test_is_gitlab_repo(cls):
        assert is_gitlab_repo(pathlib.Path(
            '/home/ianrobrien/Development/ubuntu-customizations'))
        assert not is_github_repo(pathlib.Path(
            '/home/ianrobrien/Development/ubuntu-customizations'))
        assert not is_gitlab_repo(pathlib.Path.home())
