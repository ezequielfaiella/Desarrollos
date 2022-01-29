#!/bin/bash

source /media/trabajo/Trabajo/scripts/automatizacion.sh

entra_al_sistema

actualiza_padron

sleep 190
salir
salir

mes=$(date +"%m")
year=$(date +"%Y")
if [ -f /media/trabajo/Trabajo/WEME/'PadronRGSPer'$mes$year'.TXT' ]; then rm /media/trabajo/Trabajo/WEME/'PadronRGSPer'$mes$year'.TXT'; fi
if [ -f /media/trabajo/Trabajo/WEME/'PadronRGSRet'$mes$year'.TXT' ]; then rm /media/trabajo/Trabajo/WEME/'PadronRGSRet'$mes$year'.TXT'; fi
