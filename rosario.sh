#! /bin/bash
 set -x
DESTINO=/media/trabajo/Trabajo/WEME/ASPEDI/PRODUCCION/ENTRADA/
RUTACTUAL=$DESTINO/Rosario
rosario=$'0018\n0032\n0033\n0041\n0268\n0229\n0256\n0156\n0255\n0259'
IFS=$'\n'
for FILE in $RUTACTUAL/*.TXT ; do
# cd $RUTACTUAL
  for i in $rosario; do
      FILE=$(find $RUTACTUAL -name 1-CABPED_$i*.TXT -printf "%f\n")
      OC=$(echo $FILE | awk -F'[_.]' '{print $2}')
      # echo "$OC" >> numeros.txt
      # mv $FILE 1-$FILE
      if [ -e "$RUTACTUAL/1-CABPED_"$OC".TXT" ]; then
        mv $RUTACTUAL/1-CABPED_"$OC".TXT $DESTINO/CABPED_"$OC".TXT
      fi
      if [ -e "$RUTACTUAL/1-LINPED_"$OC".TXT" ]; then
        mv $RUTACTUAL/1-LINPED_"$OC".TXT $DESTINO/LINPED_"$OC".TXT
      fi
      if [ -e "$RUTACTUAL/1-OBSPED_"$OC".TXT" ]; then
        mv $RUTACTUAL/1-OBSPED_"$OC".TXT $DESTINO/OBSPED_"$OC".TXT
      fi
      if [ -e "$RUTACTUAL/"$OC".txt" ]; then
        rm -f $RUTACTUAL/$OC.txt
      fi
  done
done
