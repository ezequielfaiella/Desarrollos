#! /bin/bash
sudo sysctl vm.swappiness=10
#sudo mount -t smbfs -o username=administrador,password=123,uid=ezequiel,gid=users //servidor/f/Trabajo /media/trabajo
sudo aptitude update  
sudo aptitude upgrade 
sudo aptitude dist-upgrade
sudo aptitude autoclean
sudo aptitude autoremove
sudo aptitude clean

