#!/bin/bash
export DISPLAY=:0.0

# SI HAY ERROR DETIENE EL SCRIPT
#~ set -xe  # SE PUEDE PONER -ex PARA QUE ADEMAS MUESTRE EL COMANDO QUE EJECUTA

###################################################################################
#                           INICIO DEL SCRIPT										#
###################################################################################

while true; do
#~ if ping -c1 google.com &>/dev/null; then echo “Tienes Conexion” > /home/ezequiel/conexion ; else echo “NO Tienes Conexion” > /home/ezequiel/conexion ; fi
	if ping -c1 google.com &>/dev/null; 
	then echo  > /home/ezequiel/conexion ; 
	else notify-send “NO Tienes Conexion” 
	echo “NO Tienes Conexion” > /home/ezequiel/conexion; 
	fi
sleep 5
done

###################################################################################
#                           FIN DEL SCRIPT											#
###################################################################################
