#! /bin/bash
# instalacion del soft basico
	echo "Desea Instalar el Soft Basico?" "s para continuar"
	read p
if [ $p = s ]
then	
	sudo add-apt-repository ppa:synapse-core/testing
	sudo add-apt-repository ppa:libreoffice/ppa 
	#~ sudo add-apt-repository ppa:simon-cadman/cups-cloud-print
	sudo apt-get update 
	sudo apt-get upgrade
	sudo apt-get install libreoffice libreoffice-l10n-es vlc rar unrar cups-pdf homebank lftp sshfs ntfs-config synapse synaptic samba cifs-utils wine ttf-mscorefonts-installer geany # cupscloudprint
#	sudo /usr/share/cloudprint-cups/setupcloudprint.py
fi

#creacion de directorio trabajo
	echo "Desea Crear los Directorios de Trabajo?" "s para continuar"
	read p
if [ $p = s ]
then
	#echo "Introducir nombre de Usuario:"
	#read usuario
	#echo "Nombre de Usuario ingresado: $usuario"
	cd /media
	sudo mkdir trabajo
	sudo chown $USER trabajo
	sudo chmod 0777 trabajo
	sudo mkdir audio
	sudo chown $USER audio
	sudo chmod 0777 audio
fi

# instala el java de oracle
	echo "Desea Instalar Oracle Java?" "s para continuar"
	read p
if [ $p = s ]
then	
	sudo apt-get update && apt-get remove openjdk-*
	sudo apt-get autoremove && apt-get clean
	sudo add-apt-repository ppa:webupd8team/java
	sudo apt-get update
	sudo apt-get install oracle-java7-installer
fi

# cambia dash por bash
#sudo dpkg-reconfigure dash

# crea el archivo weme para ejecutarlo facil
	echo "Desea Copiar los Accesos y Configuraciones Basicas?" "s para continuar"
	read p
if [ $p = s ]
then
	sudo mount -t cifs -o username=admin,password=ironmaiden,uid=$USER,gid=users //192.168.1.6/Trabajo /media/trabajo
	sudo cp /media/trabajo/Trabajo/scripts/weme /usr/bin/
	sudo chmod +x /usr/bin/weme
	sudo cp /media/trabajo/Trabajo/scripts/.bashrc /home/$USER/
	sudo cp /media/trabajo/Trabajo/scripts/alta.sh /home/$USER/
	sudo cp /media/trabajo/Trabajo/scripts/baja.sh /home/$USER/
fi
echo "Se va a reiniciar el sistema"
# sudo reboot now
