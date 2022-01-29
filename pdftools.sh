#!/bin/bash
sudo add-apt-repository ppa:atareao/nemo-extensions
sudo apt-get update
sudo apt-get install nemo-pdf-tools
killall nemo
