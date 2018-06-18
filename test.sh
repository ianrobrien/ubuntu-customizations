#!/usr/bin/env bash

echo "$XDG_DATA_DIRS" | grep -Eo 'xfce|kde|gnome'
