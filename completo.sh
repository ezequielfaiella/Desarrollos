# while : ; do echo "hola"; sleep 1; done

while : ; do
cd /media/trabajo/Trabajo/WEME/ASPEDI/

#ENVIOS COMIENZA ACA
scriptname="ENVIAR SII--EBI--JS (30711378355)"

#JNLP TEXTMODE VERSION
java -Xmx512m -Xms128m -jar ebinetx.jar -noupdate -basedir $PWD -headless -property script="$scriptname" -property user.dir=$PWD -property user.log=log/ -property java.io.tmpdir=$PWD/tmp -property mode=CMD -properties ebiadapter.properties


#RECEPCIONES COMIENZA ACA
scriptname="ENVIAR EBI--SII--JS (30711378355)"

#JNLP TEXTMODE VERSION
java -Xmx512m -Xms128m -jar ebinetx.jar -update 86400 -basedir $PWD -headless -property script="$scriptname" -property user.dir=$PWD -property user.log=log/ -property java.io.tmpdir=$PWD/tmp -property mode=CMD -properties ebiadapter.properties


scriptname="ENVIAR EBI--SII--JS RETORNOS (30711378355)"

#JNLP TEXTMODE VERSION
java -Xmx512m -Xms128m -jar ebinetx.jar -update 86400 -basedir $PWD -headless -property script="$scriptname" -property user.dir=$PWD -property user.log=log/ -property java.io.tmpdir=$PWD/tmp -property mode=CMD -properties ebiadapter.properties

sleep 1; done
#exit
