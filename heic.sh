#!/bin/bash
#~ export DISPLAY=:0.0

# SI HAY ERROR DETIENE EL SCRIPT
#~ set -x  # SE PUEDE PONER -ex PARA QUE ADEMAS MUESTRE EL COMANDO QUE EJECUTA

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
PROGRAMA=libheif-examples
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
instalado $PROGRAMA &> /dev/null
#Comprobamos el resultado... si da 1 es que esta instalado y si da 0 es que no esta instalado.
if [ "$?" = "1" ]
then
#Si el paquete esta instalado mando un mensaje
echo el paquete $aux ya esta instado.
#Si no estuviese instalado...por  ejemplo lo instalamos...
else
#sudo apt-get install leafpad
echo El paquete $aux no esta instalado
sudo add-apt-repository ppa:strukturag/libheif
sudo apt-get update
sudo apt-get install $PROGRAMA
fi

renombrado(){
#~ #!/bin/bash
# By Ferux, 26 June 2016.
# Script for renaming photos and videos based on their date.
# Useful for watching slideshows with the videos at the moment they were shot instead of all at the end.
# Also useful for combining pictures of multiple sources into the correct order.
# For jpg's, the exif date 'taken on' will be used. If that's not found, the date of last change is used.
# For all other files, date of last change is used. Only following extensions are affected: mp4, mpg, png, avi, mov, jpg.

# To use this:
# 1. Put this text in a file named renamephotos
# 2. Make the file executable.
# 3. Put the file in the folder of which you want to rename the files.
# 4. Nautilus: File --> open in terminal.
# 5. In the terminal window, enter the following command: ./renamephotos

# Make the next one 'true' if you always want to add the original filename at the end of the new one.
# Otherwise the script will only do that if 2 files with the same name would be created.
preservefn="false"

for filename in *.*
do
  echo "$filename"
  tmp="$(echo "$filename" | tr '[A-Z]' '[a-z]')"
  case "$filename" in
    20*) 
      echo 'left alone because already starts with 20'
      ;;
    *.mp4|*.MP4)
      doelextensie=".mp4"
      wadissergebeurd="Video, used date of last change."
      newfilename="$(stat -c %y "$filename" | sed -e 's/\................//g' -e 's/-//g' -e 's/://g' -e 's/ /_/g')"
      if [ -a ""$newfilename""$doelextensie"" ] || [ "$preservefn" == "true" ]
      then
        mv -i "$filename" """$newfilename"_"$filename"""
        echo "$wadissergebeurd"
        echo 'Original name added at the end'
      else
        mv -i "$filename" ""$newfilename""$doelextensie""
        echo "$wadissergebeurd"
      fi
      ;;
    *.mpg|*.MPG)
      doelextensie=".mpg"
      wadissergebeurd="Video, used date of last change."
      newfilename="$(stat -c %y "$filename" | sed -e 's/\................//g' -e 's/-//g' -e 's/://g' -e 's/ /_/g')"
      if [ -a ""$newfilename""$doelextensie"" ] || [ "$preservefn" == "true" ]
      then
        mv -i "$filename" """$newfilename""_""$filename"""
        echo "$wadissergebeurd"
        echo 'Original name added at the end'
      else
        mv -i "$filename" ""$newfilename""$doelextensie""
        echo "$wadissergebeurd"
      fi
      ;;
    *.png|*.PNG)
      doelextensie=".png"
      wadissergebeurd="PNG, used date of last change."
      newfilename="$(stat -c %y "$filename" | sed -e 's/\................//g' -e 's/-//g' -e 's/://g' -e 's/ /_/g')"
      if [ -a ""$newfilename""$doelextensie"" ] || [ "$preservefn" == "true" ]
      then
        mv -i "$filename" """$newfilename""_""$filename"""
        echo "$wadissergebeurd"
        echo 'Original name added at the end'
      else
        mv -i "$filename" ""$newfilename""$doelextensie""
        echo "$wadissergebeurd"
      fi
      ;;
    *.avi|*.AVI)
      doelextensie=".avi"
      wadissergebeurd="Video, used date of last change."
      newfilename="$(stat -c %y "$filename" | sed -e 's/\................//g' -e 's/-//g' -e 's/://g' -e 's/ /_/g')"
      if [ -a ""$newfilename""$doelextensie"" ] || [ "$preservefn" == "true" ]
      then
        mv -i "$filename" """$newfilename""_""$filename"""
        echo "$wadissergebeurd"
        echo 'Original name added at the end'
      else
        mv -i "$filename" ""$newfilename""$doelextensie""
        echo "$wadissergebeurd"
      fi
      ;;
    *.mov|*.MOV)
      doelextensie=".mov"
      wadissergebeurd="Video, used date of last change."
      newfilename="$(stat -c %y "$filename" | sed -e 's/\................//g' -e 's/-//g' -e 's/://g' -e 's/ /_/g')"
      if [ -a ""$newfilename""$doelextensie"" ] || [ "$preservefn" == "true" ]
      then
        mv -i "$filename" """$newfilename""_""$filename"""
        echo "$wadissergebeurd"
        echo 'Original name added at the end'
      else
        mv -i "$filename" ""$newfilename""$doelextensie""
        echo "$wadissergebeurd"
      fi
      ;;
    *.JPG|*.jpg|*.jpeg|*.JPEG)
      newnametemp="$(exiftool -a -s -CreateDate "$filename")"
      doelextensie=".jpg"
      if [ -z "$newnametemp" ]
      then 
        wadissergebeurd="No exif date found, using last changed date"
        newfilename="$(stat -c %y "$filename" | sed -e 's/\................//g' -e 's/-//g' -e 's/://g' -e 's/ /_/g')"
        if [ -a ""$newfilename""$doelextensie"" ] || [ "$preservefn" == "true" ]
        then
          mv -i "$filename" """$newfilename"_"$filename"""
          echo "$wadissergebeurd"
          echo 'Original name added at the end'
        else
          mv -i "$filename" ""$newfilename""$doelextensie""
          echo "$wadissergebeurd"
        fi
      else
        newfilename="$(exiftool -a -s -CreateDate "$filename" | awk -F ': ' '{print $2}' | sed -e 's/://g' -e 's/ /_/g')"
        newfilename="$(echo $newfilename | cut -c 1-15)"
        wadissergebeurd="Date taken from exif info"
        if [ -a ""$newfilename""$doelextensie"" ] || [ "$preservefn" == "true" ]
        then
          mv -i "$filename" """$newfilename"_"$filename"""
          echo "$wadissergebeurd"
          echo 'Original name added at the end'
        else
          mv -i "$filename" ""$newfilename""$doelextensie""
          echo "$wadissergebeurd"
        fi
      fi
      ;;
    *)
      echo 'Not a *.jpg / *.png / *.mp4 / *.avi!'
      ;;
  esac
done
}


#################################################################################

# CREA UN LOG CON TODO LO QUE SUCEDE CON LA EJECUCION
exec 2>&1
{

###################################################################################
#                           INICIO DEL SCRIPT																			#
###################################################################################
for f in *.HEIC
do
echo "Working on file $f"
heif-convert $f $f.JPG
done
#~ renombrado
###################################################################################
#                           FIN DEL SCRIPT		  																	#
###################################################################################

} | tee -a $dir.log
