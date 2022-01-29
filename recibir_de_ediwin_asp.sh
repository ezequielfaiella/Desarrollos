#!/bin/bash
#~ exec >> /media/trabajo/Trabajo/scripts/recibir.log 2>&1

export DISPLAY=:0.0
#############################################################################################################################################
#	TIMEOUT. SE ESTABLECE UN TIEMPO X PARA QUE EL SCRIPT SE CIERRE SOLO
#############################################################################################################################################
source ~/.bash_aliases

Timeout=300 # 5 minutes

timeout_monitor() {
   sleep "$Timeout"
   #~ kill -15 "$1"
   #kill -15 $(ps aux | grep -v grep | grep [r]ecibir_de_ediwin_asp.sh | awk '{print $2}')
   #~ kill -15 $(ps aux | grep -v grep | grep "java -Xmx512m" | awk '{print $2}')
   #~ mv /media/trabajo/Trabajo/scripts/_recibir_de_ediwin_asp.sh /media/trabajo/Trabajo/scripts/recibir_de_ediwin_asp.sh
   #~ echo "Recibir se cerro por transcurrir mas de 4 minutos." && \
   echo -e $bold"El proceso de recepció se cerro por trancurrir más de 4 minutos sin haber terminado"$reset | mutt -s "Recepción de Documentos" -- grupoweme@gmail.com
   sh /media/trabajo/Trabajo/scripts/detener.sh
   }

# start the timeout monitor in
# background and pass the PID:


timeout_monitor "$$" &
Timeout_monitor_pid=$!

#############################################################################################################################################
#	COMIENZO DEL SCRIPT DE RECEPCION EN SI. REVISA QUE EL TAMAÑO DEL LOG NO SEA MAYOR A 1 MB, CREA UN ARCHIVO .LOCK PARA QUE SE EJECUTE
#	UNA SOLA VEZ, ESTA DENTRO DE UN TRAP PARA QUE ANTE UNA SALIDA BORRE TODO, NO CORRE SI ESTA FACTURANDO TAMPOCO, CREA LOS INFORMES Y
#	GUARDA TODO EN UN LOG. AHORA ESTA DESABILITADO LA COMPROBACION DE LA CONEXION A INTERNET
#############################################################################################################################################

# LIMITA EL TAMAÑO DEL ARCHIVO A 1MB
if [ $(wc -c <"/media/trabajo/Trabajo/scripts/recibir.log") -ge 1024000 ]; then
	cat /dev/null > /media/trabajo/Trabajo/scripts/recibir.log
fi

# crea un log con todo lo que sucede con la ejecucion
#________________
#exec 2>&1
#{

#set -e

scriptname=$(basename $0)
pidfile="/tmp/${scriptname}.pid"

#######################
# CUANDO RECIBE ALGUNA SEÑAL BORRA EL .PID
function finish {
  rm -rf "$pidfile"
  rm /media/trabajo/Trabajo/scripts/activo.log
  mv /media/trabajo/Trabajo/scripts/_recibir_de_ediwin_asp.sh /media/trabajo/Trabajo/scripts/recibir_de_ediwin_asp.sh
  date +"%e de %B de %Y a las %R" >> /media/trabajo/Trabajo/scripts/logbajado.txt
  find /media/trabajo/Trabajo/WEME/ASPEDI/PRODUCCION/ENTRADA/ -type f -iname *.txt -maxdepth 1 >> /media/trabajo/Trabajo/scripts/logbajado.txt
}
trap finish TERM EXIT KILL

#######################
FECHA=$(date +'%D %X')

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

						#~ rm /media/trabajo/Trabajo/scripts/activo.log
						# python3 /media/trabajo/Trabajo/scripts/haypedidos.py
						sh /media/trabajo/Trabajo/scripts/haypedidos.sh
						#~ cat /media/trabajo/Trabajo/scripts/informe.log | mutt -s "Pedidos" -- administracion@panificadoradelsur.com.ar


						echo -e $bold$red$(date +"%e de %B de %Y a las %R")$reset & echo -e $bold$green$(whoami)$reset

						date +"%e de %B de %Y a las %R" > /media/trabajo/Trabajo/scripts/cron.log
						echo $(whoami) >> /media/trabajo/Trabajo/scripts/cron.log

						mv /media/trabajo/Trabajo/scripts/_recibir_de_ediwin_asp.sh /media/trabajo/Trabajo/scripts/recibir_de_ediwin_asp.sh
						trap - INT TERM EXIT


#} |  tee -a /media/trabajo/Trabajo/scripts/recibir.log 2>&1
#date +"%e de %B de %Y a las %R" >> /media/trabajo/Trabajo/scripts/logbajado.txt
#find /media/trabajo/Trabajo/WEME/ASPEDI/PRODUCCION/ENTRADA/ -maxdepth 1 -type f -iname *.txt >> /media/trabajo/Trabajo/scripts/logbajado.txt

#############################################################################################################################################
#	FINALIZA EL SCRIPT DE RECEPCION. QUEDA PENDIENTE EL TIMEOUT
#############################################################################################################################################

# kill timeout monitor when terminating:
kill "$Timeout_monitor_pid"

#############################################################################################################################################
#	TERMINA EL TIMEOUT Y TODO EL PROCESO DE RECEPCION
#############################################################################################################################################
