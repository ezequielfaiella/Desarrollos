###################################################################################
# ESTA EL LA BASE A USAR PARA TODO SCRIPT. CREA UN LOG, DETIENE SI HAY ERROR Y 		#
# PERMITE UNA SOLA EJECUCION POR PC.	ADEMAS CREA UN DIR TEMPORAL QUE SE BORRA		#
# AL TERMINAR LA EJECUCUIN DEL MISMO																							#
###################################################################################

#!/bin/bash
rm /$PWD/0_informe.csv 2</dev/null
touch /$PWD/0_informe.csv
for i in $PWD/*.EDI; do
	#~ COMPROBANTE=$(cat $i | cut -d '+' -f 12 | cut -c 2-13) 
	#~ ESTADO=$(cat $i | cut -d '+' -f 29) 
	COMPROBANTE=$(cat $i | awk -F '+' '{print $12}' | cut -c 2-13 | sed 's/^\(.\{4\}\)/\1-/') 
	FECHA=$(cat $i | awk -F '+' '{print $5}' | cut -c 1-6) 
	ESTADO=$(cat $i | awk -F '+' '{print $29}' | rev | cut -c5- | rev) 
echo $COMPROBANTE";"$ESTADO";"$FECHA	>> /$PWD/0_informe.csv
done
