# Depends on debian version
echo "Updating sources..."
sudo echo "deb http://deb.debian.org/debian stable contrib non-free" | sudo tee -a /etc/apt/sources.list
sudo echo "deb-src http://deb.debian.org/debian stable stable contrib non-free" | sudo tee -a /etc/apt/sources.list
sudo echo "deb http://deb.debian.org/debian bullseye-security main" | sudo tee -a /etc/apt/sources.list
 sudo echo "deb http://deb.debian.org/debian bullseye-updates main" | sudo tee -a /etc/apt/sources.list
# sudo echo "deb http://deb.debian.org/debian stable bullseye-backports main contrib non-free" | sudo tee -a /etc/apt/sources.list

echo "Updating package database..."
sudo apt update -y
sudo apt upgrade -y
echo "Installing base packages..."
sudo apt install -y \
zsh \
curl \
git \
vim-gtk3 \
zoxide \
fzf \
yt-dlp

# Enable zsh
chsh -s $(which zsh)
# Install OhMyZsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh) --unattended" 

echo "Importing configs..."
cp -rT ~/configs/linux/home ~

# PGP / SSH Setup
# Manual

