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
import subprocess


def message(message):
    print(f'=> {message}')


def run_bash_command(bash_command):
    subprocess.call(bash_command.split())


def run_bash_command_in_shell(bash_command):
    return subprocess.call(bash_command, shell=True)


def query_yes_no(question, default="yes"):
    valid = {"yes": True, "y": True, "ye": True,
             "no": False, "n": False}
    if default is None:
        prompt = "[y/n]: "
    elif default == "yes":
        prompt = "[Y/n]: "
    elif default == "no":
        prompt = "[y/N]: "
    else:
        raise ValueError(f"invalid default answer: '{default}'")

    while True:
        choice = input(f'=> {question} {prompt}').lower()
        if default is not None and choice == '':
            return valid[default]
        elif choice in valid:
            return valid[choice]
        else:
            message("Please respond with 'yes' or 'no' (or 'y' or 'n').\n")


def print_banner():
    print()
    print(r"        _                 _                          _                  _          _   _                  ")
    print(r"  _   _| |__  _   _ _ __ | |_ _   _    ___ _   _ ___| |_ ___  _ __ ___ (_)______ _| |_(_) ___  _ __  ___  ")
    print(r" | | | | '_ \| | | | '_ \| __| | | |  / __| | | / __| __/ _ \| '_ ` _ \| |_  / _` | __| |/ _ \| '_ \/ __| ")
    print(r" | |_| | |_) | |_| | | | | |_| |_| | | (__| |_| \__ \ || (_) | | | | | | |/ / (_| | |_| | (_) | | | \__ \ ")
    print(r"  \__,_|_.__/ \__,_|_| |_|\__|\__,_|  \___|\__,_|___/\__\___/|_| |_| |_|_/___\__,_|\__|_|\___/|_| |_|___/ ")
    print(r"                                                     https://gitlab.com/ianrobrien/ubuntu-customizations/ ")
    print()
