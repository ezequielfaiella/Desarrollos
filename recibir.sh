###################################################################################
# ESTA EL LA BASE A USAR PARA TODO SCRIPT. CREA UN LOG, DETIENE SI HAY ERROR Y		#
# PERMITE UNA SOLA EJECUCION POR PC.	ADEMAS CREA UN DIR TEMPORAL QUE SE BORRA	#
# AL TERMINAR LA EJECUCUIN DEL MISMO												#
###################################################################################

#!/bin/bash +x
export DISPLAY=:0.0

# SI HAY ERROR DETIENE EL SCRIPT
# set -exv  # SE PUEDE PONER -ex PARA QUE ADEMAS MUESTRE EL COMANDO QUE EJECUTA -exv detalla todo lo q hace el script. NO PONER -E PORQUE DETIENE EL CONTEO CUANDO SE PRUEBA AL NO PODER BORRAR FACTURANDO TXT

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
cd /home/$USER/ASPEDI/

recibir (){
		echo "RECIBIENDO $NUMFAC ($X)"
		scriptname="ENVIAR EBI--SII--JS RETORNOS (30711378355)"
		sleep 2
		#JNLP TEXTMODE VERSION
		java -Xmx512m -Xms128m -jar ebinetx.jar -noupdate -basedir $PWD -headless -property script="$scriptname" -property user.dir=$PWD -property user.log=log/ -property java.io.tmpdir=$PWD/tmp -property mode=CMD -properties ebiadapter.properties

		   }

ret_error (){
	if [[ -n $(sed -n "/AFIP=No se ha podido obtener el CAE/p" /media/trabajo/Trabajo/WEME/ASPEDI/PRODUCCION/ENTRADA/RET_*${NUMFAC}.TXT) ]] ; then
		rm /media/trabajo/Trabajo/WEME/ASPEDI/PRODUCCION/ENTRADA/RET_*${NUMFAC}.TXT
	fi
	exit
	echo "Fallo al validar la factura en AFIP"
	DISPLAY=:0 gdialog --title 'Tantasfacturas.sh' --msgbox "Fallo al validar la factura en AFIP"
}
sleep 30
if netcat -z asp18.sedeb2b.com 9020 &>/dev/null; then
		# hay conexion
	X=1
			while [ ! -e /media/trabajo/Trabajo/WEME/ASPEDI/PRODUCCION/ENTRADA/RET_*${NUMFAC}.TXT ] ; do
				echo "RECIBIENDO FA $NUMFAC ($X)" > /media/trabajo/Trabajo/scripts/activo.log
				recibir
				ret_error
				date
				echo FIN PROCESO
				#~ [ $X -gt 4 ] && zenity guitool --info --text="Se ha reintentado $X veces y ha fallado. Deberia Revisar que sucede."
				[ $X -gt 4 ] && curl -s -X POST $URLT -d chat_id=$ID -d text="Se ha reintentado $X veces y ha fallado. Deberia Revisar que sucede."
				X=$((X+1))
				done
				
				sh /media/trabajo/Trabajo/scripts/renombrarfa.sh
			
				sh /media/trabajo/Trabajo/scripts/print.sh
else 
		gdialog --title 'Recibir.sh' --msgbox '“No tienes conexion con el servidor. No se puede recibir el retorno.”'
		echo '“No tienes conexion con el servidor. No se puede recibir el retorno.”'
fi

###################################################################################
#                           FIN DEL SCRIPT		  																	#
###################################################################################

} | tee -a /media/trabajo/Trabajo/scripts/tantasfacturas.log
