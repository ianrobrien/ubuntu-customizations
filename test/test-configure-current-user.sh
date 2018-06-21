#!/usr/bin/env bash
#
# Ian R. O'Brien
# https://gitlab.com/ianrobrien/ubuntu-customizations
#
# Usage: ./test-configure-current-user.sh

# Verify that the expected directories have been created
declare -a expected_directories=(
    "${HOME}/.themes/McOS-Dark-Shell"
    "${HOME}/.themes/McOS-MJV"
    "${HOME}/.themes/McOS-MJV-Dark-mode"
    "${HOME}/.icons/capitaine-cursors")

echo "[----------] Verifying ${#expected_directories[@]} directories succesfully created"
for dir in "${expected_directories[@]}"
do
    echo "[ Run      ] ${dir}"
    if [ ! -d "${dir}" ]; then
        echo "The directory ${dir} does not exist"
        echo "[  FAILED  ]"
        exit 1
    else
        echo "[       OK ] ${dir}"
    fi
done
echo "[----------]"

# Verify that the expected files have been created
declare -a expected_files=(
    "${HOME}/.local/share/fonts/RobotoCondensed-Regular.ttf")

echo "[----------] Verifying ${#expected_files[@]} files successfully created"
for file in "${expected_files[@]}"
do
    echo "[ Run      ] ${file}"
    if [ ! -f "${file}" ]; then
        echo "The file ${file} does not exist"
        echo "[  FAILED  ]"
        exit 1
    else
        echo "[       OK ] ${file}"
    fi
done
echo "[----------]"

echo "[----------] Verifying gsettings set successfully"
setting="org.gnome.desktop.interface cursor-theme"
echo "[ Run      ] ${setting}"
cursor_theme=`gsettings get ${setting}`
if [[ ${cursor_theme} != "'capitaine-cursors'" ]]; then
    echo "Cursor theme not correctly set"
    echo "[  FAILED  ]"
    exit 1
else
    echo "[       OK ] ${setting}"
fi
setting="org.gnome.desktop.wm.preferences theme"
echo "[ Run      ] ${setting}"
theme=`gsettings get ${setting}`
if [[ ${theme} != "'McOS-MJV-Dark-mode'" ]]; then
    echo "Theme not correctly set"
    echo "[  FAILED  ]"
    exit 1
else
    echo "[       OK ] ${setting}"
fi
setting="org.gnome.desktop.interface gtk-theme"
echo "[ Run      ] ${setting}"
gtk_theme=`gsettings get ${setting}`
if [[ ${gtk_theme} != "'McOS-MJV-Dark-mode'" ]]; then
    echo "Gtk-theme not correctly set"
    echo "[  FAILED  ]"
    exit 1
else
    echo "[       OK ] ${setting}"
fi
echo "[----------]"

echo "Current user configured successfully"
exit 0
