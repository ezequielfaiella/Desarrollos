#!/bin/bash
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 4773BD5E130D1D45
#~ sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0DF731E45CE24F27EEEB1450EFDC8610341D9410
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt update && sudo apt install spotify-client
echo -e "\n\
0.0.0.0 pubads.g.doubleclick.net\n\
0.0.0.0 securepubads.g.doubleclick.net\n\
0.0.0.0 gads.pubmatic.com\n\
0.0.0.0 ads.pubmatic.com\n\
0.0.0.0 spclient.wg.spotify.com" >> sudo /etc/hosts
