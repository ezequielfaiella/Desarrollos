#!/bin/bash
#~ exec >> /media/trabajo/Trabajo/scripts/recibir.log 2>&1
export DISPLAY=:0.0

source ~/.bash_aliases

#############################################################################################################################################
#	COMIENZO DEL SCRIPT DE RECEPCION EN SI. REVISA QUE EL TAMAÑO DEL LOG NO SEA MAYOR A 1 MB, CREA UN ARCHIVO .LOCK PARA QUE SE EJECUTE
#	UNA SOLA VEZ, ESTA DENTRO DE UN TRAP PARA QUE ANTE UNA SALIDA BORRE TODO, NO CORRE SI ESTA FACTURANDO TAMPOCO, CREA LOS INFORMES Y
#	GUARDA TODO EN UN LOG. AHORA ESTA DESABILITADO LA COMPROBACION DE LA CONEXION A INTERNET
#############################################################################################################################################

# LIMITA EL TAMAÑO DEL ARCHIVO A 1MB
if [ $(wc -c <"/media/trabajo/Trabajo/scripts/recibir.log") -ge 1024000 ]; then
	cat /dev/null > /media/trabajo/Trabajo/scripts/recibir.log
fi


#set -e

scriptname=$(basename $0)
pidfile="/tmp/${scriptname}.pid"

# lock it
exec 250> $pidfile
flock -n 250 || exit 1
pid=$$
echo $pid 1>&250

lockfile=/media/trabajo/Trabajo/scripts/recibir_de_ediwin_asp.sh.lock



#######################
# CUANDO RECIBE ALGUNA SEÑAL BORRA EL .PID
function finish {
  rm -rf "$pidfile"
	rm /media/trabajo/Trabajo/scripts/activo.log
	rm lockfile
  mv /media/trabajo/Trabajo/scripts/_recibir_de_ediwin_asp.sh /media/trabajo/Trabajo/scripts/recibir_de_ediwin_asp.sh
  date +"%e de %B de %Y a las %R" >> /media/trabajo/Trabajo/scripts/logbajado.txt
  find /media/trabajo/Trabajo/WEME/ASPEDI/PRODUCCION/ENTRADA/ -type f -iname *.txt -maxdepth 1 >> /media/trabajo/Trabajo/scripts/logbajado.txt
}
trap finish TERM EXIT KILL

#######################
FECHA=$(date +'%D %X')

		while [ -f /media/trabajo/Trabajo/scripts/tantasfacturas.sh.lock ]; do
		exit 1
		notify-send "Esta Facturando. Se cancela la Recepcion"
		done

		# ESTE ES EL PROCESO DE RECEPCION. CREA EL ARCHIVO .LOCK PARA UNA SOLA EJECUCION Y REVISA QUE HAYA CONEXION
			if ( set -o noclobber; echo "$$" > "$lockfile") 2> /dev/null;
			then
			trap 'rm -f "$lockfile";mv /media/trabajo/Trabajo/scripts/_recibir_de_ediwin_asp.sh /media/trabajo/Trabajo/scripts/recibir_de_ediwin_asp.sh; exit $?' INT TERM EXIT

						echo $(whoami) > /media/trabajo/Trabajo/scripts/activo.log
						cd /home/$(whoami)/ASPEDI/
						mv /media/trabajo/Trabajo/scripts/recibir_de_ediwin_asp.sh /media/trabajo/Trabajo/scripts/_recibir_de_ediwin_asp.sh

						echo -e $bold$red$(date +"%e de %B de %Y a las %R")$reset & echo -e $bold$green$(whoami)$reset
						scriptname="ENVIAR EBI--SII--JS (30711378355)"

						#JNLP TEXTMODE VERSION
						java -Xmx512m -Xms128m -jar ebinetx.jar -update 86400 -basedir $PWD -headless -property script="$scriptname" -property user.dir=$PWD -property user.log=log/ -property java.io.tmpdir=$PWD/tmp -property mode=CMD -properties ebiadapter.properties

						echo -e $bold$red$(date +"%e de %B de %Y a las %R")$reset & echo -e $bold$green$(whoami)$reset
						scriptname="ENVIAR EBI--SII--JS RETORNOS (30711378355)"

						#JNLP TEXTMODE VERSION
						java -Xmx512m -Xms128m -jar ebinetx.jar -update 86400 -basedir $PWD -headless -property script="$scriptname" -property user.dir=$PWD -property user.log=log/ -property java.io.tmpdir=$PWD/tmp -property mode=CMD -properties ebiadapter.properties

						sh /media/trabajo/Trabajo/scripts/haypedidos.sh


						echo -e $bold$red$(date +"%e de %B de %Y a las %R")$reset & echo -e $bold$green$(whoami)$reset

						date +"%e de %B de %Y a las %R" > /media/trabajo/Trabajo/scripts/cron.log
						echo $(whoami) >> /media/trabajo/Trabajo/scripts/cron.log

				rm -f "$lockfile"
				mv /media/trabajo/Trabajo/scripts/_recibir_de_ediwin_asp.sh /media/trabajo/Trabajo/scripts/recibir_de_ediwin_asp.sh
				trap - INT TERM EXIT
			else

				e_error "ya hay otro proceso corriendo"

			fi
	break
	exit 0


date +"%e de %B de %Y a las %R" >> /media/trabajo/Trabajo/scripts/logbajado.txt
find /media/trabajo/Trabajo/WEME/ASPEDI/PRODUCCION/ENTRADA/ -maxdepth 1 -type f -iname *.txt >> /media/trabajo/Trabajo/scripts/logbajado.txt
