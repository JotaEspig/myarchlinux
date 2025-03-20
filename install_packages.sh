#!/bin/bash

# Check for sudo
if [ "$EUID" -ne 0 ]; then
    echo "Please run as sudo"
    exit
fi

install_yay() {
    if [ command -v yay > /dev/null ]; then
        echo "yay already installed"
        return
    else
        echo "Installing yay..."
    fi

    cd /tmp
    sudo pacman -S --needed git base-devel
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    if [ command -v yay > /dev/null ]; then
        echo "yay installed successfully"
    else
        echo "yay installation failed"
        exit 1
    fi
}

pacman -S --noconfirm --needed $(cat pacman_packages.txt)

# Quits sudo
su $SUDO_USER << EOF
install_yay() 
EOF

yay -S --noconfirm --needed $(cat yay_packages.txt)
