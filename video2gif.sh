###################################################################################
# ESTA EL LA BASE A USAR PARA TODO SCRIPT. CREA UN LOG, DETIENE SI HAY ERROR Y 		#
# PERMITE UNA SOLA EJECUCION POR PC.	ADEMAS CREA UN DIR TEMPORAL QUE SE BORRA		#
# AL TERMINAR LA EJECUCUIN DEL MISMO																							#
###################################################################################

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

#################################################################################
# REVISA QUE ESTE INSTALADO EL PAQUETE NECESARIO
instalado() {
#Comprobamos si esta instalado el paquete wget mediante el comando aptitude
# aux=$(aptitude show p7zip-full | grep "Estado: instalado")
PROGRAMA=
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
instalado $1 &> /dev/null
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
#################################################################################

# CREA UN LOG CON TODO LO QUE SUCEDE CON LA EJECUCION
exec 2>&1
{

###################################################################################
#                           INICIO DEL SCRIPT																			#
###################################################################################

 
# video2gif.sh: convierte videos a gif animados
#

# Parametros ajustables ###################################
#
size="320x240"
fps=10                           #  < Cuadros por segundo.
destDir="$HOME/Imágenes/"        #  < Directorio donde se
                                 #    copiarán los gifs.
###########################################################


entrada=$1
archivo="${entrada%.[^.]*}"
ext="${entrada:${#archivo} + 1}"
cmdDelIn=""

# Leemos la entrada.
#
if [[ $2 == "-d" ]]
then
  cmdDelIn="rm -f $entrada"
fi

if [[ -z $1 ]]
then
  echo "Uso: video2gif.sh <video> [-d]"
  exit
fi


# La conversion, es necesario tener el paquete ImageMagic también.
#
avconv -i $archivo.$ext -pix_fmt rgb8 -s $size -r $fps $archivo-%05d.gif
convert -delay 1x$fps -loop 0 $archivo-*gif $archivo-tmp.gif
convert -layers Optimize $archivo-tmp.gif $archivo.gif


# Acomodamos los archivos y borramos el excedente.
#
mv $archivo.gif $archivo.gif.tmp
rm *.gif $cmdDelIn
$cmdDelIn
mv $archivo.gif.tmp $archivo.gif

if [ -d  $destDir ]
then
  mv $archivo.gif $destDir
fi

exit


###################################################################################
#                           FIN DEL SCRIPT		  																	#
###################################################################################

} | tee -a $dir.log
