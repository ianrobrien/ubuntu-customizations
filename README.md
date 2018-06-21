# ubuntu-customizations

This repository contains information and settings related to my general development environments

## Application Installs

* Editors
  * [Jetbrains Toolbox App](https://www.jetbrains.com/toolbox/app/)
  * [Visual Studio Code](https://code.visualstudio.com/)
* Utilities
  * [Beyond Compare](http://scootersoftware.com/download.php)

## Application Customizations

* dot files
* rc files
* bash prompt
* [How to make touch-screen scrolling work in Firefox Quantum?](https://askubuntu.com/questions/978226/how-to-make-touch-screen-scrolling-work-in-firefox-quantum)

## Gnome Customizations

* Appearance
  * Applications: [McOS-MJV-Dark-mode](https://github.com/paullinuxthemer/Mc-OS-themes)
  * Cursor: [Capitaine-cursors](https://github.com/keeferrourke/capitaine-cursors)
  * Icons: Papirus
  * Shell: [McOS-Dark-Shell](https://github.com/paullinuxthemer/Mc-OS-themes/tree/master/McOS-Shell-themes)
    * Requires [user-themes](https://extensions.gnome.org/extension/19/user-themes/) extension
* Behavior
  * Minimize on dock icon click
* Terminal - OneDark profile

### Colors

* [atom/one-dark-syntax](https://github.com/atom/one-dark-syntax)
  * Background: #282C34
  * Text
    * mono-1:   #ABB2BF // default text
    * mono-2:   #828997 // darker text
    * mono-3:   #5C6370 // darkest text
  * Colors
    * cyan-light:   #56B6C2
    * cyan-dark:    #39787F
    * blue-light:   #61AFEF
    * blue-dark:    #345D7F
    * purple-light: #C678DD
    * purple-dark:  #72457F
    * green-light:  #98C379
    * green-dark:   #98C379
    * red-light:    #E06C75
    * red-dark:     #7F3D43
    * orange-light: #D19A66
    * orange-dark:  #7F5E3E

### Frequently used commands

* Create ppk public key from rsa private key: puttygen id_rsa -o id_rsa.pub.ppk
* Find a dconf setting by key/value: gsettings list-recursively | grep "VALUE"

Licensed under the [MIT](LICENSE) License.
