# ubuntu-customizations

This repository contains information, settings, and scripts for customizing Ubuntu 18.04 (with Gnome).

## Application Customizations

* [dot files](resources/dotfiles)
* [How to make touch-screen scrolling work in Firefox Quantum?](https://askubuntu.com/questions/978226/how-to-make-touch-screen-scrolling-work-in-firefox-quantum)
* VS Code
  * [markdownlint](https://github.com/DavidAnson/vscode-markdownlint)
  * [One Dark Pro](https://github.com/Binaryify/OneDark-Pro)
  * [vscode-icons](https://github.com/vscode-icons/vscode-icons)

## Gnome Customizations

* Appearance
  * Applications: [McOS-MJV-Dark-mode](https://github.com/paullinuxthemer/Mc-OS-themes)
    * Firefox fix: about:config [widget.content.gtk-theme-override|McOS-MJV]
    * Dash to dock settings [#1E222C, 82%]
  * Cursor: [Capitaine-cursors](https://github.com/keeferrourke/capitaine-cursors)
  * Icons: [Papirus](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme)
    * [Hardcoded Icon Fixer](https://github.com/Foggalong/hardcode-fixer)
  * Shell: [McOS-Dark-Shell](https://github.com/paullinuxthemer/Mc-OS-themes/tree/master/McOS-Shell-themes)
    * Requires [user-themes](https://extensions.gnome.org/extension/19/user-themes/) extension
* Behavior
  * Minimize on dock icon click [gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize']
* Terminal - [OneDark](application-settings/gnome-terminal.txt) profile

## Gnome Extensions

* [Alt-Tab Switcher Popup Delay Removal](https://extensions.gnome.org/extension/1317/alt-tab-switcher-popup-delay-removal/)
* [Dash to Dock](https://extensions.gnome.org/extension/307/dash-to-dock/)
  * See also [dock on lock screen](https://github.com/micheleg/dash-to-dock/issues/649)
  * sudo mkdir /usr/share/gnome-shell/extensions-disabled/
  * sudo mv /usr/share/gnome-shell/extensions/ubuntu-dock@ubuntu.com/ /usr/share/gnome-shell/extensions-disabled/
* [Hide Activities Button](https://extensions.gnome.org/extension/744/hide-activities-button/)
* [OpenWeather](https://extensions.gnome.org/extension/750/openweather/)
* [Status Area Horizontal Spacing](https://extensions.gnome.org/extension/355/status-area-horizontal-spacing/)
* [User Themes](https://extensions.gnome.org/extension/19/user-themes/)

### Colors

* [atom/one-dark-syntax](https://github.com/atom/one-dark-syntax)
  * Background: #282C34
  * Text
    * mono-1:   #ABB2BF // default text
    * mono-2:   #828997 // darker text
    * mono-3:   #5C6370 // darkest text
  * Colors
    * cyan-light:   #94F3FF
    * cyan-dark:    #56B6C2
    * blue-light:   #94CFFF
    * blue-dark:    #61AFEF
    * purple-light: #E794FF
    * purple-dark:  #C678DD
    * green-light:  #C1FF94
    * green-dark:   #98C379
    * red-light:    #FF949D
    * red-dark:     #E06C75
    * orange-light: #FFC894
    * orange-dark:  #D19A66

* Gnome Terminal
  * Default Color Text:  #ABB2BF
  * Default Color Background: #282C34
  * Color 0:  #2E3436
  * Color 1:  #E06C75
  * Color 2:  #98C379
  * Color 3:  #D19A66
  * Color 4:  #61AFEF
  * Color 5:  #C678DD
  * Color 6:  #56B6C2
  * Color 7:  #D3D7CF
  * Color 8:  #555753
  * Color 9:  #FF949D
  * Color 10: #C1FF94
  * Color 11: #FFC894
  * Color 12: #94CFFF
  * Color 13: #E794FF
  * Color 14: #94F3FF
  * Color 15: #EEEEEC

### Frequently used commands

* Create ppk public key from rsa private key: `puttygen id_rsa -o id_rsa.pub.ppk`
* Find a dconf setting by key/value: `gsettings list-recursively | grep "VALUE"`
* Make wallpaper blurry: `convert -blur 0x30 in out`

Licensed under the [MIT](LICENSE) License.
