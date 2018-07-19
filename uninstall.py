#!/usr/bin/python3
import os
import pathlib
import shutil


from setup import dotfiles

# Utility Methods


def is_root():
    return os.getuid() == 0


def query_yes_no(question, default="yes"):
    valid = {"yes": True, "y": True, "ye": True,
             "no": False, "n": False}
    if default is None:
        prompt = " [y/n] "
    elif default == "yes":
        prompt = " [Y/n] "
    elif default == "no":
        prompt = " [y/N] "
    else:
        raise ValueError(f"invalid default answer: '{default}'")

    while True:
        choice = input(question + prompt).lower()
        if default is not None and choice == '':
            return valid[default]
        elif choice in valid:
            return valid[choice]
        else:
            print("Please respond with 'yes' or 'no' (or 'y' or 'n').\n")


def main():
    if query_yes_no("Uninstall dot files?"):
        dotfiles.uninstall()


if __name__ == "__main__":
    main()
