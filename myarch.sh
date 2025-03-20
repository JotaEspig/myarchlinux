#!/bin/bash

# Check for sudo
if [ "$EUID" -ne 0 ]; then
    echo "Please run as sudo"
    exit
fi

pwd=$(pwd)
myarchlinuxdir=$(dirname `readlink -f $0`)
cd $myarchlinuxdir # Ensure we are in the correct directory

pacman -Sy archlinux-keyring --needed
pacman -Syyuu --needed

install_packages.sh

# Configure ZSH
chsh -s $(which zsh)
mkdir .zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

su $SUDO_USER << EOF
echo "source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" >> .zshrc
EOF

# Install Hack Nerd Font
su $SUDO_USER << EOF

cd /tmp
rm -rf hack
rm Hack.zip*

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Hack.zip
unzip Hack.zip -d hack
cd hack

if [ ! -d ~/.local/share/fonts ]; then
    mkdir ~/.local/share/fonts -p
fi

cp *.ttf ~/.local/share/fonts
fc-cache -f -v

EOF

cd $pwd

zsh
