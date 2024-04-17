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
	'ssh-keygen'
	'gcc'
	'g++'
	'gdb'
	'make'
	'cmake'
	'libx11-dev'
	'python3'
	'python3-venv'
)

function silently_update_existing_packages() {
	sudo apt-get update -y > /dev/null 2>&1

	if [ $? -eq 0 ]; then
		echo "Successfully updated existing packages"
	else
		echo "Failed at updating exisiting packages"
		exit 1
	fi

	sudo apt-get upgrade -y > /dev/null 2>&1

	if [ $? -eq 0 ]; then
		echo "Successfully upgraded existing packages"
	else
		echo "Failed at upgraded exisiting packages"
		exit 1
	fi
}

function silently_install_package() {
	package="$1"
	
	sudo apt-get install -q -y "$package" > /dev/null 2>&1

	if [ $? -eq 0 ]; then
		echo "Successfully installed package: $package"
	else
		echo "Failed at installing package: $package"
		exit 1
	fi
}

function main() {
	silently_update_existing_packages

	for package in "${packages[@]}"; do
		silently_install_package "$package"
	end
}

main
