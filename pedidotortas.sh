###################################################################################
# ESTA EL LA BASE A USAR PARA TODO SCRIPT. CREA UN LOG, DETIENE SI HAY ERROR Y 		#
# PERMITE UNA SOLA EJECUCION POR PC.	ADEMAS CREA UN DIR TEMPORAL QUE SE BORRA		#
# AL TERMINAR LA EJECUCUIN DEL MISMO																							#
###################################################################################

#!/bin/bash
export DISPLAY=:0.0

# SI HAY ERROR DETIENE EL SCRIPT
set -x  # SE PUEDE PONER -ex PARA QUE ADEMAS MUESTRE EL COMANDO QUE EJECUTA

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
instalado() {
#Comprobamos si esta instalado el paquete wget mediante el comando aptitude
# aux=$(aptitude show p7zip-full | grep "Estado: instalado")
PROGRAMA=libreoffice-calc
aux=$(dpkg --get-selections | grep "$PROGRAMA" | grep "install")
# if `echo "$aux" | grep "Estado: instalado" >/dev/null`
if `echo "$aux" | grep "install" >/dev/null`
then
return 1
else
return 0
fi
}
# llamamos a la funcion
instalado &> /dev/null
#Comprobamos el resultado... si da 1 es que esta instalado y si da 0 es que no esta instalado.
if [ "$?" = "1" ]
then
#Si el paquete esta instalado mando un mensaje
echo el paquete $aux ya esta instado.
#Si no estuviese instalado...por  ejemplo lo instalamos...
else
#sudo apt-get install leafpad
echo El paquete $aux no esta instalado
sudo apt-get install $PROGRAMA
fi

###################################################################################
#                           INICIO DEL SCRIPT																			#
###################################################################################
cd /home/$USER/
#~ cd /home/ezequiel/Escritorio/ejemploscalc/
pkill soffice
ARCHIVO=$(ls -Art rosario* | tail -n 1)
ARCHIVOPDF=`echo "$ARCHIVO" | cut -d'.' -f1`.pdf

#~ gs -sDEVICE=pdfwrite -dNOPAUSE -dQUIET -dBATCH -dFirstPage=m -dLastPage=n -sOutputFile=output.pdf input.pdf

# CON CARPETA TEMPORAL
[[ -e "${ARCHIVO}" ]] && libreoffice --headless --invisible --convert-to pdf --outdir $tmp "${ARCHIVO}" 
[[ -e $tmp/"${ARCHIVOPDF}" ]] && gs -sDEVICE=pdfwrite -dNOPAUSE -dQUIET -dBATCH -dFirstPage=8 -dLastPage=8 -sOutputFile=/home/$USER/PDF/Tortas.pdf $tmp/"${ARCHIVOPDF}"


# SIN CARPETA TEMPORAL
#~ [[ -e "${ARCHIVO}" ]] && libreoffice --headless --invisible --convert-to pdf "${ARCHIVO}"
#~ [[ -e "${ARCHIVOPDF}" ]] && gs -sDEVICE=pdfwrite -dNOPAUSE -dQUIET -dBATCH -dFirstPage=8 -dLastPage=8 -sOutputFile=/home/$USER/PDF/Tortas.pdf "${ARCHIVOPDF}"

###################################################################################
#                           FIN DEL SCRIPT		  									#
###################################################################################

