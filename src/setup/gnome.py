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
from src import utils
from src.setup import applications
import shutil
import os
import pathlib
import subprocess

themes_root = pathlib.Path("/usr/share/themes/")
icons_root = pathlib.Path("/usr/share/icons/")
wallpaper_root = pathlib.Path(pathlib.Path.home(), 'Pictures/Wallpapers')


def set_gsetting(schema, key, value):
    bash_command = f'gsettings set {schema} {key} {value}'
    subprocess.getoutput(bash_command)


def install_fonts():
    font_dir = pathlib.Path(pathlib.Path.home(), '.local/share/fonts')
    if not font_dir.exists():
        os.mkdir(font_dir)

    shutil.copy(pathlib.Path(
        'resources/fonts/RobotoCondensed-Regular.ttf'), font_dir)

    user = utils.get_current_user()
    subprocess.call(f'chown -R {user}: {font_dir}'.split())
    subprocess.call('fc-cache -f -v'.split())

    set_gsetting('org.gnome.desktop.wm.preferences',
                 'titlebar-font', "'Roboto Condensed, 13'")
    set_gsetting('org.gnome.desktop.interface',
                 'font-name', "'Roboto Condensed, 12'")
    set_gsetting('org.gnome.desktop.interface',
                 'document-font-name', "'Sans 11'")


def set_wallpaper():
    if not wallpaper_root.exists():
        os.mkdir(wallpaper_root)
    shutil.copy(pathlib.Path(
        'resources/wallpaper/preikestolen-1600x900.jpg'), wallpaper_root)
    shutil.copy(pathlib.Path(
        'resources/wallpaper/trolltunga-1920x1200.jpg'), wallpaper_root)
    wallpaper_target = pathlib.Path(wallpaper_root, "trolltunga-1920x1200.jpg")
    set_gsetting('org.gnome.desktop.background', 'picture-uri',
                 f'file://{str(wallpaper_target)}')
    set_gsetting('org.gnome.desktop.screensaver', 'picture-uri',
                 f'file://{str(wallpaper_target)}')


def install_grub_theme():
    print("Installing Grub theme..")
    utils.copytree_delete_existing(pathlib.Path('resources/grub-themes/preikestolen').resolve(),
                                   pathlib.Path('/boot/grub/themes/preikestolen'))


def install_mc_os_themes():
    print("Installing Mc-OS Themes...")
    repo_path = utils.git_clone(
        "https://github.com/ianrobrien/mc-os-themes.git")

    for theme in os.listdir(repo_path):
        theme_path = pathlib.Path(repo_path, theme).resolve()
        if "McOS" in str(theme_path) or "Gnome" in str(theme_path):
            utils.copytree_delete_existing(
                theme_path, pathlib.Path(themes_root, theme))

    shutil.rmtree(repo_path)

    set_gsetting('org.gnome.desktop.wm.preferences', 'theme', 'McOS-MJV-dark')
    set_gsetting('org.gnome.desktop.interface', 'gtk-theme', 'McOS-MJV-dark')


def install_capitaine_cursors():
    print("Installing Capitaine Cursors...")
    repo_path = utils.git_clone(
        'https://github.com/keeferrourke/capitaine-cursors.git')

    for theme in os.listdir(repo_path):
        theme_path = pathlib.Path(repo_path, theme).resolve()
        if "dist" in str(theme_path):
            utils.copytree_delete_existing(
                theme_path, pathlib.Path(icons_root, "capitaine-cursors"))

    shutil.rmtree(repo_path)


def load_gnome_terminal_settings():
    settings_file = pathlib.Path(
        'resources/application-settings/gnome-terminal.txt').resolve()
    bash_command = f'dconf load /org/gnome/terminal/ < {str(settings_file)}'
    subprocess.call(bash_command, shell=True)


def configure_gnome():
    set_gsetting('org.gnome.shell.extensions.dash-to-dock',
                 'click-action', 'minimize')
    if applications.check_installed('papirus-icon-theme'):
        set_gsetting('org.gnome.desktop.interface', 'icon-theme', 'Papirus')


def setup():
    if utils.query_yes_no("Load Gnome Terminal settings?", "no"):
        load_gnome_terminal_settings()
    if utils.query_yes_no("Install Preikestolen grub theme?", "no"):
        install_grub_theme()
    if utils.query_yes_no("Install Mc-OS Themes?", "no"):
        install_mc_os_themes()
    if utils.query_yes_no("Install Capitaine Cursors?", "no"):
        install_capitaine_cursors()
    if utils.query_yes_no("Configure Gnome settings?", "no"):
        configure_gnome()
    if utils.query_yes_no("Set wallpaper?", "no"):
        set_wallpaper()
    if utils.query_yes_no("Install fonts?", "no"):
        install_fonts()
