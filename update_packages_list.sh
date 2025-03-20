#!/bin/bash

# Check for sudo
if [ "$EUID" -ne 0 ]; then
    echo "Please run as sudo"
    exit
fi

pacman -Qq > pacman_packages.txt
yay -Qq > yay_packages.txt
