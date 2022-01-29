###################################################################################
# ESTA EL LA BASE A USAR PARA TODO SCRIPT. CREA UN LOG, DETIENE SI HAY ERROR Y 		#
# PERMITE UNA SOLA EJECUCION POR PC.	ADEMAS CREA UN DIR TEMPORAL QUE SE BORRA		#
# AL TERMINAR LA EJECUCUIN DEL MISMO																							#
###################################################################################

#!/bin/bash

# SI HAY ERROR DETIENE EL SCRIPT
#~ set -ex  # SE PUEDE PONER -ex PARA QUE ADEMAS MUESTRE EL COMANDO QUE EJECUTA

source ./fuente.sh source

#
#   sshfs ezequiel@192.168.2.67:/mnt/disk2/EzeNas ~/NAS
#
###################################################################################
#                           INICIO DEL SCRIPT						   			  #
###################################################################################
montarremoto(){
wget -a /tmp/ip.txt buffalonas.com/weme -O /tmp/weme
IPNAS=$(sed -n -e '/Ubicación/p' /tmp/ip.txt |  awk '{ print $2 }' | cut -d/ -f3 | cut -d: -f1)
echo $IPNAS
rm /tmp/ip.txt
rm /tmp/weme
#~ sshpass -p password 
sshfs -p2222 -o StrictHostKeyChecking=no root@$IPNAS:/mnt/disk2/EzeNas /home/ezequiel/NAS
}

montarcasa(){
sshfs -p2222 -o StrictHostKeyChecking=no root@$192.168.0.29:/mnt/disk2/EzeNas /home/ezequiel/NAS
}

desmontar(){
	sudo umount /home/ezequiel/NAS
}

##
## FABRICA MAC 3c:15:fb:5e:09:a9
## CASA MAC 
##
##

alta(){
MACWEME=$(/usr/sbin/arp -a | grep "192.168.100.1" |grep gateway | cut -c 29-46) #>> /home/ezequiel/Escritorio/mac.txt
MACCASA=$(/usr/sbin/arp -a | grep "192.168.0.1" |grep gateway | cut -c 29-46)

if MACCASA=""; then
	montarremoto
else
	montarcasa
fi
}
baja(){
	sudo umount /home/ezequiel/NAS
}

if [ "$1" != '' ]; then
	if [ "$1" = "alta" ]; then
		alta
	fi
	if [ "$1" = "baja" ]; then
		baja
	fi
else
	echo "debes escribir alta o baja"
fi

###################################################################################
#                           FIN DEL SCRIPT		  																	#
###################################################################################
