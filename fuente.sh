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
#~ export DIRTRABAJO1="/home/ezequiel/Trabajo_OMV"				# ${DIRTRABAJO1}
export DIRTRABAJO2="${DIRTRABAJO1}/Trabajo/"  					# ${DIRTRABAJO2}
#~ export DIRTRABAJO2="${DIRTRABAJO1}/"  					# ${DIRTRABAJO2}
export TRABAJOADMIN="/home/ezequiel/trabajo" 	# ${TRABAJOADMIN}
export BACKUP="/media/backup/Trabajo/" 	# ${TRABAJOADMIN}

# DIRECTORIOS DE SATELITES           actualizaweme.sh
export EZESATELLITE=/home/ezequiel/.WEME/
export ADMINSATELLITE=/home/administracion/.WEME/

function arranque() {
#~ if [ ! "$(ls -A /media/trabajo/Trabajo)" ]; then 
if [ ! "$(ls -A ${DIRTRABAJO2})" ]; then 
	gdialog --msgbox "Debe montar el directorio Trabajo antes de usarlo (fuente)" 
	exit
fi
}

# conexiones
USUARIO_SSH=ezequiel
USUARIO_E=ezequiel
PASS_E=fayu4519
IP_LOCAL=192.168.100.10
IP_REMOTO=10.147.19.104

LOCAL_LECTURA="sshfs -p65 -o uid=1000 -o gid=1000 ${USUARIO_SSH}@${IP_LOCAL}:${TRABAJOADMIN} ${DIRTRABAJO1} -oworkaround=rename -o ro"
REMOTO_LECTURA="sshfs -p65 -o uid=1000 -o gid=1000 ${USUARIO_SSH}@${IP_REMOTO}:${TRABAJOADMIN} ${DIRTRABAJO1} -oworkaround=rename -o ro"

LOCAL_COMPLETO="sshfs -p65 -o uid=1000 -o gid=1000 ${USUARIO_SSH}@${IP_LOCAL}:${TRABAJOADMIN} ${DIRTRABAJO1} -oworkaround=rename -o rw"
REMOTO_COMPLETO="sshfs -p65 -o uid=1000 -o gid=1000 ${USUARIO_SSH}@${IP_REMOTO}:${TRABAJOADMIN} ${DIRTRABAJO1} -oworkaround=rename -o rw"

#~ LOCAL_COMPLETO="sudo mount.cifs -o username=${USUARIO_E},password=${PASS_E},rw //${IP_LOCAL}/${TRABAJOADMIN} ${DIRTRABAJO1}"
#~ REMOTO_COMPLETO="sudo mount.cifs -o username=${USUARIO_E},password=${PASS_E},uid=${USUARIO_E},gid=users,rw //${IP_REMOTO}/${TRABAJOADMIN} ${DIRTRABAJO1}"
LOCAL_SYNCTHING="ln -s ${DIRTRABAJO1}/ /media/trabajo/Trabajo"


#~ sudo mount -t cifs -o username=ezequiel,password=30363864,uid=ezequiel,gid=users //192.168.2.35/PenBack /home/ezequiel/NAS

#~ fstab
#~ # DISCO RED
#~ //192.168.2.35/USB_TRABAJO /media/trabajo cifs credentials=/home/ezequiel/.smbcredentials,uid=ezequiel,iocharset=utf8,file_mode=0777,dir_mode=0777,noperm,noauto,user,rw 0 0
#~ #
#~ #DISCO RED BACKUP
#~ //192.168.2.35/USB_TRABAJO /media/backup cifs username=backup,password=666,uid=ezequiel,iocharset=utf8,noperm,noauto,user,ro 0 0

TOKEN="802999301:AAFqDz2EMeyO0D8EtAP4AZkhfLuIGiqC3LQ"
ID="11729976"
URL="https://api.telegram.org/bot$TOKEN/sendMessage"


#~ export BASHBOT_HOME=/media/trabajo/Trabajo/scripts/telegram-bot-bash
#~ source ${BASHBOT_HOME}/bashbot.sh source

apiToken=$TOKEN

userChatId=$ID

send_t() {
        curl -s \
        -X POST \
        https://api.telegram.org/bot$apiToken/sendMessage \
        -d text="$1" \
        -d chat_id=$userChatId
}

r_telegram() {

curl -s \
  -X POST \
  https://api.telegram.org/bot$apiToken/getUpdates
}

send_mp3() {
curl -s -X POST "https://api.telegram.org/bot$apiToken/sendAudio" -F chat_id=$userChatId -F audio="@$1"
}
send_f() {
curl -s -X POST "https://api.telegram.org/bot"$apiToken"/sendPhoto" -F chat_id=$userChatId -F photo="@$1"
}

send_v() {
curl -s -X POST "https://api.telegram.org/bot"$apiToken"/sendVideo" -F chat_id=$userChatId -F video="@$1"
}
send_d() {
curl -s -X POST "https://api.telegram.org/bot"$apiToken"/sendDocument" -F chat_id=$userChatId -F document="@$1"
}

broadcast() {
	sh /media/trabajo/Trabajo/scripts/telegram-bot-bash/bashbot.sh broadcast "$1"
}
