#!/bin/bash

###################################################################################
#                           INICIO DEL SCRIPT																			#
###################################################################################

[ -f /media/trabajo/Trabajo/WEME/ASPEDI/PRODUCCION/SALIDA/cabfac_*.txt ] && \
[ -f /media/trabajo/Trabajo/scripts/recibir_de_ediwin_asp.sh.lock ] || \
sh /media/trabajo/Trabajo/scripts/tantasfacturas.sh

###################################################################################
#                           FIN DEL SCRIPT		  																	#
###################################################################################


