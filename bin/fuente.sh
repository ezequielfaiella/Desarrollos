#!/bin/bash
export DISPLAY=:0.0

##################################################
#  A COPIAR EN EL SCRIPT PARA LLAMAR A LA FUENTE
#~ FUENTE=~/fuente.sh
#~ if [ -f $FUENTE ]; then
	#~ source $FUENTE
#~ else
	#~ DISPLAY=:0 gdialog --msgbox "No se encuentra el archivo fuente en el HOME"
	#~ echo "No se encuentra el archivo fuente en el HOME"
	#~ exit
#~ fi
##################################################
# ARCHIVOS REFERENCIADOS:
# actualizaweme.sh - backupbsd.sh - backupbsdbalance.sh - completo.sh - conversion.sh - correos.sh - detener.sh
# edi.sh - envia_facturas.sh - enviar.sh - enviar_a_ediwin_asp.sh - facturas.sh - firmador.sh - forzarrecibir.sh
# forzartantasfacturas.sh - haypedidos.sh - inc.sh - inotify.sh - lockremove.sh - mail.sh - organizar.sh
# pausar.sh - print.sh - recepcion_pura.sh - recibir.sh - retenciones.sh - reparto.sh - servicios.sh - servicion2.sh
# sync.sh - tantasfacturas.sh - viernes.sh - vnc_multi.sh - xlstools.sh - weme.sh
# "locales" montar desmontar sync


# DIRECTORIO DE TRABAJO
export DIRTRABAJO1="/media/trabajo"						# ${DIRTRABAJO1}
#~ export DIRTRABAJO1="/home/ezequiel/33B9F6EF6195A4DA"				# ${DIRTRABAJO1}
export DIRTRABAJO2="${DIRTRABAJO1}/Trabajo/"  					# ${DIRTRABAJO2}
export TRABAJOADMIN="USB_TRABAJO" 	# ${TRABAJOADMIN}
export BACKUP="/media/backup/Trabajo/" 	# ${TRABAJOADMIN}

# DIRECTORIOS DE SATELITES           actualizaweme.sh
export EZESATELLITE=/home/ezequiel/.WEME/
export ADMINSATELLITE=/home/administracion/.WEME/

function arranque() {
if [ ! "$(ls -A /media/trabajo/Trabajo)" ]; then 
	gdialog --msgbox "Debe montar el directorio Trabajo antes de usarlo" 
	exit
fi
}

# conexiones
USUARIO_SSH=administracion
USUARIO_E=ezequiel
PASS_E=30363864
USUARIO_A=administracion
PASS_A=gratis123
IP_LOCAL=192.168.2.35
IP_REMOTO=wemedata.no-ip.info
#~ LOCAL_LECTURA="sshfs -p77 -o uid=1000 -o gid=1000 ${USUARIO_SSH}@${IP_LOCAL}:${TRABAJOADMIN} ${DIRTRABAJO2} -oworkaround=rename -o ro"
#~ REMOTO_LECTURA="sshfs -p77 -o uid=1000 -o gid=1000 ${USUARIO_SSH}@${IP_REMOTO}:${TRABAJOADMIN} ${DIRTRABAJO2} -oworkaround=rename -o ro"

#~ LOCAL_COMPLETO="sshfs -p77 -o uid=1000 -o gid=1000 ${USUARIO_SSH}@${IP_LOCAL}:${TRABAJOADMIN} ${DIRTRABAJO2} -oworkaround=rename"
#~ REMOTO_COMPLETO="sshfs -p77 -o uid=1000 -o gid=1000 ${USUARIO_SSH}@${IP_REMOTO}:${TRABAJOADMIN} ${DIRTRABAJO2} -oworkaround=rename"

LOCAL_COMPLETO="sudo mount.cifs -o username=${USUARIO_E},password=${PASS_E},rw //${IP_LOCAL}/${TRABAJOADMIN} ${DIRTRABAJO1}"
REMOTO_COMPLETO="sudo mount.cifs -o username=${USUARIO_E},password=${PASS_E},uid=${USUARIO_E},gid=users,rw //${IP_REMOTO}/${TRABAJOADMIN} ${DIRTRABAJO1}"
LOCAL_SYNCTHING="ln -s ${DIRTRABAJO1}/ /media/trabajo/Trabajo"


#~ sudo mount -t cifs -o username=ezequiel,password=30363864,uid=ezequiel,gid=users //192.168.2.35/PenBack /home/ezequiel/NAS

#~ fstab
#~ # DISCO RED
#~ //192.168.2.35/USB_TRABAJO /media/trabajo cifs credentials=/home/ezequiel/.smbcredentials,uid=ezequiel,iocharset=utf8,file_mode=0777,dir_mode=0777,noperm,noauto,user,rw 0 0
#~ #
#~ #DISCO RED BACKUP
#~ //192.168.2.35/USB_TRABAJO /media/backup cifs username=backup,password=666,uid=ezequiel,iocharset=utf8,noperm,noauto,user,ro 0 0
