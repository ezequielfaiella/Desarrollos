###################################################################################
# ESTA EL LA BASE A USAR PARA TODO SCRIPT. CREA UN LOG, DETIENE SI HAY ERROR Y 		#
# PERMITE UNA SOLA EJECUCION POR PC.	ADEMAS CREA UN DIR TEMPORAL QUE SE BORRA		#
# AL TERMINAR LA EJECUCUIN DEL MISMO																							#
###################################################################################

#!/bin/bash
export DISPLAY=:0.0
# SI HAY ERROR DETIENE EL SCRIPT
#~ set -x  # SE PUEDE PONER -ex PARA QUE ADEMAS MUESTRE EL COMANDO QUE EJECUTA

# BORRA EL ARCHIVO .PID CUANDO RECIBE ALGUNA DE LAS SEÑALES ESTABLECIDAS
# Y CREA UN DIR TEMPORAL QUE AL SALIR SE BORRA
	tmp=$(mktemp -d -t tmp.XXXXXXXXXX)
function finish {
	rm -rf "$tmp"
	rm -rf "$pidfile"
}
trap finish INT TERM EXIT

# ESTABLECE UN ARCHIVO PARA LIMITAR A UNA EJECUCION
scriptname=$(basename $0)
pidfile="/$tmp/${scriptname}.pid"
#pidfile="$dir/${scriptname}.pid"
dir=$(readlink -f "$0")

# BLOQUEA LA EJECUCION A UNA SOLA VEZ POR MAQUINA
exec 200> $pidfile
flock -n 200 || exit 1
pid=$$
echo $pid 1>&200

#################################################################################
# REVISA QUE ESTE INSTALADO EL PAQUETE NECESARIO
instalado unoconv

#################################################################################

# CREA UN LOG CON TODO LO QUE SUCEDE CON LA EJECUCION
# exec 2>&1
# {

###################################################################################
#                           INICIO DEL SCRIPT																			#
###################################################################################
#~ echo "Convirtiendo Archivos"
#~ notify-send "Convirtiendo Archivos"
cd /media/trabajo/Trabajo/WEME/exportacion/
# unoconv -d spreadsheet --format=ods spreadsheet.xls
sleep 2
#~ for i in *.xls; do
	#~ unoconv -d spreadsheet --format=ods $i
	#~ mv $i /media/trabajo/Trabajo/WEME/exportacion/basura/
#~ done
#~ for i in *.XLS; do
	#~ unoconv -d spreadsheet --format=ods $i
	#~ mv $i /media/trabajo/Trabajo/WEME/exportacion/basura/
#~ done
for FILE in *.XLS ; do mv $FILE `echo $FILE | tr '[A-Z]' '[a-z]'` ; done
for FILE in *.xls ; do mv $FILE `echo $FILE | tr '[A-Z]' '[a-z]'` ; done

###################################################################################
#                           FIN DEL SCRIPT		  																	#
###################################################################################

# } | tee -a $dir.log
