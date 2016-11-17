#!/usr/bin/env bash
#
# Installs fonts in Linux environments

# Constants
readonly FONTS_INSTALL_DIR=~/.local/share/fonts
readonly FONTS_RESOURCES_DIR=$(pwd)/../resources/fonts

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
# Installs the fonts into the users home directory
# and refreshes the font cache
#######################################
install_fonts() {
  mkdir -p "${FONTS_INSTALL_DIR}"
  shopt -s nocasematch
  for font in ${FONTS_RESOURCES_DIR}/*
  do
    if [[ "${font}" =~ [(\*.ttf|\*.otf)] ]]; then
        cp "${font}" "${FONTS_INSTALL_DIR}"
    fi
  done
  shopt -u nocasematch
  if command -v fc-cache @>/dev/null; then
    fc-cache -f "${FONTS_INSTALL_DIR}"
  fi
}

main() {
  local os_version
  os_version=$(get_os_version) || return
  if [[ "${os_version}" == "linux" ]]; then
    install_fonts
  else
    echo "Cannot install fonts. This script is only valid for Linux distributions."
  fi
}

main
