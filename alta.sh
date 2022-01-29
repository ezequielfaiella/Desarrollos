#! /bin/bash
#sudo sysctl vm.swappiness=10
set -x
### sudo mount -t cifs -o username=ezequiel,password=xxxxxx,uid=$USER,gid=users,nounix,iocharset=utf8,rw //192.168.2.6/Trabajo /media/trabajo # NO PONER NOEXEC PORQUE DA ERROR
# sudo mount -t cifs -o username=ezequiel,password=xxxxx,uid=ezequiel,gid=users //192.168.2.6/Trabajo /media/trabajo
# sudo mount -t cifs -o credentials=~/.smbcredentials,uid=ezequiel,gid=users //192.168.2.6/Trabajo /media/trabajo
# sudo mount -t cifs -o username=admin,password=xxxxxxx,uid=ezequiel,gid=users //192.168.2.6/Audio /media/audio
### sshfs ezequiel@192.168.2.6:/mnt/disk1/Trabajo /media/trabajo
echo xxxx | sshfs ezequiel@192.168.2.6:/mnt/disk1/Trabajo /media/trabajo -o password_stdin -oworkaround=rename  -o uid=1000 -o gid=1000 
#    sshfs ezequiel@192.168.2.6:/mnt/disk1/Audio /media/audio
#
### echo xxxxxx | sshfs ezequiel@wemedata.no-ip.info:/mnt/disk1/Trabajo /media/trabajo -o password_stdin -oworkaround=rename
# sshfs admin@wemedata.no-ip.info:/mnt/disk1/Trabajo /media/trabajo

#sudo curlftpfs ftp://admin:ironmaiden@wemedata.no-ip.info:21/disk1/Trabajo /media/trabajo

# host para sacar la ip de wemeserver......
# esto te guarda en ip.txt la ip
#host wemeserver.no-ip.info | cut  -c 34-48 >> ip.txt
# te da la mac de 192.168.1.1
# /usr/sbin/arp -a | grep "192.168.1.1" | cut -c 30-46 >> /home/ezequiel/Escritorio/mac.txt

if ps waux | grep -v grep | grep /home/$USER/servicios.sh
then
		notify-send "Los Servicios ya se estan monitoreando"
else
		notify-send "Los Servicios NO se estan monitoreando"
		sh /home/$USER/servicios.sh &
fi

#~ if ps waux | grep -v grep | grep /home/$USER/correos.sh
#~ then
		#~ notify-send "El correo ya se esta monitoreando"
#~ else
		#~ notify-send "El correo NO se esta monitoreando"
		#~ sh /home/$USER/correos.sh &
#~ fi

#~ if ps waux | grep -v grep | grep /home/$USER/facturas.sh
#~ then
		#~ notify-send "La facturacion ya se esta monitoreando"
#~ else
		#~ notify-send "La facturacion NO se esta monitoreando"
		#~ sh /home/$USER/facturas.sh &
#~ fi
#sleep 5
exit




#[ "$(ls -A /path/to/directory)" ] && echo "Not Empty" || echo "Empty"
#[ "$(ls -A ~/tmp)" ] && fusermount -u ~/tmp || sshfs casainterno:/ ~/tmp -oworkaround=rename

