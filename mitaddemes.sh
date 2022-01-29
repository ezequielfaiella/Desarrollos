# !/bin/bash

source /home/ezequiel/trabajo/Trabajo/scripts/automatizacion.sh
# source /media/trabajo/Trabajo/scripts/automatizacion.sh

entra_al_sistema
retenciones
sleep 2
salir

zip -Dj /media/trabajo/Trabajo/WEME/exportacion/estudio/informe.`date +%Y%m%d`.zip /media/trabajo/Trabajo/WEME/exportacion/estudio/*

cd /media/trabajo/Trabajo/WEME/exportacion/estudio/

echo "Adjunto retenciones de la quincena." | mail -s "Archivos de la quincena" -A informe.`date +%Y%m%d`.zip -- gabriela.barrera@estudiopesculich.com.ar grupoweme@gmail.com

find /media/trabajo/Trabajo/WEME/exportacion/estudio/ \( -name \*.txt -o -name \*.xls -o -name \*.zip \) -exec rm \{\} +
