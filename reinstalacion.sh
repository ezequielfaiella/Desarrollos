#! /bin/bash
# instalacion del soft basico
	echo "Desea Instalar el Soft Basico?" "s para continuar"
	read p
if [ $p = s ]
then	
	sudo add-apt-repository ppa:synapse-core/testing
	sudo add-apt-repository ppa:libreoffice/ppa 
	sudo add-apt-repository ppa:simon-cadman/cups-cloud-print
	sudo add-apt-repository ppa:nemh/systemback
	sudo apt-add-repository -y ppa:teejee2008/ppa
	sudo apt-get update 
	sudo apt-get upgrade
	sudo apt-get install -q libreoffice libreoffice-l10n-es vlc rar unrar systemback cups-pdf homebank mutt lftp ntfs-config cupscloudprint synapse synaptic samba cifs-utils synapse wine ttf-mscorefonts-installer geany
	sudo /usr/share/cloudprint-cups/setupcloudprint.py conky-manager
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
# Desactivar notificaciones de informe de error
sudo sed -i s/enabled=1/enabled=0/g /etc/default/apport
echo "Se va a reiniciar el sistema"
sudo reboot now
