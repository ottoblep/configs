#!/usr/bin/env bash
# Setup a debian distro and run this anywhere

LAPTOP_MODE=false
VM_MODE=true

# Fetch configs
sudo apt install -y git
git clone https://github.com/ottoblep/configs ~/configs_tmp

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
zsh \
curl \
git \
vim-gtk3 \
zoxide \
fzf \
snapd \
yt-dlp \

# Enable zsh
chsh -s $(which zsh)
# Install OhMyZsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Importing configs..."

# Setup bashrc 
# cp -n ~/.bashrc ~/.bashrc_original
# cp ~/.bashrc_original ~/.bashrc
# cat ~/configs_tmp/home/.bashrc >> ~/.bashrc

# Setup zshrc
cp ~/configs_tmp/home/.zshrc ~/.zshrc

# Import configs
mkdir ~/.config
cp -rT ~/config_tmp/.config ~/.config

# PGP / SSH Setup
# Manual

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
    codium --install-extension mhutchie.git-graph
    codium --install-extension vscodevim.vim
    codium --install-extension GitHub.github-vscode-theme
    codium --install-extension PKief.material-icon-theme

    #LRZ SnS
    curl https://syncandshare.lrz.de/client_deployment/LRZ_Sync_Share_Latest_amd64.deb \
    -o /tmp/LRZ_Sync_Share_Latest_amd64.deb
    sudo apt install -y /tmp/LRZ_Sync_Share_Latest_amd64.deb
fi

if [ "$LAPTOP_MODE" = true ]; then
    # Laptop power settings / TLP
    sudo apt install -y tlp
    sudo cp ~/configs_tmp/etc/tlp.conf /etc/tlp.conf
    sudo systemctl enable tlp.service
    sudo systemctl start  tlp.service
fi

if [ "$VM_MODE" = false ]; then
    # PaperWM
    mkdir ~/.local/PaperWM
    # Branch depends on gnome version
    # git clone https://github.com/paperwm/PaperWM -b gnome-3.38 ~/.local/PaperWM
    # ~/.local/PaperWM/install.sh

    # Alternatively this is a rolling release fork of PaperWM
    git clone https://github.com/PaperWM-redux/PaperWM ~/.local/PaperWM
    ~/.local/PaperWM/install.sh

    # Import keybinds
    dconf reset -f /org/gnome/shell/extensions/paperwm/keybindings/
    cat ~/configs_tmp/paperwm-keybindings.txt | dconf load /org/gnome/shell/extensions/paperwm/keybindings/

    # Example for Exporting and importing PaperWM bindings
    # 
    # EXPORT
    # PREV_BINDINGS=paperwm-bindings-$(date +%F_%T).txt
    # dconf dump /org/gnome/shell/extensions/paperwm/keybindings/ > $PREV_BINDINGS
    # 
    # IMPORT
    # dconf reset -f /org/gnome/shell/extensions/paperwm/keybindings/
    # cat dwm-ish-bindings.txt | dconf load /org/gnome/shell/extensions/paperwm/keybindings/

    # Other Gnome Shell Extensions
    # sudo wget -O gnome-shell-extension-installer "https://github.com/brunelli/gnome-shell-extension-installer/raw/master/gnome-shell-extension-installer"
    # chmod +x gnome-shell-extension-installer
    # sudo mv gnome-shell-extension-installer /usr/bin/
    # Transparent Top Bar
    # Dash To Dock
    # Bing Wallpaper
fi

echo "Cleaning up..."
rm -rf ~/configs_tmp