#!/usr/bin/env bash
dotFilesDirectory="${PWD}/dot-files"

echo "Copying dot files to home directory..."

for file in ${dotFilesDirectory}/*
do
    echo "Copying ${file} to ${HOME}/.${file##*/}"
    cp ${file} ${HOME}/.${file##*/}
done

echo "Finished copying dot files to home directory."
echo "Sourcing .bashrc to pick up latest changes."
source ~/.bashrc
echo "Finished installing dot files."
