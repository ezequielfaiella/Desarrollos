#! /bin/bash
#sudo sysctl vm.swappiness=10
sudo mount -t cifs -o username=ezequiel,password=123,uid=ezequiel,gid=users //192.168.1.6/Audio /media/audio
#sudo mount -t smbfs -o username=ezequiel,password=123,uid=ezequiel,gid=users smb://192.168.1.6/Audio /media/audio
#sudo mount -t cifs -o username=ezequiel,password=123,uid=ezequiel,gid=users smb://ls-wxl9c9/trabajo/Trabajo/Administracion /media/trabajo

