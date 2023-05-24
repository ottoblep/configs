echo "Installing graphics packages..."
sudo apt install -y \
snapd \
chromium \
keepassxc \
thunderbird \
xournalpp \
speedcrunch
sudo snap install codium --classic
sudo snap install alacritty --classic
sudo snap install \
sleek \
drawio \
youtube-music-desktop-app

# VSCodium Plugins
codium --install-extension mhutchie.git-graph
codium --install-extension vscodevim.vim
codium --install-extension GitHub.github-vscode-theme
codium --install-extension PKief.material-icon-theme

#LRZ SnS
curl https://syncandshare.lrz.de/client_deployment/LRZ_Sync_Share_Latest_amd64.deb \
-o /tmp/LRZ_Sync_Share_Latest_amd64.deb
sudo apt install -y /tmp/LRZ_Sync_Share_Latest_amd64.deb

# Install PaperWM
mkdir ~/.local/PaperWM
# Branch depends on gnome version
# git clone https://github.com/paperwm/PaperWM -b gnome-3.38 ~/.local/PaperWM
# ~/.local/PaperWM/install.sh

# Alternatively this is a rolling release fork of PaperWM
git clone https://github.com/PaperWM-redux/PaperWM ~/.local/PaperWM
~/.local/PaperWM/install.sh

# Install other Gnome Shell Extensions
wget -O gnome-shell-extension-installer "https://github.com/brunelli/gnome-shell-extension-installer/raw/master/gnome-shell-extension-installer"
sudo chmod +x gnome-shell-extension-installer
sudo mv gnome-shell-extension-installer /usr/bin/
gnome-shell-extension-installer --yes 3960 # Transparent Top Bar
gnome-shell-extension-installer --yes 307 # Dash To Dock
gnome-shell-extension-installer --yes 1262 # Bing Wallpaper

# Import all gnome settings 
dconf reset -f /org/gnome/
cat ~/configs/gnome-dconf-dump.txt | dconf load /org/gnome/

# Example for Exporting and importing Gnome Extension settings
# EXPORT
# dconf dump /org/gnome/shell/extensions/ > dump.txt 
# IMPORT
# cat dump.txt | dconf load /org/gnome/shell/extensions/
# RESET
# dconf reset -f /org/gnome/shell/extensions/
