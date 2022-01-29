#!/bin/bash

rclone version &> /dev/null
if [ $? != 0 ] ; then
curl https://rclone.org/install.sh | sudo bash
#~ sudo add-apt-repository ppa:mmozeiko/rclone-browser
#~ sudo apt-get update
#~ sudo apt install rclone-browser
mkdir -p /home/$USER/.config/rclone/
#~ #cp /media/trabajo/Trabajo/scripts/rclone.conf /home/$USER/.config/rclone/
else
echo "rclone ya esta instalado"
fi

dpkg -s fuse &> /dev/null
if [ $? <> 0 ] ; then
sudo apt-get install fuse 
sudo sed -i -e '$a\allow-others' /etc/fuse.conf
sudo sed -i -e '$a\user_allow_other' /etc/fuse.conf
echo "fuse ya esta instalado"
fi

if [ -f /lib/systemd/system/rclone-mount.service ]; then
echo "ya esta creado el archivo rclone-mount"
else

cat <<'EOF' > /tmp/rclone-mount@.service

# Rclone mount on boot
# Copy file to: /lib/systemd/system
# You need to create a remote on RClone and a folder on your disk, both with same name <rclone-remote>
# This example uses /cloud/ folder as origin to mount all remotes, change it to your needs
# This example use a linux user named rclone. Create it or adapt it to your needs. Rclone will get config from that user's home folder
# Register new service by typing:
# sudo systemctl daemon-reload
# Do the next one for every remote you want to load on boot
# sudo systemctl enable rclone-mount@<rclone-remote>.service
# systemctl start rclone-mount@<rclone-remote>.service
# Usage:
# To unmount drive use
# systemctl stop rclone-mount@<rclone-remote>.service
# To mount use:
# systemctl start rclone-mount@<rclone-remote>.service
# To disable mount on boot use:
# systemctl disable rclone-mount@<rclone-remote>.service

[Unit]
Description=rclone FUSE mount for %i
Documentation=http://rclone.org/docs/
# After=network-online.target externo.mount
# Mount point in my system is on a USB drive, don't ask why :))), that's why I have to wait for it to get mounted
# Requires=externo.mount

[Service]
#Type=forking
# This example use a linux user named rclone. Create it or adapt it to your needs. Rclone will get config from that user's home folder
User=ezequiel
Group=ezequiel
# This example uses /cloud/ folder as origin to mount all remotes, change it to your needs
ExecStart=/usr/bin/rclone mount %i: /home/ezequiel/NAS/%i --vfs-cache-mode full -v --allow-other
ExecStop=/bin/fusermount -uz /home/ezequiel/NAS/%i

[Install]
#Wants=network-online.target
#Alias=rclone-rs
#RequiredBy=
WantedBy=multi-user.target

EOF
sudo mv /tmp/rclone-mount@.service /lib/systemd/system
fi


sudo systemctl daemon-reload

sudo systemctl enable rclone-mount@Box_Eze.service
sudo systemctl enable rclone-mount@Box_Administracion.service
#systemctl start rclone-mount@Box_Eze.service
#systemctl start rclone-mount@Box_Administracion.service
