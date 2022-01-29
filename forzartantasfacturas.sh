#! /bin/bash

function enviar {
                echo "ENVIANDO"
		touch /media/trabajo/Trabajo/scripts/facturando.txt
		scriptname="ENVIAR SII--EBI--JS (30711378355)"

		#JNLP TEXTMODE VERSION
		java -Xmx512m -Xms128m -jar ebinetx.jar -noupdate -basedir $PWD -headless -property script="$scriptname" -property user.dir=$PWD -property user.log=log/ -property java.io.tmpdir=$PWD/tmp -property mode=CMD -properties ebiadapter.properties

           }

function recibir {
		echo "RECIBIENDO"
		scriptname="ENVIAR EBI--SII--JS RETORNOS (30711378355)"

		#JNLP TEXTMODE VERSION
		java -Xmx512m -Xms128m -jar ebinetx.jar -noupdate -basedir $PWD -headless -property script="$scriptname" -property user.dir=$PWD -property user.log=log/ -property java.io.tmpdir=$PWD/tmp -property mode=CMD -properties ebiadapter.properties
			
           }


cd /home/$USER/ASPEDI/
# se verifica que el tamaño del log no sea mas de 1 mb o lo limpia
if [ $(wc -c <"/media/trabajo/Trabajo/scripts/tantasfacturas.log") -ge 1000000 ]; then
	cat /dev/null > /media/trabajo/Trabajo/scripts/tantasfacturas.log
fi
# crea el log
exec 2>&1 
{
# se fija si ya esta corriendo
if pidof -x $(basename $0) > /dev/null; then
  for p in $(pidof -x $(basename $0)); do
    if [ $p -ne $$ ]; then
      notify-send "El script $0 ya se está ejecutando. Saliendo..."
      exit
    fi
  done
fi
#

notify-send "Facturando"
#		PROCESO DE ENVIO Y RECEPCION FA
while [ -f /media/trabajo/Trabajo/WEME/ASPEDI/PRODUCCION/SALIDA/cabfac_*.txt ];
do
	if netcat -z asp18.sedeb2b.com 9020 &>/dev/null; then
	# hay conexion
	#este es el de enviar
	enviar
	# aca empieza el recibir
		x=0
		RET=(/media/trabajo/Trabajo/WEME/ASPEDI/PRODUCCION/ENTRADA/RET_*.TXT)
		while [ "$x" -lt 5 -a ! -e "${RET[0]}" ]; do				# hay un contador q suma en cada ejecucion hasta llegas a 10 y frena, o frena cuando aparece un ret*.txt
		x=$((x+1))
		recibir
		done	
	rm /media/trabajo/Trabajo/scripts/facturando.txt
	else 
	notify-send '“No tienes conexion con el servidor. NO se procede a facturar.”'
	fi
done
#		TERMINA PROCESO DE ENVIO Y RECEPCION FA
} | tee -a /media/trabajo/Trabajo/scripts/tantasfacturas.log
