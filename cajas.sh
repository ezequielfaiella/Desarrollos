#!/bin/bash
#~ set -x
if [ "$#" -ne 3 ]; then
    echo "Se necesita CANTIDAD, ARTICULO (manteca, salvado, pebete, hamburguesa, pancho, super, terminado, precocido, minon, flauta, baguette, milonguita, minoncongelado, flautacongelada, bollitos) y FECHA"
    exit 2
fi
ORIGEN="/media/trabajo/Trabajo/scripts/Terminal-Etiq-Manuales.csv"
DESTINO="/media/trabajo/Trabajo/scripts/Etiq-Manuales.csv"
IMPRESION="/media/trabajo/Trabajo/Administracion/1 Uso Diario/Etiq-Manuales.csv"
ARTICULO=$2
CANTIDAD=$1
#~ CANTIDAD=5
#~ LINEAI=2
#~ LINEAF=4
#~ FECHA="$3"
FECHAORIG=$(date --date="$3" +%d%m%y)
LOTE=$(date --date="$FECHAORIG" +"%y%j")
case $ARTICULO in 
				miñon)
					UTIL=10
					LINEA=2
				;;
				flauta)
					UTIL=10
					LINEA=3
				;;
				baguette)
					UTIL=10
					LINEA=4
				;;
				milonguita)
					UTIL=10
					LINEA=5
				;;
				bollitos)
					UTIL=13
					LINEA=8
				;;
				manteca)
					UTIL=180
					LINEA=10
				;;
				salvado)
					UTIL=180
					LINEA=11
				;;
				pebete)
					UTIL=180
					LINEA=12
				;;
				hamburguesa)
					UTIL=180
					LINEA=13
				;;
				pancho)
					UTIL=180
					LINEA=14
				;;
				super)
					UTIL=180
					LINEA=15
				;;
				terminado)
					UTIL=180
					LINEA=16
				;;
				precocido)
					UTIL=180
					LINEA=18
				;;
				minoncongelado)
					UTIL=180
					LINEA=7
				;;
				flautacongelada)
					UTIL=180
					LINEA=9
				;;
				*)
					echo "Error, hay algo mal"
				;;
esac
VENCIMIENTOCALC=$(date '+%y%m%d' -d "$FECHAORIG+$UTIL days")
#~ rm "$DESTINO" 2>/dev/null
FECHA=$(date '+%d/%m/%y' -d "$FECHAORIG")
VENCIMIENTO=$(date '+%d/%m/%y' -d "$VENCIMIENTOCALC")
#~ echo $FECHA
#~ echo $VENCIMIENTO
#~ echo $LOTE

touch "$DESTINO"
awk 'NR==1'  "$ORIGEN" > "$DESTINO"
#~ awk 'NR=='"$LINEAI"', NR=='"$LINEAF"  $ORIGEN >> $DESTINO
awk 'NR=='"$LINEA" "$ORIGEN" >> "$DESTINO"
#~ nawk -v r=2 -v c=1 -v val=$CANTIDAD -F, 'BEGIN{OFS=","}; NR != r; NR == r {$c = val; print}' $DESTINO > $DESTINO
sed -i "2 s,^0,$CANTIDAD," "$DESTINO"
sed -i "2 s,FELAB,$FECHA," "$DESTINO"
sed -i "2 s,FEVENC,$VENCIMIENTO," "$DESTINO"
sed -i "2 s,FEUTIL,$UTIL," "$DESTINO"
#~ sed -i "4 s,FLOT,$LOTE," "$DESTINO"
sed -i "2 s,FLOT,$LOTE," "$DESTINO"
mv "$DESTINO" "$IMPRESION"
