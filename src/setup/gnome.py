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
from src import utils
from src.setup import applications
from src.utils.apt import check_installed
from src.utils.bash import message
from src.utils.bash import query_yes_no
from src.utils.bash import run_bash_command
from src.utils.bash import run_bash_command_in_shell
from src.utils.filesystem import copytree_delete_existing
from src.utils.filesystem import copy_directory_contents
from src.utils.git import clone_repo
from src.utils.user import get_current_user


class Constants:
    class Paths:
        def THEMES_PATH(self):
            return pathlib.Path("/usr/share/themes/")

        def ICONS_PATH(self):
            return pathlib.Path("/usr/share/icons/")

        def WALLPAPER_ROOT(self):
            return pathlib.Path(
                pathlib.Path.home(), 'Pictures/Wallpapers')

        def HOME_PATH(self):
            return pathlib.Path.home()

        def LOCAL_FONTS_PATH(self):
            return pathlib.Path(pathlib.Path.home(), '.local/share/fonts')

        def GRUB_PATH(self):
            return pathlib.Path('/boot/grub/')


PATHS = Constants().Paths()


def set_gsetting(schema, key, value):
    run_bash_command_in_shell(f'gsettings set {schema} {key} {value}')


def install_fonts():
    fonts_path = PATHS.LOCAL_FONTS_PATH()
    if not fonts_path.exists():
        os.mkdir(fonts_path)

    copy_directory_contents(pathlib.Path('resources/fonts/'), fonts_path)

    user = get_current_user()
    run_bash_command(f'chown -R {user}: {fonts_path}')
    run_bash_command('fc-cache -f -v')

    set_gsetting('org.gnome.desktop.wm.preferences',
                 'titlebar-font', "'Roboto Condensed, 13'")
    set_gsetting('org.gnome.desktop.interface',
                 'font-name', "'Roboto Condensed, 12'")
    set_gsetting('org.gnome.desktop.interface',
                 'document-font-name', "'Sans 11'")


def set_wallpaper():
    if not PATHS.WALLPAPER_ROOT().exists():
        os.mkdir(PATHS.WALLPAPER_ROOT())

    copy_directory_contents(pathlib.Path(
        'resources/wallpaper/'), PATHS.WALLPAPER_ROOT())
    wallpaper_target = pathlib.Path(
        PATHS.WALLPAPER_ROOT(), "trolltunga-1920x1200.jpg")
    set_gsetting('org.gnome.desktop.background', 'picture-uri',
                 f'file://{str(wallpaper_target)}')
    set_gsetting('org.gnome.desktop.screensaver', 'picture-uri',
                 f'file://{str(wallpaper_target)}')


def install_grub_theme():
    message("Installing Grub theme..")
    copytree_delete_existing(pathlib.Path('resources/grub-themes/preikestolen').resolve(),
                             pathlib.Path(PATHS.GRUB_PATH(), 'themes/preikestolen'))


def install_mc_os_themes():
    message("Installing Mc-OS Themes...")
    repo_path = clone_repo(
        "https://github.com/ianrobrien/mc-os-themes.git")

    for theme in os.listdir(repo_path):
        theme_path = pathlib.Path(repo_path, theme).resolve()
        if "McOS" in str(theme_path) or "Gnome" in str(theme_path):
            copytree_delete_existing(
                theme_path, pathlib.Path(PATHS.THEMES_PATH(), theme))

    shutil.rmtree(repo_path)

    set_gsetting('org.gnome.desktop.wm.preferences', 'theme', 'McOS-MJV-dark')
    set_gsetting('org.gnome.desktop.interface', 'gtk-theme', 'McOS-MJV-dark')


def install_capitaine_cursors():
    message("Installing Capitaine Cursors...")
    repo_path = clone_repo(
        'https://github.com/keeferrourke/capitaine-cursors.git')

    for theme in os.listdir(repo_path):
        theme_path = pathlib.Path(repo_path, theme).resolve()
        if "dist" in str(theme_path):
            copytree_delete_existing(
                theme_path, pathlib.Path(PATHS.ICONS_PATH(), "capitaine-cursors"))

    shutil.rmtree(repo_path)


def load_gnome_terminal_settings():
    settings_file = pathlib.Path(
        'resources/application-settings/gnome-terminal.txt').resolve()
    run_bash_command_in_shell(
        f'dconf load /org/gnome/terminal/ < {str(settings_file)}')


def configure_gnome():
    set_gsetting('org.gnome.shell.extensions.dash-to-dock',
                 'click-action', 'minimize')


def install_papirus_icon_theme_from_github():
    repo_path = clone_repo(
        'https://github.com/PapirusDevelopmentTeam/papirus-icon-theme.git')
    run_bash_command(f'{repo_path}/install.sh')
    set_gsetting('org.gnome.desktop.interface', 'icon-theme', 'Papirus')
    shutil.rmtree(repo_path)


def setup():
    if query_yes_no("Configure Gnome behavior settings?"):
        configure_gnome()
    if query_yes_no("Install wallpapers?"):
        set_wallpaper()
    if query_yes_no("Install fonts?"):
        install_fonts()
    if query_yes_no("Install Grub theme (Preikestolen)?"):
        install_grub_theme()
    if query_yes_no("Load Terminal settings (OneDark theme)?"):
        load_gnome_terminal_settings()
    if query_yes_no("Install Application Themes from GitHub? (https://github.com/ianrobrien/mc-os-themes)"):
        install_mc_os_themes()
    if query_yes_no("Install Capitaine Cursors from GitHub? (https://github.com/keeferrourke/capitaine-cursors)"):
        install_capitaine_cursors()
    if query_yes_no("Install Papirus Icon Theme from GitHub? (https://github.com/PapirusDevelopmentTeam/papirus-icon-theme)"):
        install_papirus_icon_theme_from_github()
