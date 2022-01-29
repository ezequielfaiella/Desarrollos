#! /bin/bash
cd /media/trabajo/Trabajo/WEME/ASPEDI/
echo ¿Cantidad de Facturas?
read total
contador=0
#fin=total; export fin
while [ $contador -le $total ]
do
#este es el de enviar
echo "ENVIANDO"

scriptname="ENVIAR SII--EBI--JS (30711378355)"

#JNLP TEXTMODE VERSION
java -Xmx512m -Xms128m -jar ebinetx.jar -update 86400 -basedir $PWD -headless -property script="$scriptname" -property user.dir=$PWD -property user.log=log/ -property java.io.tmpdir=$PWD/tmp -property mode=CMD -properties ebiadapter.properties

#	sleep 10s
# aca empieza el recibir
echo "RECIBIENDO"

scriptname="ENVIAR EBI--SII--JS RETORNOS (30711378355)"

#JNLP TEXTMODE VERSION
java -Xmx512m -Xms128m -jar ebinetx.jar -update 86400 -basedir $PWD -headless -property script="$scriptname" -property user.dir=$PWD -property user.log=log/ -property java.io.tmpdir=$PWD/tmp -property mode=CMD -properties ebiadapter.properties
#	sleep 10s
	let contador=contador+1
        echo $contador
	echo NUEVO PROCESO
done
