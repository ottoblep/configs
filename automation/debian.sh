#!/usr/bin/env bash
# Needs to run with elevated privileges
# Setup a debian distro and run this anywhere

LAPTOP_MODE=false
VM_MODE=true

# Fetch configs
# sudo apt install -y git
git clone https://github.com/ottoblep/configs ~/configs

# Depends on debian version
echo "Updating sources..."
sudo echo "deb http://http.us.debian.org/debian stable contrib non-free" | sudo tee -a /etc/apt/sources.list
sudo echo "deb-src http://http.us.debian.org/debian stable contrib non-free" | sudo tee -a /etc/apt/sources.list
sudo echo "deb http://deb.debian.org/debian bullseye-backports main contrib non-free" | sudo tee -a /etc/apt/sources.list
sudo echo "deb http://deb.debian.org/debian bullseye-security main" | sudo tee -a /etc/apt/sources.list
sudo echo "deb http://deb.debian.org/debian bullseye-updates main" | sudo tee -a /etc/apt/sources.list

echo "Updating package database..."
sudo apt update -y
sudo apt upgrade -y
echo "Installing base packages..."
sudo apt install -y \
curl \
git \
vim-gtk3 \
zoxide \
fzf \
snapd \
yt-dlp \

if [ "$VM_MODE" = false ]; then
    echo "Installing graphics packages..."
    sudo apt install -y \
    chromium \
    keepassxc \
    thunderbird \
    xournalpp \
    speedcrunch \
    sudo snap install codium --classic
    sudo snap install alacritty --classic
    sudo snap install \
    sleek \
    drawio \
    youtube-music-desktop-app \

    # VSCodium Plugins
    codium --install-extension \
    mhutchie.git-graph \
    vscodevim.vim \
    GulajavaMinistudio.mayukaithemevsc \
    ddiu8081.moegi-theme \

    #LRZ SnS
    curl https://syncandshare.lrz.de/client_deployment/LRZ_Sync_Share_Latest_amd64.deb \
    -o /tmp/LRZ_Sync_Share_Latest_amd64.deb
    sudo apt install -y /tmp/LRZ_Sync_Share_Latest_amd64.deb
fi


echo "Importing config..."
# Import configs
mkdir ~/.config
# Keep old bashrc append new
cp ~/.bashrc /tmp/.bashrc
cat ~/configs/home/.bashrc >> /tmp/.bashrc
cp -a ~/configs/home/. ~ 
cp /tmp/.bashrc ~/.bashrc

# PGP / SSH Setup

if [ "$LAPTOP_MODE" = true ]; then
    # Laptop power settings / TLP
    sudo apt install -y tlp
    sudo cp ~/configs/etc/tlp.conf /etc/tlp.conf
    sudo systemctl enable tlp.service
    sudo systemctl start  tlp.service
fi

if [ "$VM_MODE" = false ]; then
    # Branch depends on gnome version
    git clone https://github.com/paperwm/PaperWM -b gnome-3.38 ~/.local/PaperWM
    ~/.local/PaperWM/install.sh

    # Gnome Shell Extensions
    sudo wget -O gnome-shell-extension-installer "https://github.com/brunelli/gnome-shell-extension-installer/raw/master/gnome-shell-extension-installer"
    chmod +x gnome-shell-extension-installer
    sudo mv gnome-shell-extension-installer /usr/bin/
fi

echo "Cleaning up..."
rm -rf ~/configs