#! /bin/bash
# set -x

enviar (){
		echo "ENVIANDO $NUMFAC"
		scriptname="ENVIAR SII--EBI--JS (30711378355)"
		sleep 2
		#JNLP TEXTMODE VERSION
		java -Xmx512m -Xms128m -jar ebinetx.jar -noupdate -basedir $PWD -headless -property script="$scriptname" -property user.dir=$PWD -property user.log=log/ -property java.io.tmpdir=$PWD/tmp -property mode=CMD -properties ebiadapter.properties

		   }

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

TOKEN="802999301:AAFqDz2EMeyO0D8EtAP4AZkhfLuIGiqC3LQ"
ID="11729976"
URLT="https://api.telegram.org/bot$TOKEN/sendMessage"

procesoenvioyrecepcion (){
#este es el de enviar
				if ping -c1 asp18.sedeb2b.com &>/dev/null; then
				# hay conexion
					sleep 3
					NUMFAC=$(basename -a /media/trabajo/Trabajo/WEME/ASPEDI/PRODUCCION/SALIDA/cabfac_* | cut -c 8-19 ) #>> /$tmp/pedido.txt
					ORDENDECOMPRA=$(cat /media/trabajo/Trabajo/WEME/ASPEDI/PRODUCCION/SALIDA/cabfac_*.txt | cut -c 940-956)
					PEDIDO=$(echo ${ORDENDECOMPRA}.txt)
					#~ notify-send "ENVIANDO FA $NUMFAC"
					echo "ENVIANDO FA $NUMFAC" > /media/trabajo/Trabajo/scripts/activo.log
					echo INICIO PROCESO
					enviar
					find /media/trabajo/Trabajo/WEME/ASPEDI/PRODUCCION/ENTRADA/pedidos/ -iname $PEDIDO -exec 7z a /media/trabajo/Trabajo/WEME/ASPEDI/PRODUCCION/ENTRADA/pedidos/pedidosviejos.7z {} \; -exec rm {} \;
					date
# aca empieza el recibir
# hay un contador q suma en cada ejecucion hasta llegas a 5 y frena, o frena cuando aparece un ret*.txt
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
						#~ mv /media/trabajo/Trabajo/WEME/ASPEDI/PRODUCCION/ENTRADA/RET_01${NUMFAC}.TXT /media/trabajo/Trabajo/WEME/ASPEDI/PRODUCCION/ENTRADA/RET/RET_01${NUMFAC}.TXT
						#~ mv /media/trabajo/Trabajo/WEME/ASPEDI/PRODUCCION/ENTRADA/RET_03${NUMFAC}.TXT /media/trabajo/Trabajo/WEME/ASPEDI/PRODUCCION/ENTRADA/RET/RET_03${NUMFAC}.TXT
				else
					DISPLAY=:0 gdialog --title 'Tantasfacturas.sh' --msgbox '“No tienes conexion con el servidor”'
					exit
				fi	
}
#~ retornofa=("/media/trabajo/Trabajo/WEME/ASPEDI/PRODUCCION/ENTRADA/RET_0"?${NUMFAC}.TXT)
#~ rm -f $retorno
USUARIO=$(who | awk '{print $1}'| head -1)
cd /home/$USUARIO/ASPEDI/

#~ mv /media/trabajo/Trabajo/scripts/recibir_de_ediwin_asp.sh /media/trabajo/Trabajo/scripts/_recibir_de_ediwin_asp.sh
if [ $(wc -c <"/media/trabajo/Trabajo/scripts/tantasfacturas.log") -ge 1000000 ]; then
	cat /dev/null > /media/trabajo/Trabajo/scripts/tantasfacturas.log
fi

# exec >> /media/trabajo/Trabajo/scripts/tantasfacturas.log 2>&1
export DISPLAY=:0.0

	lockfile=/media/trabajo/Trabajo/scripts/tantasfacturas.sh.lock

	if ( set -o noclobber; echo "$$" > "$lockfile") 2> /dev/null;
	then
	#~ trap 'rm -f "$lockfile";mv /media/trabajo/Trabajo/scripts/_recibir_de_ediwin_asp.sh /media/trabajo/Trabajo/scripts/recibir_de_ediwin_asp.sh; exit $?' INT TERM EXIT
	trap 'rm -f "$lockfile"; exit $?' INT TERM EXIT

#		PROCESO DE ENVIO Y RECEPCION FA
			if [ -f /media/trabajo/Trabajo/WEME/ASPEDI/PRODUCCION/SALIDA/cabfac_*.txt ];then

				procesoenvioyrecepcion

# TERMINA PROCESO DE ENVIO Y RECEPCION FA
#			Manda a Imprimir
				sh /media/trabajo/Trabajo/scripts/renombrarfa.sh
			
				sh /media/trabajo/Trabajo/scripts/print.sh
			fi
		date
	fi
	rm -f "$lockfile"
	trap - INT TERM EXIT
