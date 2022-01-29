#! /bin/bash
# set -x
#********************************
# CREA UN DIR TEMPORAL QUE AL SALIR SE BORRA
temp=$(mktemp -d -t temp.XXXXXXXXXX)
finish (){
 rm -rf "$temp"
}
trap finish EXIT INT TERM
#********************************
RUTACTUAL=/media/trabajo/Trabajo/WEME/ASPEDI/PRODUCCION/ENTRADA/
DESTINO=$RUTACTUAL/Rosario
rosario=$'0018\n0032\n0033\n0041\n0268\n0229\n0256\n0156\n0255\n0259'
IFS=$'\n'

for FILE in $RUTACTUAL/*.TXT ; do
# cd $RUTACTUAL
  for i in $rosario; do
      ARCHIVO=$(find $RUTACTUAL -name CABPED_$i*.TXT -printf "%f\n")
      OC=$(echo $ARCHIVO | awk -F'[_.]' '{print $2}')
      # echo "$OC" >> numeros.txt
      # mv $FILE 1-$FILE
      if [ -e "$RUTACTUAL/CABPED_"$OC".TXT" ]; then
        mv $RUTACTUAL/CABPED_"$OC".TXT $DESTINO/1-CABPED_"$OC".TXT
      fi
      if [ -e "$RUTACTUAL/LINPED_"$OC".TXT" ]; then
        mv $RUTACTUAL/LINPED_"$OC".TXT $DESTINO/1-LINPED_"$OC".TXT
      fi
      if [ -e "$RUTACTUAL/OBSPED_"$OC".TXT" ]; then
        mv $RUTACTUAL/OBSPED_"$OC".TXT $DESTINO/1-OBSPED_"$OC".TXT
      fi
      # if [ -e "$RUTACTUAL/"$OC".TXT" ]; then
      #   mv $RUTACTUAL/pedidos/$OC.txt $DESTINO
      # fi
    done
done
############################ PEDIDOS INDIVIDUALES ############################
articuloscompleto=$'BAGUETTE PRECOC.CJ.X 30 UDS.\nMIGNON PRECOC.CJ. X 8.000 KG.\nFLAUTITA PRECOC. CJ. X 8.KG.\nBAGUETTE INTEGRAL PRECOC.CJ.X\nCRIOLLO HEXAGONAL\nCRIOLLO RIOJANO\nFACTURAS DE HOJALDRE\nFACTURAS SURTIDAS\nFIGACITA DE SALVADO X 8 UNID.\nFIGACITA DE MANTECA X 8 UNID.\nPREF.MEDIALUNA D/MNTCA.CJ X180 UDS\nPREF.MEDIALUNA D/GRASA. CJ X 140\nMILONGUITA PRECOC.CJ.X 8 KG\nPEBETE\nPANCHO\nSUPERPANCHO\nHAMBURGUESA\nFLAUTITA CONGELADA\nBAGUETTE DE SALVADO CONG. X 30\nPAN ARABE CLASICO X 5 UNID.\nPAN ARABE ALARGADO 5 UNID.\nPAN ARABE SIN SAL 5 UNID.\nPAN ARABE DE SALVADO 5 UNID.\nTARTA FRUTAL\nTARTA LEMON PIE\nTARTA DE MANZANA\nTARTA DE RICOTA\nTORTA DE DURAZNO\nTORTA SELVA NEGRA\nTORTA MOLINO\nTORTA DE FRUTILLA\nTORTA BOMBON\nTORTA MIL HOJAS\nTORTA SACHER\nTORTA ROGEL'
# articuloscompleto=$'MIGNON PRECOC.CJ. X 8.000 KG.\nFLAUTITA PRECOC. CJ. X 8.KG.'
IFS=$'\n'

for i in /$DESTINO/1-CABPED*.TXT ; do
    NUMPED=$(basename -a $i | cut -c 10-25 ) #>> /$temp/pedido.txt
    echo ${NUMPED}
  if [ ! -f /media/trabajo/Trabajo/WEME/ASPEDI/PRODUCCION/ENTRADA/Rosario/${NUMPED}.txt ]; then
      for i in $articuloscompleto; do
        #echo $i
        # mkdir /$temp
        cd /$temp
        producto=${i}.txt
        productoajustado=${i}_ajustado.txt
        grep -w -H $i /media/trabajo/Trabajo/WEME/ASPEDI/PRODUCCION/ENTRADA/Rosario/1-LINPED_${NUMPED}.TXT >> $producto
        cut -c 444-451 $producto >> $productoajustado
          if [ $(wc -c <"$productoajustado") -gt 0 ]; then
            echo ${i}=$( cat $productoajustado | awk '{ sum+=$1/100 } END {print sum}' ) >> /media/trabajo/Trabajo/WEME/ASPEDI/PRODUCCION/ENTRADA/Rosario/${NUMPED}.txt
            cat $productoajustado >> total_${NUMPED}.txt
            rm $producto
            rm $productoajustado
          fi
        done
    echo Total_Cajas=$( cat total_${NUMPED}.txt | awk '{ sum+=$1/100 } END {print sum}' ) >> /media/trabajo/Trabajo/WEME/ASPEDI/PRODUCCION/ENTRADA/Rosario/${NUMPED}.txt
    echo Total_Items=$( wc -l $DESTINO/1-LINPED_${NUMPED}.TXT | awk {'print $1'}) >> /media/trabajo/Trabajo/WEME/ASPEDI/PRODUCCION/ENTRADA/Rosario/${NUMPED}.txt

  fi
done
