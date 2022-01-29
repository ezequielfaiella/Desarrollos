#!/bin/bash
#~ sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
#~ sudo apt-add-repository 'deb https://apt.dockerproject.org/repo ubuntu-xenial main'
#~ sudo apt-get update
#~ sudo apt-get install -y docker-engine docker-compose
#~ sudo usermod -aG docker $(whoami)



# Parar todos los contenedores
#~ docker stop $(docker ps -a -q)

# Eliminar todos los contenedores
#~ docker rm $(docker ps -a -q)

# Eliminar todas las imágenes
#~ docker rmi $(docker images -q)

sudo apt-get remove docker docker-engine docker.io
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add --
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install docker-ce
sudo usermod -aG docker $USER

