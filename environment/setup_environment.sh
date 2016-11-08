#!/usr/bin/env bash
platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
  platform='linux'
elif [[ "$unamestr" == CYGWIN* ]]; then
  platform='windows'
fi

# Execute Scripts in scripts directory
for script in ./scripts; do
  . ${script}
  echo ${script}
done
