#!/bin/bash
set -x
source /media/trabajo/Trabajo/scripts/fuente.sh

: <<'END_COMMENT'

DEBUG=false
# para hacer debug, poner la variable y usar los if para omitir codigo
# DEBUG=false
# if ${DEBUG}; then
# fi

ORIGEN=/media/trabajo/Trabajo/WEME/ASPEDI/PRODUCCION/ENTRADA
# ORIGEN="/media/trabajo/Trabajo/scripts/lab/pedidos"

cat /dev/null > /media/trabajo/Trabajo/scripts/informe.log
#********************************
# CREA UN DIR TEMPORAL QUE AL SALIR SE BORRA
tmp=$(mktemp -d -t tmp.XXXXXXXXXX)
finish (){
 rm -rf "$tmp"
#  echo "funcion finish"
}
trap finish EXIT
#********************************
#exec >> /media/trabajo/Trabajo/scripts/hay.log 2>&1
# export DISPLAY:0.0
comprimir() {
ruta=$ORIGEN/pedidos
find $ruta/*.txt -mtime +2 -fprint $ruta/files.txt
# find $ruta/ -name "*.txt" -type f -mtime +2 > $ruta/files.txt
find $ruta/Pedidos*.xlsx -mtime +3 >> $ruta/files.txt
7z a $ruta/pedidosviejos.7z @$ruta/files.txt
rm $(<$ruta/files.txt)
rm $ruta/files.txt
}

muevepedidos() {
# ORIGEN=/media/trabajo/Trabajo/WEME/ASPEDI/PRODUCCION/ENTRADA
DESTINO=$ORIGEN/Descartados
tiendas=$'0381\n0386\n0517\n0388\n0384\n0389\n0490\n0491\n0510\n0511\n0514\n0515\n0516\n0518\n0519\n0390\n0512'
IFS=$'\n'
for FILE in $ORIGEN/*.TXT ; do
      for i in $tiendas ; do
      ARCHIVO666=$(find $ORIGEN -maxdepth 1 -name CABPED_$i*.TXT -printf "%f\n")
      OC=$(echo $ARCHIVO666 | awk -F'[_.]' '{print $2}')

      if [ -e "$ORIGEN/CABPED_"$OC".TXT" ]; then
        #~ mv $DESTINO/CABPED_"$OC".TXT $ORIGEN/1-CABPED_"$OC".TXT
        mv $ORIGEN/CABPED_"$OC".TXT $DESTINO/CABPED_"$OC".TXT
      fi
      if [ -e "$ORIGEN/LINPED_"$OC".TXT" ]; then
        #~ mv $DESTINO/LINPED_"$OC".TXT $ORIGEN/1-LINPED_"$OC".TXT
        mv $ORIGEN/LINPED_"$OC".TXT $DESTINO/LINPED_"$OC".TXT
      fi
      if [ -e "$ORIGEN/OBSPED_"$OC".TXT" ]; then
        #~ mv $DESTINO/OBSPED_"$OC".TXT $ORIGEN/1-OBSPED_"$OC".TXT
        mv $ORIGEN/OBSPED_"$OC".TXT $DESTINO/OBSPED_"$OC".TXT
      fi
      done
done
}

eliminadiamadre() {
	for FILE in $ORIGEN/LINPED_*.TXT ; do
	sed -i '/TORTA DIA DE LA MADRE X 900 GRS./d' $FILE
done
}
eliminabaguettesalvado() {
	for FILE in $ORIGEN/LINPED_*.TXT ; do
	sed -i '/7798329040137/d' $FILE
done
}
eliminatortas() {
	for FILE in $ORIGEN/LINPED_*.TXT ; do
	sed -i '/TARTA FRUTAL/d' $FILE
	sed -i '/TARTA LEMON PIE/d' $FILE
	sed -i '/TARTA DE MANZANA/d' $FILE
	sed -i '/TARTA DE RICOTA/d' $FILE
	sed -i '/TORTA DE DURAZNO/d' $FILE
	sed -i '/TORTA SELVA NEGRA/d' $FILE
	sed -i '/TORTA MOLINO/d' $FILE
	sed -i '/TORTA DE FRUTILLA/d' $FILE
	sed -i '/TORTA BOMBON/d' $FILE
	sed -i '/TORTA MIL HOJAS/d' $FILE
	sed -i '/TORTA SACHER/d' $FILE
	sed -i '/TORTA ROGEL/d' $FILE
done
}

cd $ORIGEN

#~ articulos=$'BAGUETTE\nMIGNON\nFLAUTITA\nBAGUETTE INTEGRAL\nFIGACITA DE SALVADO X 8 UNID.\nFIGACITA DE MANTECA X 8 UNID.\nMILONGUITA\nPEBETE\nPANCHO\nSUPERPANCHO\nHAMBURGUESA\nFLAUTITA CONGELADA\nBAGUETTE DE SALVADO CONG. X 30\nFLAUTA\n BAGUETTE SALVADO'

articulos=$'FLAUTITA PRECOC. CJ. X 8.KG. C\nMILONGUITA PRECOC.CJ.X 8 KG. C\nBAGUETIN CONGELADO TERM X3\nBAGUETIN CONGELADO PRE COCIDO X3 U\nMIGNON PRECOC.CJ. X 8.000 KG. C\nPAN BAGUETTE X 30 UNID\nPAN FLAUTA X 8 KG\nPAN MIGNON X 8 KG\nPAN MILONGUITA X 8 KG\nPAN DE VIENA PARA SUPER PANCHO\nPAN DE VIENA PARA PANCHO\nPAN DE VIENA PEBETE\nPAN DE VIENA PARA HAMBURGUESA\nFIGACITA DE MANTECA X8\nFIGACITAS DE SALVADO X8\nBAGUETIN CONGELADO PRE COCIDO X3'

#~ articulos=$'BAGUETTE PRECOC.CJ.X 30 UDS.\nMIGNON PRECOC.CJ. X 8.000 KG.\nFLAUTITA PRECOC. CJ. X 8.KG.\nBAGUETTE INTEGRAL PRECOC.CJ.X\nCUERNITOS X 180 GRS\nBIZCOCHITOS X 180 GRS\nFIGACITA DE SALVADO X 8 UNID.\nFIGACITA DE MANTECA X 8 UNID.\nMILONGUITA PRECOC.CJ.X 8 KG\nPEBETE\nPANCHO\nSUPERPANCHO\nHAMBURGUESA\nFLAUTITA CONGELADA\nBAGUETTE DE SALVADO CONG. X 30\nPAN ARABE CLASICO X 5 UNID.\nPAN ARABE ALARGADO 5 UNID.\nPAN ARABE SIN SAL 5 UNID.\nPAN ARABE DE SALVADO 5 UNID.\nBAGUETTIN X 3 UNID.\nCREMONITAS CON GRASA X 120 GRS\nTRENZAS CON GRASA X 150 GRS\nPAN TIPO CAMPO X 150 GRS'
#~ articuloscompleto=$'BAGUETTE PRECOC.CJ.X 30 UDS.\nMIGNON PRECOC.CJ. X 8.000 KG.\nFLAUTITA PRECOC. CJ. X 8.KG.\nBAGUETTE INTEGRAL PRECOC.CJ.X\nCRIOLLO HEXAGONAL\nCRIOLLO RIOJANO\nFACTURAS DE HOJALDRE\nFACTURAS SURTIDAS\nFIGACITA DE SALVADO X 8 UNID.\nFIGACITA DE MANTECA X 8 UNID.\nMNTCA.CJ X180 UDS \nGRASA. CJ X 140\nMILONGUITA PRECOC.CJ.X 8 KG\nPEBETE\nPANCHO\nSUPERPANCHO\nHAMBURGUESA\nFLAUTITA CONGELADA\nBAGUETTE DE SALVADO CONG. X 30\nPAN ARABE CLASICO X 5 UNID.\nPAN ARABE ALARGADO 5 UNID.\nPAN ARABE SIN SAL 5 UNID.\nPAN ARABE DE SALVADO 5 UNID.\nTARTA FRUTAL\nTARTA LEMON PIE\nTARTA DE MANZANA\nTARTA DE RICOTA\nTORTA DE DURAZNO\nTORTA SELVA NEGRA\nTORTA MOLINO\nTORTA DE FRUTILLA\nTORTA BOMBON\nTORTA MIL HOJAS\nTORTA SACHER\nTORTA ROGEL\nBAGUETTIN X 3 UNID.'
IFS=$'\n'
cat $ORIGEN/LINPED*.TXT >> /$tmp/pedidos.txt
archivo=(/$tmp/pedidos.txt)

###################################################################################################################
#
# ACA LO QUE SE HACE ES EN BASE A LOS PEDIDOS QUE HAYA EN LA CARPETA DE ENTRADA, GENERA LOS PEDIDOS INDIVIDUALES
#
###################################################################################################################

cd $ORIGEN
#tmp=/tmp/prueba/
#articulos=$'BAGUETTE PRECOC.CJ.X 30 UDS.\nMIGNON PRECOC.CJ. X 8.000 KG.\nFLAUTITA PRECOC. CJ. X 8.KG.\nBAGUETTE INTEGRAL PRECOC.CJ.X *\nCRIOLLO HEXAGONAL\nCRIOLLO RIOJANO\nFACTURAS DE HOJALDRE\nFACTURAS SURTIDAS\nFIGACITA DE SALVADO x 8\nFIGACITA DE MANTECA x 8\nMEDIALUNAS DULCES\nMEDIALUNAS SALADAS\nPAN MILONGUITA\nTORTA\nTARTA\nPEBETE\nPANCHO\nSUPERPANCHO\nHAMBURGUESA\nFLAUTITA CONGELADA\nBAGUETTE SALVADO CONGELADA'
#IFS=$'\n'
mkdir /$tmp/1/
#find /media/trabajo/Trabajo/Administracion/1\ Uso\ Diario/temporarios/pedidos/*.txt -mtime +3 -exec zip -j -m -T /media/trabajo/Trabajo/Administracion/1\ Uso\ Diario/temporarios/pedidos/pedidosviejos.zip {} +;
	#~ comprimir
	for i in $ORIGEN/CABPED*.TXT ; do
		NUMPED=$(basename -a $i | cut -c 8-23 ) #>> /$tmp/pedido.txt
		#echo ${NUMPED}
		if [ ! -f $ORIGEN/pedidos/${NUMPED}.txt ]; then
			#~ for i in $articuloscompleto; do
			for i in $articulos; do
			#echo $i
			cd /$tmp/1/
			producto=${i}.txt
			productoajustado=${i}_ajustado.txt
			grep -w -H $i $ORIGEN/LINPED_${NUMPED}.TXT >> $producto
			cut -c 434-441 $producto >> $productoajustado
			echo $(wc -c <"$productoajustado")
			if [ $(wc -c <"$productoajustado") -gt 0 ]; then
			echo ${i}=$( cat $productoajustado | awk '{ sum+=$1/100 } END {print sum}' ) >> $ORIGEN/pedidos/${NUMPED}.txt
			cat $productoajustado >> total_${NUMPED}.txt
			rm $ORIGEN/$producto
			rm $ORIGEN/$productoajustado
			fi
			done
				echo Total_Cajas=$( cat total_${NUMPED}.txt | awk '{ sum+=$1/100 } END {print sum}' ) >> $ORIGEN/pedidos/${NUMPED}.txt
				echo Total_Items=$(wc -l $ORIGEN/LINPED_${NUMPED}.TXT | awk {'print $1'}) >> $ORIGEN/pedidos/${NUMPED}.txt
				echo Fecha_Entrega=$( cat $ORIGEN/CABPED_${NUMPED}.TXT | cut -c 66-74 ) >> $ORIGEN/pedidos/${NUMPED}.txt
				echo Hora=$( cat $ORIGEN/CABPED_${NUMPED}.TXT | cut -c 75-78 ) >> $ORIGEN/pedidos/${NUMPED}.txt
		fi
	done



############################################
#
# ACA SE MANDA TODO AL ARCHIVO DE INFORME
#
############################################

# pedidosrosario=$(find $ORIGEN/Rosario/ -maxdepth 1 -name '1-CABPED*' | wc -l)
pedidos=$(find $ORIGEN/ -maxdepth 1 -name 'CABPED*' | wc -l)
walmart=$(find $ORIGEN/WALMART/ -maxdepth 1 -name '*.pdf' | wc -l)
recepciones=$(find $ORIGEN/ -name 'CABCRE*' | wc -l)

echo "CARREFOUR - Hay " $pedidos " pedidos">> /media/trabajo/Trabajo/scripts/informe.log
#~ echo "WALMART - Hay " $walmart " pedidos">> /media/trabajo/Trabajo/scripts/informe.log
echo "Hay " $recepciones " recepciones">> /media/trabajo/Trabajo/scripts/informe.log
# echo "Hay " $pedidosrosario " pedidos de Rosario">> /media/trabajo/Trabajo/scripts/informe.log
echo "-------------------------------">> /media/trabajo/Trabajo/scripts/informe.log

##############################################################################
#
# ACA GENERAL EL RESUMEN DE LOS PEDIDOS INGRESADOS PARA MOSTRAREN PANTALLA
#
##############################################################################

#~ for i in $articuloscompleto; do
for i in $articulos; do
			echo $i
		nombre=${i}.txt
		nombreajustado=${i}_ajustado.txt
		grep -w -H $i $archivo>> /$tmp/$nombre
		cd /$tmp/
		cut -c 385-392 $nombre >> $nombreajustado
			if [ $(wc -c <"$nombreajustado") -gt 0 ]; then
			echo ${i}=$( cat $nombreajustado | awk '{ sum+=$1/100 } END {print sum}' ) >> /media/trabajo/Trabajo/scripts/informe.log
			cat $nombreajustado >> total.txt
			fi
		rm $nombre
		rm $nombreajustado
done
##### aca se corre el proceso que mueve los pedidos a otra carpeta para no ser incorporados al sistema
#~ set -x
#~ muevepedidos
#~ set +x
##### ELIMINA ARTICULOS
#~ eliminadiamadre
eliminabaguettesalvado
#~ eliminatortas
# aca se extrae de los nombre de los archivos el numero de sucursal y lo agrega a informe.log
if [ $(wc -c <total.txt) -gt 0 ]; then
echo Total=$( cat total.txt | awk '{ sum+=$1/100 } END {print sum}' ) >> /media/trabajo/Trabajo/scripts/informe.log
echo  >> /media/trabajo/Trabajo/scripts/informe.log
echo Tiendas >> /media/trabajo/Trabajo/scripts/informe.log
fi
#basename -a $ORIGEN/CABPED* >> /$tmp/tiendas.txt
#~ ( cat $ORIGEN/CABPED* | cut -c 16-20,467-501 --output-delimiter=' - ' ) >> /media/trabajo/Trabajo/scripts/informe.log

for i in $ORIGEN/CABPED* ; do
	NUMPED=$(basename -a $i | cut -c 8-23 )
	SUCURSAL=$( cat $ORIGEN/CABPED_${NUMPED}.TXT | cut -c 16-20,467-501 --output-delimiter=' - ' )
	echo $SUCURSAL
	#~ VOLUMEN=$( cat total_${NUMPED}.txt | awk '{ sum+=$1/100 } END {print sum}' )
	VOLUMEN=$( grep Total_Cajas $ORIGEN/pedidos/${NUMPED}.txt  | awk -F= {'print $2'} )
	echo $VOLUMEN
	if [ $VOLUMEN -gt 0 ]; then
	[ ! -f $tmp/tiendas.txt ] && touch $tmp/tiendas.txt
	echo $SUCURSAL "("$VOLUMEN")" >> $tmp/tiendas.txt
	fi
done

cat $tmp/tiendas.txt  >> /media/trabajo/Trabajo/scripts/informe.log
# fi
################# TOTALES PENDIENTES DE ENTREGAR ##########################

echo  >> /media/trabajo/Trabajo/scripts/informe.log
echo Bultos Pendientes de Entrega >> /media/trabajo/Trabajo/scripts/informe.log

DESTINO=/tmp/unido.txt


cd $ORIGEN/pedidos/
cat *.txt > "$DESTINO"
sed -i '/Total/d' "$DESTINO"
sed -i '/Hora/d' "$DESTINO"
sed -i '/Fecha/d' "$DESTINO"
IFS=$'\n'

for i in $articulos; do
			producto=${i}.txt
			productoajustado=${i}_ajustado.txt
			#~ grep -w -H $i "$DESTINO" >> $producto
			grep -w $i "$DESTINO" >> $producto
			cut -d '=' -f 2 $producto >> $productoajustado
			if [ $(wc -c <"$productoajustado") -gt 0 ]; then
			echo ${i}=$( cat $productoajustado | awk '{ sum+=$1 } END {print sum}' ) >> /media/trabajo/Trabajo/scripts/informe.log
			cat $productoajustado >> /tmp/total_.txt
			fi
			rm $producto
			rm $productoajustado
done
rm "$DESTINO"
			if [ $(wc -c </tmp/total_.txt) -gt 0 ]; then
			echo Total_Cajas=$( cat /tmp/total_.txt | awk '{ sum+=$1 } END {print sum}' ) >> /media/trabajo/Trabajo/scripts/informe.log
			fi
			rm /tmp/total_.txt

############################################################################
#
# esta parte crea el contador para que cuando llegue a 10 envie un mail
#
############################################################################

END_COMMENT


/usr/bin/python3.6 /media/trabajo/Trabajo/scripts/haypedidos.py



date >> /media/trabajo/Trabajo/scripts/ejecuciones.txt
USADO=$(wc -l /media/trabajo/Trabajo/scripts/ejecuciones.txt | awk {'print $1'})
if [ $USADO -ge 10 ]; then
#~ cat /media/trabajo/Trabajo/scripts/informe.log | mutt -s "Pedidos" -- administracion@panificadoradelsur.com.ar
cat /dev/null > /media/trabajo/Trabajo/scripts/ejecuciones.txt
fi


if [ $USADO -eq 10 ]; then
	TOKEN="802999301:AAFqDz2EMeyO0D8EtAP4AZkhfLuIGiqC3LQ"
	ID="11729976"
	URLT="https://api.telegram.org/bot$TOKEN/sendMessage"
	# echo "IP Externa:" $(curl ifconfig.co) > /tmp/bot
	# echo "-----------------" >> /tmp/bot
	echo "Pedidos:" >> /tmp/bot
	cat /media/trabajo/Trabajo/scripts/informe.log >> /tmp/bot
	echo "-----------------" >> /tmp/bot
	echo "Actualización:" $(head -n1 /media/trabajo/Trabajo/scripts/cron.log) >> /tmp/bot
	MENSAJE=$(cat /tmp/bot)
#~ sh /media/trabajo/Trabajo/scripts/telegram-bot-bash/bashbot.sh broadcast $(cat /tmp/bot)
	curl -s -X POST $URLT -d chat_id=$ID -d text="$MENSAJE"
	ID="853056061"
	curl -s -X POST $URLT -d chat_id=$ID -d text="$MENSAJE"
	ID="849358586"
	curl -s -X POST $URLT -d chat_id=$ID -d text="$MENSAJE"
	rm /tmp/bot
fi
