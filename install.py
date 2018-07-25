#!/usr/bin/python3
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
import sys
from src.setup import applications
from src.setup import dotfiles
from src.setup import gnome
from src.utils.bash import is_root
from src.utils.bash import message
from src.utils.bash import print_banner
from src.utils.bash import query_yes_no


def main():
    if not is_root():
        message("This script must be run with sudo permissions")
        return

    print_banner()
    try:
        if query_yes_no("Install applications?"):
            applications.install()
        if query_yes_no("Install dot files?"):
            dotfiles.install()
        if query_yes_no("Setup Gnome?"):
            gnome.setup()
        message("Finished running script!")
    except KeyboardInterrupt:
        print('')
        message(f'User aborted script.')
        sys.exit()


if __name__ == "__main__":
    main()
