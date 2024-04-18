#!/bin/bash

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

function get_packages()
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

function main()
{
    get_packages
}

main
