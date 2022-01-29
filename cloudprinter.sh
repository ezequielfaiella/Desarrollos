#! /bin/bash
sudo add-apt-repository ppa:simon-cadman/cups-cloud-print
sudo apt-get update
sudo apt-get install -y cupscloudprint
sudo /usr/share/cloudprint-cups/setupcloudprint.py
