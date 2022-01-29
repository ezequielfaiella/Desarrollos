#!/bin/bash
export DISPLAY=:0.0

# SI HAY ERROR DETIENE EL SCRIPT
set -e  # SE PUEDE PONER -ex PARA QUE ADEMAS MUESTRE EL COMANDO QUE EJECUTA

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

###################################################################################
#                           INICIO DEL SCRIPT																			#
###################################################################################
ARCHIVO=/tmp/listado.txt
[ -e $ARCHIVO ] && rm $ARCHIVO
for i in /media/trabajo/Trabajo/WEME/ASPEDI/PRODUCCION/ENTRADA/pedidos/*.txt; do
touch $ARCHIVO
basename $i >> $ARCHIVO
cat $i >> $ARCHIVO
echo " " >> $ARCHIVO
done
cat $ARCHIVO
###################################################################################
#                           FIN DEL SCRIPT		  																	#
###################################################################################
