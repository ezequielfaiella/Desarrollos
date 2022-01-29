#!/bin/bash

swapon --show
sudo fallocate -l 2G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
swapon --show
sudo cp /etc/fstab /etc/fstab.back
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

#### resize ###

#sudo swapoff /swapfile
#sudo fallocate -l 1G /swapfile
#sudo mkswap /swapfile
#sudo swapon /swapfile

#### rremove ######

#sudo swapoff /swapfile
#sudo rm /swapfile