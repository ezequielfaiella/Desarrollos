#!/bin/bash

source /media/trabajo/Trabajo/scripts/automatizacion.sh

if [ -f /media/trabajo/Trabajo/WEME/exportacion/inc.xls ]; then rm /media/trabajo/Trabajo/WEME/exportacion/inc.xls; fi
if [ -f /media/trabajo/Trabajo/WEME/exportacion/rece.xls ]; then rm /media/trabajo/Trabajo/WEME/exportacion/rece.xls; fi
if [ -f /media/trabajo/Trabajo/WEME/exportacion/.~lock.rece.xls# ]; then rm /media/trabajo/Trabajo/WEME/exportacion/.~lock.rece.xls#; fi
if [ -f /media/trabajo/Trabajo/WEME/exportacion/.~lock.inc.xls# ]; then rm /media/trabajo/Trabajo/WEME/exportacion/.~lock.inc.xls#; fi

entra_al_sistema

deudores_inc

recepciones
sleep 180
salir
salir

office=$(which soffice)
if [[ $office = '' ]]; then
    libreoffice7.2 "/media/trabajo/Trabajo/Administracion/1 Uso Diario/Recepciones.ods" "macro:///Recepciones.Recepciones_Varios.Main"
else
    soffice "/media/trabajo/Trabajo/Administracion/1 Uso Diario/Recepciones.ods" "macro:///Recepciones.Recepciones_Varios.Main"
# libreoffice7.1 --calc %U
fi