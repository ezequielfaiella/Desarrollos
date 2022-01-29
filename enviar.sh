###################################################################################
# ESTA EL LA BASE A USAR PARA TODO SCRIPT. CREA UN LOG, DETIENE SI HAY ERROR Y 		#
# PERMITE UNA SOLA EJECUCION POR PC.	ADEMAS CREA UN DIR TEMPORAL QUE SE BORRA		#
# AL TERMINAR LA EJECUCUIN DEL MISMO																							#
###################################################################################

#!/bin/bash
export DISPLAY=:0.0

# SI HAY ERROR DETIENE EL SCRIPT
#~ set -e  # SE PUEDE PONER -ex PARA QUE ADEMAS MUESTRE EL COMANDO QUE EJECUTA

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


# CREA UN LOG CON TODO LO QUE SUCEDE CON LA EJECUCION
exec 2>&1 
{

###################################################################################
#                           INICIO DEL SCRIPT																			#
###################################################################################
enviar (){
		echo "ENVIANDO $NUMFAC"
		scriptname="ENVIAR SII--EBI--JS (30711378355)"
		sleep 2
		#JNLP TEXTMODE VERSION
		java -Xmx512m -Xms128m -jar ebinetx.jar -noupdate -basedir $PWD -headless -property script="$scriptname" -property user.dir=$PWD -property user.log=log/ -property java.io.tmpdir=$PWD/tmp -property mode=CMD -properties ebiadapter.properties

		   }


cd /home/$USER/ASPEDI/

if [ $(wc -c <"/media/trabajo/Trabajo/scripts/tantasfacturas.log") -ge 1000000 ]; then
	cat /dev/null > /media/trabajo/Trabajo/scripts/tantasfacturas.log
fi

if ping -c1 asp18.sedeb2b.com &>/dev/null; then
				# hay conexion
					sleep 3
					NUMFAC=$(basename -a /media/trabajo/Trabajo/WEME/ASPEDI/PRODUCCION/SALIDA/cabfac_* | cut -c 8-19 ) #>> /$tmp/nfactura.txt
					ORDENDECOMPRA=$(cat /media/trabajo/Trabajo/WEME/ASPEDI/PRODUCCION/SALIDA/cabfac_*.txt | cut -c 940-956)
					PEDIDO=$(echo ${ORDENDECOMPRA}.txt)
					#~ notify-send "ENVIANDO FA $NUMFAC"
					echo "ENVIANDO FA $NUMFAC" > /media/trabajo/Trabajo/scripts/activo.log
					echo INICIO PROCESO
					enviar
					find /media/trabajo/Trabajo/WEME/ASPEDI/PRODUCCION/ENTRADA/pedidos/ -iname $PEDIDO -exec 7z a /media/trabajo/Trabajo/WEME/ASPEDI/PRODUCCION/ENTRADA/pedidos/pedidosviejos.7z {} \; -exec rm {} \;
					date
					export NUMFAC
					export ORDENDECOMPRA
					export PEDIDO
					
else 
	DISPLAY=:0 gdialog --title 'Enviar.sh' --msgbox '“No tienes conexion con el servidor. No se envian las facturas.”'
	echo '“Enviar.sh - No tienes conexion con el servidor. No se envian las facturas.”'
fi

###################################################################################
#                           FIN DEL SCRIPT		  																	#
###################################################################################

} | tee -a /media/trabajo/Trabajo/scripts/tantasfacturas.log
