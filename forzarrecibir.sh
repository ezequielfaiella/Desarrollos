#!/bin/bash
export DISPLAY=:0.0
cd ~/ASPEDI

		scriptname="ENVIAR EBI--SII--JS (30711378355)"

		#JNLP TEXTMODE VERSION
		java -Xmx512m -Xms128m -jar ebinetx.jar -update 86400 -basedir $PWD -headless -property script="$scriptname" -property user.dir=$PWD -property user.log=log/ -property java.io.tmpdir=$PWD/tmp -property mode=CMD -properties ebiadapter.properties


		scriptname="ENVIAR EBI--SII--JS RETORNOS (30711378355)"

		#JNLP TEXTMODE VERSION
		java -Xmx512m -Xms128m -jar ebinetx.jar -update 86400 -basedir $PWD -headless -property script="$scriptname" -property user.dir=$PWD -property user.log=log/ -property java.io.tmpdir=$PWD/tmp -property mode=CMD -properties ebiadapter.properties

		pedidos=$(find -name 'CABPED_*' | wc -l)
		recepciones=$(find -name 'CABCRE*' | wc -l)
		notify-send "Se Descargaron "$pedidos" Pedidos"
		notify-send "Se Descargaron "$recepciones" Recepciones"
		date >> /media/trabajo/Trabajo/scripts/cron.log
#		echo tail -f /var/log/syslog | grep CRON >> /media/trabajo/Trabajo/scripts/cron.log
#		echo "Hay " $pedidos " pedidos y " $recepciones " recepciones">> /media/trabajo/Trabajo/scripts/informe.log
		echo "Hay " $pedidos " pedidos">> /media/trabajo/Trabajo/scripts/informe.log
		echo "Hay " $recepciones " recepciones">> /media/trabajo/Trabajo/scripts/informe.log
	
