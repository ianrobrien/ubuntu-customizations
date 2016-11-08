#!/usr/bin/env bash
platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
  platform='linux'
elif [[ "$unamestr" == CYGWIN* ]]; then
  platform='windows'
fi

cd ~

mkdir ~/.profile.d
