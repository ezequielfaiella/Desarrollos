#! /bin/bash
sudo cd /usr/local/src/
sudo wget http://www.no-ip.com/client/linux/noip-duc-linux.tar.gz
sudo tar xf noip-duc-linux.tar.gz
sudo cd noip-2.1.9-1/
sudo make install

sudo /usr/local/bin/noip2 -C

# lanza el cliente
# /usr/local/bin/noip2


