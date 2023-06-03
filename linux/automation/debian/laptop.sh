# Laptop power settings / TLP
sudo apt install -y tlp
sudo cp ~/configs/linux/etc/tlp.conf /etc/tlp.conf
sudo systemctl enable tlp.service
sudo systemctl start  tlp.service