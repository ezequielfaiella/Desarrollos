# !/bin/bash
export DISPLAY=:0.0
# source /home/ezequiel/trabajo/Trabajo/scripts/automatizacion.sh
source /media/trabajo/Trabajo/scripts/automatizacion.sh

entra_al_sistema
ivacompras
sleep 2
cierra_ventana

ivaventas
sleep 2
cierra_ventana

deudores_gral
sleep 2
cierra_ventana

sleep 2
produccion
sleep 2
cierra_ventana

proveedores
sleep 2
cierra_ventana


salir

python3 unificar_datos_para_balance.py

zip -Dj /media/trabajo/Trabajo/Administracion/Varios/DatosBalance/balance_informe.`date +%Y%m%d`.zip /media/trabajo/Trabajo/WEME/exportacion/estudio/*

find /media/trabajo/Trabajo/WEME/exportacion/estudio/ \( -name \*.txt -o -name \*.xlsx -o -name \*.xls -o -name \*.zip \) -exec rm \{\} +