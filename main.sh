#!/bin/bash

aliases=(
    'ls="LC_COLLATE=C ls -la --color=auto --group-directories-first"'
    'agu="sudo apt-get update && sudo apt-get upgrade"'
    'agi="sudo apt-get install -y"'
    'gch="git checkout -B"'
    'gc="git add --all && git commit -am"'
    'ga="git commit --amend -C HEAD"'
    'gd="git diff --color-words"'
    'gr="git reset HEAD~1 --mixed"'
)

packages=(
    'man'
    'man-db'
    'manpages-dev'
    'tar'
    'gzip'
    'unzip'
    'curl'
    'wget'
    'git'
    'ssh'
    'gcc'
    'g++'
    'gdb'
    'make'
    'cmake'
    'libx11-dev'
    'python3'
    'python3-venv'
)

function silently_update_packages() 
{
    sudo apt-get update > /dev/null 2>&1
}

function silently_upgrade_packages()
{
    sudo apt-get upgrade -y > /dev/null 2>&1
}

function silently_install_package()
{
    sudo apt-get install -q -y "$1" > /dev/null 2>&1
}

function is_package_installed()
{
    sudo apt list --installed | grep -q "^$1/"
}

function setup_packages()
{
    if silently_update_packages; then
        echo "Successfully updated existing packages"
    else
        echo "Failed at updating exisiting packages"
        exit 1
    fi

    if silently_upgrade_packages; then
        echo "Successfully upgraded existing packages"
    else
        echo "Failed at upgraded exisiting packages"
        exit 1
    fi

    for package in "${packages[@]}"; 
    do
        if is_package_installed "$package"; then
            echo "Package has been already installed: $package" && continue
        fi

        if silently_install_package "$package"; then
            echo "Successfully installed package: $package"
        else
            echo "Failed at installing package: $package"
        fi
    done
}

function setup_aliases()
{
    path="$HOME/.bash_aliases"

    if [ ! -f "$path" ]; then
        touch "$path"
    fi

    for custom_alias in "${aliases[@]}"; do
        echo "alias $custom_alias" >> "$path"
    done
}

function main()
{
    setup_packages
    setup_aliases
}

main
