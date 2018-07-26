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
from src.applications import grub_customizer, vs_code
from src.setup import applications
from src.utils.apt import check_installed


class ApplicationsTest(TestCase):

    @classmethod
    def test_check_installed(cls):
        assert check_installed('apt')
        assert not check_installed('adfjsdlglsdglkneg')

    @classmethod
    def test_install_vs_code(cls):
        vs_code.install()

    @classmethod
    def test_install_grub_customizer(cls):
        grub_customizer.install()
