#!/bin/bash
sudo apt remove --purge zerotier-one
ssh-keygen
sudo rm /var/lib/zerotier-one/identity.secret
sudo rm /var/lib/zerotier-one/identity.public
#curl -s https://install.zerotier.com | sudo bash
sudo zerotier-cli join xxxxxxxxxxxxx

