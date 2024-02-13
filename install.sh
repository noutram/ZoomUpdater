#!/bin/bash
#Initial install
killall zoom

echo "DOWNLOADING ZOOM"
wget https://zoom.us/client/latest/zoom_amd64.deb
echo "INSTALLING"
sudo dpkg -i ./zoom_amd64.deb
echo "TIDY UP"
rm  zoom_amd64.deb

#Update
cd systemd
sudo chmod +x zoom_update_sangha.sh
sudo chown root:root zoom_update_sangha.sh
echo "Check update script"
sudo ./zoom_update_sangha.sh

echo "Setting up daily update scripts"
sudo cp zoom_update_sangha.sh /opt/zoom
sudo cp zoom_update_sangha.service /etc/systemd/system/
sudo cp zoom_update_sangha.timer /etc/systemd/system/
#Permissions
sudo chmod 644 /etc/systemd/system/zoom_update_sangha.service
sudo chmod 644 /etc/systemd/system/zoom_update_sangha.timer
#Enable Services and Start
sudo systemctl enable zoom_update_sangha.timer
sudo systemctl start zoom_update_sangha.timer
