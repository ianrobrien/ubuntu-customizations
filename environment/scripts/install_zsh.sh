#!/usr/bin/env bash
#
# Installs oh-my-zsh with custom themes and powerline fonts

# Constants
readonly CUSTOM_THEMES_DIR=~/.oh-my-zsh/custom/themes
readonly OH_MY_ZSH_REPO_DIR=~/.oh-my-zsh
readonly OH_MY_ZSH_REPO_URL="https://github.com/robbyrussell/oh-my-zsh.git"
readonly POWERLINE_FONTS_REPO_URL="https://github.com/powerline/fonts.git"
readonly POWERLINE_FONTS_REPO_DIR=~/.powerline-fonts
readonly RESOURCES_CUSTOM_THEMES_DIR=./01_oh_my_zsh/themes/
readonly ZSH_BIN_LOCATION="/bin/zsh"
readonly ZSHRC_PROFILE=~/.zshrc
readonly ZSHRC_PROFILE_TEMPLATE=~/.oh-my-zsh/templates/zshrc.zsh-template

#######################################
# Gets the version of the operation system
# Returns:
#   Either: unknown; linux; windows.
#######################################
get_os_version() {
  local platform='unknown'
  local unamestr=$(uname)
  if [[ "${unamestr}" == 'Linux' ]]; then
    platform='linux'
  elif [[ "${unamestr}" == CYGWIN* ]]; then
    platform='windows'
  fi
  echo "${platform}"
}

#######################################
# Installs oh_my_zsh
#######################################
install_oh_my_zsh() {
  if [ -d "${OH_MY_ZSH_REPO_DIR}" ]; then
    rm -rf "${OH_MY_ZSH_REPO_DIR}"
  fi
  git clone "${OH_MY_ZSH_REPO_URL}" "${OH_MY_ZSH_REPO_DIR}"
  cp "${ZSHRC_PROFILE_TEMPLATE}" "${ZSHRC_PROFILE}"
  mkdir "${CUSTOM_THEMES_DIR}"
  cp "${RESOURCES_CUSTOM_THEMES_DIR}"* "${CUSTOM_THEMES_DIR}"
  sed -i -e 's/ZSH_THEME="robbyrussell"/ZSH_THEME="koselig"/g' "${ZSHRC_PROFILE}"
  chsh -s "${ZSH_BIN_LOCATION}"
}

#######################################
# Installs powerline fonts
#######################################
install_powerline_fonts() {  
  git clone "${POWERLINE_FONTS_REPO_URL}" "${POWERLINE_FONTS_REPO_DIR}"
 
  local os_version
  os_version=$(get_os_version) || return 
  case "${os_version}" in
    linux)
      ./"${POWERLINE_FONTS_REPO_DIR}"/install.sh
      ;;
    windows)
      local win_script_path=./"${POWERLINE_FONTS_REPO_DIR}"/install.ps1
      local win_install_path="$(cygpath -w "${win_script_path}")"
      powershell "${win_install_path}"
      ;;
    *)
      exit 1
      ;;
  esac
}

#######################################
# Main entry point for script
#######################################
main() {
  install_zsh
  install_powerline_fonts
}

main
