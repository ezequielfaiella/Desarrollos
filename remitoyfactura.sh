#!/bin/bash
source /media/trabajo/Trabajo/scripts/automatizacion.sh

# echo -n "Ingrese los numeros de sucursales separados por espacio y enter para terminar: "
# read -a name

####################################################################################################
if [ -f /tmp/2.txt ]; then rm /tmp/2.txt; fi

tiendas="/media/trabajo/Trabajo/WEME/ASPEDI/PRODUCCION/ENTRADA/pedidos/resumen.txt"
# depuro las lineas que necesito para sacar tienda y local y creo array
locales_pre=($(cat $tiendas | grep -io "Tienda:.*OC:................" |  tr -s ' ' | cut -d':' -f2-3 | tr -d 'OC:' | tr -d '[[:space:]]' | grep -Eo '[^0-9]+|[0-9]+' ))
# invierto el orden del array para que quede adelante el numero de tienda
locales=($(for i in `printf '%s\n' "${locales_pre[@]}"|tac`; do echo $i; done))
# lo mando a un txt
printf '%s\n' "${locales[@]}" > /tmp/1.txt
# creo el archivo para que lo lea la interfaz grafica en numero n para 1 columna, numero sucursal y nombre tienda

x=1
while IFS= read -r line
do
    re='^[0-9]+$'
    if [[ $line =~ $re ]]; then
        echo $x >> /tmp/2.txt
        echo ${line:1:3} " " ${line:0:16} >> /tmp/2.txt
    else
    echo $line >> /tmp/2.txt
    fi
done < /tmp/1.txt
if [ -f /tmp/1.txt ]; then rm /tmp/1.txt; fi
# el check list
seleccion=$(zenity --list \
                    --title="Emision de Comprobantes" \
                    --height=400 \
                    --width=500 \
                    --ok-label="Aceptar" \
                    --cancel-label="Cancelar" \
                    --text="Selecciona las tiendas a facturar:" \
                    --checklist \
                    --separator=" " \
                    --column="" \
                    --column="Sucursal" \
                    --column="OC" \
                    --column="Número Suc." \
                    $(cat /tmp/2.txt) \
                    --print-column="2")
ans=$?
if [ $ans -eq 0 ]
then
    name=($seleccion)
    # echo "Has elegido: ${seleccion}"
    # echo ${#name[@]}
    # for i in ${name[@]}; do echo $i; done

    items=$((${#name[@]}*90))
    echo $items
# set -x
    export items

    entra_al_sistema

    remitos

    proceso_remito

    cierra_ventana

    facturas

    proceso_factura

    cierra_ventana

    emision_comprobantes

    salir

    if [ -f /tmp/2.txt ]; then rm /tmp/2.txt; fi
else
    if [ -f /tmp/2.txt ]; then rm /tmp/2.txt; fi
    exit
fi
