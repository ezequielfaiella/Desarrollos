#!/bin/bash

source /media/trabajo/Trabajo/scripts/automatizacion.sh

# echo -n "Ingrese la fecha del remito/factura: "
# read -a fecha

fecha=$(zenity --calendar \
               --title="Emision de Comprobantes" \
               --date-format='%d%m%Y' \
               --text="Elige la fecha del comprobante")
ans=$?
if [ $ans -eq 0 ]
then
    items=$((${#name[@]}*60))
    entra_al_sistema
    remitos
    emision_remito_martin
    cierra_ventana
    facturas
    emision_factura_martin
    cierra_ventana
    emision_comprobantes
    sleep 5
    salir
else
    exit
fi

