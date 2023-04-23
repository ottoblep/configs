#!/usr/bin/env bash
# Needs to run with elevated privileges
# Setup a debian distro and run this anywhere

LAPTOP_MODE=false

# Fetch configs
# sudo apt install -y git
git clone https://github.com/ottoblep/configs /tmp/configs

# Depends on debian version
sudo echo "deb http://http.us.debian.org/debian stable contrib non-free" | sudo tee -a /etc/apt/sources.list
sudo echo "deb-src http://http.us.debian.org/debian stable contrib non-free" | sudo tee -a /etc/apt/sources.list
sudo echo "deb http://deb.debian.org/debian bullseye-backports main contrib non-free" | sudo tee -a /etc/apt/sources.list
sudo echo "deb http://deb.debian.org/debian bullseye-security main" | sudo tee -a /etc/apt/sources.list
sudo echo "deb http://deb.debian.org/debian bullseye-updates main" | sudo tee -a /etc/apt/sources.list

sudo apt update -y
sudo apt upgrade -y
sudo apt install -y \
curl \
git \
vim-gtk3 \
zoxide \
fzf \
snapd \
chromium \
keepassxc \
thunderbird \
xournalpp \
yt-dlp \
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

# Import configs
mkdir ~/.config
# Keep old bashrc append new
cp ~/.bashrc /tmp/.bashrc
cat /tmp/configs/home/.bashrc >> /tmp/.bashrc
cp -r /tmp/configs/home/* ~
cp /tmp/.bashrc ~/.bashrc
rm -rf /tmp/configs

# PGP / SSH Setup

if [ "$LAPTOP_MODE" = true ]; then
    # Laptop power settings / TLP
    sudo apt install -y tlp
    sudo cp /tmp/configs/etc/tlp.conf /etc/tlp.conf
    sudo systemctl enable tlp.service
    sudo systemctl start  tlp.service
fi

# Branch depends on gnome version
git clone https://github.com/paperwm/PaperWM -b gnome-3.38 ~/.local/PaperWM
~/.local/PaperWM/install.sh

# Gnome Shell Extensions
sudo wget -O gnome-shell-extension-installer "https://github.com/brunelli/gnome-shell-extension-installer/raw/master/gnome-shell-extension-installer"
chmod +x gnome-shell-extension-installer
sudo mv gnome-shell-extension-installer /usr/bin/