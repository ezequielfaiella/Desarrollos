# !/bin/bash
export DISPLAY=:0.0
source /home/ezequiel/trabajo/Trabajo/scripts/automatizacion.sh

entra_al_sistema
ivacompras
sleep 2
cierra_ventana
ivaventas
sleep 2
cierra_ventana
citycompras
sleep 2
cierra_ventana
cityventas
sleep 2
percepciones
sleep 2
retenciones
sleep 2
salir

zip -Dj /media/trabajo/Trabajo/WEME/exportacion/estudio/informe.`date +%Y%m%d`.zip /media/trabajo/Trabajo/WEME/exportacion/estudio/*

cd /media/trabajo/Trabajo/WEME/exportacion/estudio/

echo "Adjunto IVA compra/venta con los citi de cada uno, retenciones y percepciones." | mail -s "Archivos del mes" -A informe.`date +%Y%m%d`.zip -- grupoweme@gmail.com gabriela.barrera@estudiopesculich.com.ar 

find /media/trabajo/Trabajo/WEME/exportacion/estudio/ \( -name \*.txt -o -name \*.xls -o -name \*.zip \) -exec rm \{\} +