#! /bin/bash

FUENTE=~/fuente.sh
if [ -f $FUENTE ]; then
	source $FUENTE
else
	DISPLAY=:0 gdialog --msgbox "No se encuentra el archivo fuente en el HOME"
	#~ echo "No se encuentra el archivo fuente en el HOME"
	exit
fi

# -a : Esta opción combina el parámetro -r para que el recorra toda la estructura de directorios que le indiquemos, el -l para que copie enlaces
# simbólicos como enlaces simbólicos, la -p para que mantenga los permisos, la -t para que se mantenga la hora del fichero, la -g para que se
# mantenga el grupo, la -o para que se mantenga el propietario, la -D para que se mantengan los ficheros de dispositivo (sólo para root). Ni se
# mantienen los hard links (-H) ni las ACLs (-A) por defecto. En definitiva, con la opción -a obtenemos una copia exacta de una jerarquía de 
# ficheros y directorios.
#
# -v: es para que nos muestre información más detallada sobre lo que hace
#
# -W: copia archivo completo, no solo los cambios del mismo
#
# -z: comprime
#
# Efectivamente, /path/foo significa “el directorio foo“, mientras que /path/foo/ significa “lo que hay dentro de foo“. 
#
# --delete: En muchos casos, es posible que hayamos borrados ficheros de origen que ya no queremos que aparezcan en el destino, pero por defecto 
# rsync no los elimina. Para que lo haga, debemos usar la opción
#
# -n/--dry-run: para que el comando no haga nada en realidad y así podamos depurar el comando antes de ponerlo en funcionamiento definitivamente
#
# -u, para que no se sobreescriban los ficheros del destino que son más recientes que los del origen
#
# -r la sincronización se realizará recursivamente, haciendo un recorrido del origen y creando los subdirectorios necesarios en el destino
#
#
#NOTA IMPORTANTE de SINTAXIS de RSYNC: Cuando una ruta de directorio tiene un espacio en blanco, en la terminal escribimos
#
#$ cd directorio\ con\ espacios
#   usar la primera vez para crear los directorios
#
#cd /media
#sudo mkdir sync
#sudo chown ezequiel sync
#sudo chmod 0777 sync

# set -e					# es para controlar los errores. al primer error se detiene y termina el script
 #~ set -x					# escribe el comando que va a ejecutar
#sudo umount /media/trabajo

#~ exec >& >(tee -a /tmp/debog-install-depot-multisystem.txt)  ######## analizar para log!!!!!!!!!!!!!!

bold=$(tput bold)
green=$(tput setaf 2)
reset=$(tput sgr0)

sincronizar() {

if [ "$?" = "0" ]; then
	echo -e $bold$green "SINCRONIZANDO EN DISCO" $reset
	rsync -avzuh --no-whole-file --delete --exclude '.Trash-1000/' ${BACKUP} /home/ezequiel/Documentos/bckptrabajo #--progress
	cp $HOME/.config/rclone/rclone.conf /home/ezequiel/Documentos/bckptrabajo
	if [ $? -ne 0 ]; then
	echo -e $bold$green "No se pudo Sincronizar Trabajo en Disco local" $reset
	fi

	USB="/media/ezequiel/43C4E4D75A742EEE/"
	if [ -d $USB/bckptrabajo ]; then
		echo -e $bold$green "SINCRONIZANDO EN DISCO EXTERNO" $reset
		rsync -avzuh --no-whole-file --delete --progress --exclude '.Trash-1000/' --exclude 'Trabajo/scripts/.git/' ${BACKUP} $USB/bckptrabajo
		cp $HOME/.config/rclone/rclone.conf $USB/bckptrabajo
		if [ $? -ne 0 ]; then
		echo -e $bold$green "No se pudo Sincronizar al DISCO EXTERNO" $reset
		#~ DISPLAY=:0 gdialog --msgbox "No se pudo Sincronizar al DISCO EXTERNO"
		fi
	else
		echo -e $bold$green "No se pudo Sincronizar al DISCO EXTERNO (NO MONTADO)" $reset
		#~ DISPLAY=:0 gdialog --msgbox "No se pudo Sincronizar al DISCO EXTERNO (NO MONTADO)"		
	fi
	
		PENDRIVE="/media/ezequiel/9E4C84634C843853/"
	if [ -d $PENDRIVE/bckptrabajo ]; then
		echo -e $bold$green "SINCRONIZANDO EN PENDRIVE" $reset
		rsync -avzuh --no-whole-file --delete --progress --exclude '.Trash-1000/' --exclude 'Trabajo/scripts/.git/' ${BACKUP} $PENDRIVE/bckptrabajo
		cp $HOME/.config/rclone/rclone.conf $PENDRIVE/bckptrabajo
		if [ $? -ne 0 ]; then
		echo -e $bold$green "No se pudo Sincronizar al Pendrive" $reset
		#~ DISPLAY=:0 gdialog --msgbox "No se pudo Sincronizar al Pendrive"
		fi
	else
		echo -e $bold$green "No se pudo Sincronizar al Pendrive (NO MONTADO)" $reset
		#~ DISPLAY=:0 gdialog --msgbox "No se pudo Sincronizar al Pendrive (NO MONTADO)"		
	fi
	
		IPHONE="/home/ezequiel/Iphone/Downloads"
	if [ -d $IPHONE/bckptrabajo ]; then
		echo -e $bold$green "SINCRONIZANDO EN IPHONE" $reset
		rsync -avuh --no-whole-file --no-perms --delete --progress --exclude '.Trash-1000/' --exclude '/home/ezequiel/Documentos/bckptrabajo/SinUso/impresora.tar.gz' --exclude 'Trabajo/scripts/.git/' ${BACKUP} $IPHONE/bckptrabajo
		if [ $? -ne 0 ]; then
		echo -e $bold$green "No se pudo Sincronizar al IPHONE" $reset
		#~ DISPLAY=:0 gdialog --msgbox "No se pudo Sincronizar al IPHONE"
		fi
	else
		echo -e $bold$green "No se pudo Sincronizar al IPHONE (NO MONTADO)" $reset
		#~ DISPLAY=:0 gdialog --msgbox "No se pudo Sincronizar al IPHONE (NO MONTADO)"		
	fi
	
	#~ fusermount -u ${DIRTRABAJO2}
	#~ if [ $? -ne 0 ]; then
	#~ echo "No se pudo Desmontar Sync"
	#~ DISPLAY=:0 gdialog --msgbox "No se pudo Desmontar Sync"
	#~ fi

else
	echo -e $bold$green "No se pudo Hacer el Backup" $reset
		DISPLAY=:0 gdialog --msgbox "No se pudo Hacer el Backup"
fi

echo "********************************************"
echo
echo -e $bold$green "SINCRONIZANDO EN NUBE BOX.COM" $reset
rclone sync -v /media/backup/Trabajo/ Box_Administracion:/trabajo/Trabajo
echo -e $bold$green "SINCRONIZANDO EN NUBE YANDEX" $reset
rclone sync -v /media/backup/Trabajo/ Yandex:/bcktrabajo/

DISPLAY=:0 gdialog --msgbox "SINCRONIZACION EJECUTADA"
#~ espeak -ves+f2 -s150 -p80 "SINCRONIZACION LOCAL EJECUTADA"

ARCHIVO="/home/ezequiel/Documentos/bckptrabajo/back_config_eze"

date '+%Y%m%d' > $ARCHIVO

for i in /home/ezequiel/.bin/* /home/ezequiel/.bash_aliases /home/ezequiel/.bashrc /home/ezequiel/.bash_history /etc/hosts; do
	echo "----------------------'$i'---------------------------------" >> $ARCHIVO
	echo " ">> $ARCHIVO
	echo " ">> $ARCHIVO
	cat "$i" >> $ARCHIVO
	echo " ">> $ARCHIVO
done

}

log_file="/home/ezequiel/sync.logfile"
exec &> >(tee "$log_file")


#~ exec 1>~/sync.logfile 2>&1 

echo "********************************************"
date +"%A %F %R"

#~ fusermount -u /media/sync

#~ sudo mount -t cifs -o username=backup,password=666,uid=ezequiel,gid=users //192.168.2.3/Trabajo /media/sync

#							ESTADO=
#							if [ -d ${DIRTRABAJO2}/Administracion/ ];
#						#~ "Sí, sí existe."
#	
#							ESTADO=0
#							else
#							#~ "No, no existe"
#							ESTADO=1
#							fi
#							#~ echo $ESTADO
#
#							case $ESTADO in
#									#~ 0) fusermount -u ${DIRTRABAJO2}
#										sincronizar
										#~ sshfs -p77 administracion@192.168.2.3:/media/sda3/Trabajo /media/trabajo/Trabajo -oworkaround=rename
										#~ $LOCAL_COMPLETO
#										;;
#										
#									1) sincronizar
#										;;
#							esac
#~ rmdir ${DIRTRABAJO2}
#~ find /media/trabajo/Trabajo -type f -iname "*sync-conflict*" -exec mv {} -t "/home/ezequiel/sync-conflict/" \;
#~ find /media/trabajo/Trabajo -type f -iname "*sync-conflict*" -exec rm -f {} \;

#~ FECHA=$(date +'%Y%m%d')
#~ zip --delete /media/trabajo/Trabajo/backupsistema/$FECHA.ZIP /instalar/GARBAGE/\* /reparar/\* *.sync-conflict* -P avellaneda

mount /media/backup
sincronizar
umount /media/backup
exit
