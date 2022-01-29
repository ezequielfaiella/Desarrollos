#! /bin/bash
#~ set -x

RED='\033[0;41;30m'
STD='\033[0;0;39m'

repodebian() {
if [ $(lsb_release -si) = "Debian" ]; then
cat <<EOF > /tmp/sources.list

	###DEBIAN JESSIE ESTABLE###
	## Repositorio Oficial
		deb http://http.us.debian.org/debian/ jessie main contrib non-free
		deb-src http://http.us.debian.org/debian/ jessie main contrib non-free

	## Repositorio de Seguridad
		deb http://security.debian.org/ jessie/updates main contrib non-free
		deb-src http://security.debian.org/ jessie/updates main contrib non-free

	## Repositorio Multimedia
		# aptitude install deb-multimedia-keyring
	#    deb http://www.deb-multimedia.org testing main non-free
		deb http://www.deb-multimedia.org jessie main non-free
		deb-src http://www.deb-multimedia.org jessie main non-free
EOF
sudo mv /tmp/sources.list /etc/apt/sources.list
fi
}

software() {
	# instalacion del soft basico
		echo "Desea Instalar el Soft Basico?" "s para continuar"
		read p
	if [ $p = s ]
	then	
		[ $(uname -m) = "x86_64" ] && sudo dpkg --add-architecture i386
	#	sudo add-apt-repository ppa:synapse-core/testing
		sudo add-apt-repository ppa:libreoffice/ppa 
	#	sudo add-apt-repository ppa:simon-cadman/cups-cloud-print
		# sudo apt-add-repository -y ppa:teejee2008/ppa
		sudo apt-get update 
		sudo apt-get upgrade
	#	sudo apt-get install -y vlc rar unrar cups-pdf homebank sshfs synaptic samba wine ttf-mscorefonts-installer synapse geany git mutt gvfs-backends xournal inotify-tools openjdk-8-jre hplip-gui conky-manager gimp vinagre gtkpod mpv libsox-fmt-mp3
	#	libreoffice libreoffice-l10n-es lftp ntfs-config cupscloudprint cifs-utils      darktable gwenview rawtherapee shotwell vinagre synaptic
	#	sudo /usr/share/cloudprint-cups/setupcloudprint.py
		for pkg in vlc rar unrar cups-pdf sshfs wine-binfmt samba xdotool wine ttf-mscorefonts-installer stow git gvfs-backends inotify-tools openjdk-8-jre mpv libsox-fmt-mp3; do                   #  git homebank geany xournal synapse hplip-gui conky-manager gimp gtkpod  mutt
		sudo apt install -y $pkg
		done
		curl -s 'https://install.zerotier.com/' | sudo bash
		sudo zerotier-cli join 6ab565387a60d142
	fi
}

directorios() {
	#creacion de directorio trabajo
	echo "Desea Crear los Directorios de Trabajo?" "s para continuar"
	read p
	if [ $p = s ]
	then
		cd /media
		sudo mkdir -p trabajo
		sudo chown -R $USER trabajo
		sudo chmod -R 0777 trabajo
	fi
}

usabash() {
	# cambia dash por bash
	[ $(lsb_release -si) = "Ubuntu" ] && sudo dpkg-reconfigure dash
}

creacionarchivos() {
	# crea el archivo weme para ejecutarlo facil
		echo "Desea Crear los Accesos y Configuraciones Basicas?" "s para continuar"
		read p
	if [ $p = s ]
	then
		# aca ver como clonar el repositorio de git para bajar los archivos
		mkdir ~/.logs/
		mkdir ~/PDF/
		# mkdir ~/.dotfiles
		git clone 'https://gitlab.com/fayu/dotfiles.git'
	fi	 
}

impresora() {
	# crea el archivo de configuracion de impresora pdf
	echo "Desea Configurar la impresora pdf?" "s para continuar"
	read p
	if [ $p = s ]
	then
	cat <<EOF > /tmp/cups-pdf-renamer.sh
	#!/bin/bash
	#set -xv
	DIR="{HOME}/PDF"
	# CREA EL SCRIPT QUE CONTIENE EL RENOMBRADO
	echo '#!/bin/bash'>> /tmp/cups-pdf-renamer
	echo '#FILENAME=`basename $1`'>> /tmp/cups-pdf-renamer
	echo 'NOMBRE=`basename $1`'>> /tmp/cups-pdf-renamer
	echo 'FILENAME=` echo "$NOMBRE" | cut -d'.' -f1`'>> /tmp/cups-pdf-renamer
	echo 'DIRNAME=`dirname $1`'>> /tmp/cups-pdf-renamer
	echo 'DATE=`date +"%Y%m%d_%H%M%S"`'>> /tmp/cups-pdf-renamer
	echo 'mv $1 $DIRNAME"/"$FILENAME-$DATE".pdf"'>> /tmp/cups-pdf-renamer
	echo 'for FILE in /home/$user/PDF/FA* ; do NEWFILE2=`echo ${FILE:0:22}` ; mv $FILE $NEWFILE2 ; done'>> /tmp/cups-pdf-renamer
	echo 'for FILE in FA* ; do mv $FILE $FILE.pdf ; done'>> /tmp/cups-pdf-renamer

	# LO MUEVE A LA CARPETA CORRESPONDIENTE Y LE DA PERMISOS
	sudo mv /tmp/cups-pdf-renamer /usr/local/bin
	sudo chmod 755 /usr/local/bin/cups-pdf-renamer

	# ADAPTA EL ARCHIVO DE CONFIGURACION PARA QUE USE EL RENOMBRADOR Y CREA BACKUP
	sudo cp /etc/cups/cups-pdf.conf /etc/cups/cups-pdf.conf.original
	sudo cp /etc/apparmor.d/usr.sbin.cupsd /etc/apparmor.d/usr.sbin.cupsd.original
	#sudo sed -i "/cadena_a_buscar/cadena_nueva/g" fichero
	sudo sed -i "/#Label 0/Label 2/g" /etc/cups/cups-pdf.conf
	sudo sed -i "s%#PostProcessing%PostProcessing /usr/local/bin/cups-pdf-renamer%g" /etc/cups/cups-pdf.conf
	sudo sed -i "s%Out ${HOME}/PDF%Out $DIR%g" /etc/cups/cups-pdf.conf
	sudo sed -i "s%@{HOME}/PDF/%@$DIR/%g" /etc/apparmor.d/usr.sbin.cupsd
	sudo sed -i '$i /usr/local/bin/cups-pdf-renamer uxr,' /etc/apparmor.d/usr.sbin.cupsd
	sudo invoke-rc.d apparmor reload
	sudo /etc/init.d/cups restart
EOF
		sh /tmp/cups-pdf-renamer.sh
	fi
}

ssh() {
# crea la clave ssh
	echo "Desea Crear la clave SSH?" "s para continuar"
	read p
if [ $p = s ]
then
ssh-keygen -t rsa -b 4096 -o -a 100
fi
}

mutt() {
# crea la configuracion de mutt
	cat <<EOF > /home/$USER/.muttrc
		set from = "administracion@panificadoradelsur.com.ar";
		set realname = "Panificadora Del Sur";
		set imap_user = "administracion@panificadoradelsur.com.ar";
		set imap_pass = "gratis123";
		set folder = "imaps://imap.gmail.com:993";
		set spoolfile = "+INBOX";
		set postponed ="+[Gmail]/Drafts";
		set header_cache =~/.mutt/cache/headers;
		set message_cachedir =~/.mutt/cache/bodies;
		set certificate_file =~/.mutt/certificates;
		set move=no #para que no mueva los mensajes al salir
		set include=yes #para que incluya el mensaje recibido al responder
		set reply_to=yes
		set pager_index_lines=6
		set smtp_url = "smtp://administracion@panificadoradelsur.com.ar@smtp.gmail.com:587/";
		set smtp_pass = "gratis123";
EOF
}

cron() {
# crea el archivo de cron para las tareas de recibir etc...
if [ $USER = "administracion" ]; then
cat <<EOF > /tmp/administracion
	45 * * * * /home/administracion/sync.sh
	00 01 * * * export DISPLAY=:0 && /usr/local/bin/weme
	55 23 * * * pkill -15 weme
	30 01 * * * pkill -15 weme
	#30 15 * * 1,2,3,4,5,6 administracion /media/trabajo/Trabajo/scripts/reparto.sh
	00 19 * * * /media/administracion/FDD1-2B4A/Trabajo/scripts/backupbsd.sh
	30 19 * * * /media/administracion/FDD1-2B4A/Trabajo/scripts/inc.sh
	*/15 * * * * /media/administracion/FDD1-2B4A/Trabajo/scripts/recibir_de_ediwin_$
	#* * * * * administracion /media/trabajo/Trabajo/scripts/monitoreocasero.sh
	00 03 * * * /media/administracion/FDD1-2B4A/Trabajo/scripts/backupnas.sh
EOF
sudo mv /tmp/administracion /etc/cron.d/administracion
fi
}

cron_eze() {
# crea el archivo de cron para las tareas de recibir etc...
if [ $USER = "ezequiel" ]; then
cat <<EOF > /tmp/ezequiel
#*/5 * * * * ezequiel sh /media/trabajo/Trabajo/scripts/recibir_de_ediwin_asp.sh
* * * * * ezequiel sh /home/ezequiel/bateria.sh
#00 12 * * * sh ezequiel /media/trabajo/Trabajo/scripts/archivos_organizador.sh
EOF
sudo mv /tmp/ezequiel /etc/cron.d/ezequiel
fi
}

bin() {
# establece la carpeta .bin dentro del path para agregar ejecutables
	mkdir ~/.bin/
cat <<'EOF' >> $HOME/.profile
if [ -d "$HOME/.bin" ] ; then
    PATH="$HOME/.bin:$PATH"
fi
EOF
}

weme() {
# 	cat <<EOF > /home/$USER/.ssh/config
# Host admin
#     HostName 192.168.2.3
#     Port 77
#     User administracion

# Host adminremoto
# #    HostName wemedata.no-ip.info
#     HostName 10.147.19.13
#     Port 77
#     User administracion
# Host casa
#     HostName 192.168.2.66
#     Port 77
#     User ezequiel
# Host casaremoto
# #    HostName ezequiel.no-ip.info
#     HostName 10.147.19.161
#     Port 77
#     User ezequiel

# Host poweredge
#     HostName 10.147.19.104
#     Port 65

# EOF

#                           ?private_token=9u2zEG3zydkXgT2yXZbe
# crea la carpeta ASPEDI con los archivos
# 	echo "Desea Crear la carpeta ASPEDI?" "s para continuar"
# 	read p
# if [ $p = s ];
# then
# wget -c https://gitlab.com/fayu/scripts/raw/master/ASPEDI.tar.gz?private_token=9u2zEG3zydkXgT2yXZbe -O /tmp/ASPEDI.tar.gz
# tar -xzf /tmp/ASPEDI.tar.gz -C ~/
# rm /tmp/ASPEDI.tar.gz
# fi

# crea la carpeta .WEME en el escritorio
	echo "Desea Crear la carpeta .WEME?" "s para continuar"
	read p
if [ $p = s ];
then
#~ ESCRITORIO=$(grep XDG_DESKTOP_DIR ~/.config/user-dirs.dirs | cut -f2 -d \" | cut -f2 -d /)
# [ -d ~/$ESCRITORIO/.WEME ] || mkdir ~/.WEME
[ -d ~/.WEME ] || mkdir ~/.WEME
fi

# crea la carpeta .wine con los archivos
	echo "Desea Crear la carpeta .wine?" "s para continuar"
	read p
if [ $p = s ];
then
wget -c https://gitlab.com/fayu/scripts/raw/master/drive_c.tar.gz?private_token=9u2zEG3zydkXgT2yXZbe -O /tmp/drive_c.tar.gz
tar -xzf /tmp/drive_c.tar.gz -C ~/.wine/drive_c/
rm /tmp/drive_c.tar.gz
fi
}

# function to display menus
show_menus() {
	clear
	echo "~~~~~~~~~~~~~~~~~~~~~"	
	echo "	M E N U "
	echo "~~~~~~~~~~~~~~~~~~~~~"
	echo "1. Añadir Repositorios a Distribución DEBIAN"
	echo "2. Instalar el software Básico"
	echo "3. Crear Directorio Trabajo"
	echo "4. Cambiar Dash por Bash"
	echo "5. Crear los Archivos de Configuracion Básica"
	echo "6. Configurar Impresora PDF"
	echo "7. Crear Clave SSH"
	echo "8. Configurar Notificaciones por Correo"
	echo "9. Establecer las automatizaciones (Solo máquina ADMINISTRACION)"
	echo "10. Crear Carpeta Local de Ejecutables"
	echo "11. Crea las configuraciones necesarias para funcionar el Sistema de Gestión"
	echo "12. Establecer las automatizaciones (Solo máquina EZEQUIEL)"
	echo "13. TODO LO ANTERIOR (no cron)"
	echo "14. Exit"
}

read_options(){
	local choice
	read -p "Introduzca Opción [ 1 - 14] " choice
	case $choice in
		1) repodebian ;;
		2) software ;;
		3) directorios ;;
		4) usabash ;;
		5) bin;creacionarchivos ;;
		6) impresora ;;
		7) ssh ;;
		8) mutt ;;
		9) cron ;;
		10) bin ;;
		11) weme ;;
		12) cron_eze ;;
		13) usabash;repodebian;software;directorios;bin;creacionarchivos;impresora;ssh;mutt;weme ;;
		14) exit 0;;
		*) echo -e "${RED}Error...${STD}" && sleep 2
	esac
}
 
# ----------------------------------------------
# Step #3: Trap CTRL+C, CTRL+Z and quit singles
# ----------------------------------------------
trap '' SIGINT SIGQUIT SIGTSTP
 
# -----------------------------------
# Step #4: Main logic - infinite loop
# ------------------------------------
while true
do
	show_menus
	read_options
done
