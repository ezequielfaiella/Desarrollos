#!/bin/bash
#~ set -x
# r is the row (the line number in the file)
# c is the column number
# v is the replacement value

# This will replace column 1, row 2 with 5, no matter what the value of the cell:
#nawk -v r=2 -v c=1 -v val=5 -F, 'BEGIN{OFS=","}; NR != r; NR == r {$c = val; print}' /media/trabajo/Trabajo/scripts/lab/etiquetas/Etiq-lotes-AUTONOMA.csv > /media/trabajo/Trabajo/scripts/lab/etiquetas/Etiq-lotes.csv

if [ "$#" -ne 2 ]; then
    echo "Se necesita CANTIDAD (en cajas), ARTICULO (manteca, salvado, pebete, hamburguesa, pancho, super, terminado, precocido)"
    exit 2
fi
ORIGEN="/media/trabajo/Trabajo/scripts/Terminal-Etiq-lotes.csv"
DESTINO="/media/trabajo/Trabajo/scripts/Etiq-lotes.csv"
IMPRESION="/media/trabajo/Trabajo/Administracion/1 Uso Diario/Etiq-lotes.csv"
ARTICULO=$2

case $ARTICULO in
				manteca)
					#figacitas manteca
					CANTIDAD=$(expr $1 \* 28)
					LINEA=2
				;;
				salvado)
					#~ #figacitas salvado
					CANTIDAD=$(expr $1 \* 28)
					LINEA=3
				;;
				pebete)
					#pebete
					CANTIDAD=$(expr $1 \* 24)
					LINEA=4
				;;
				hamburguesa)
					#hamburguesa
					CANTIDAD=$(expr $1 \* 30)
					LINEA=5
				;;
				pancho)
					#pancho
					CANTIDAD=$(expr $1 \* 28)
					LINEA=6
				;;
				super)
					#super
					CANTIDAD=$(expr $1 \* 18)
					LINEA=7
				;;
				terminado)
					#baguetin terminado
					CANTIDAD=$(expr $1 \* 24)
					LINEA=8
				;;
				precocido)
					#baguetin precocido
					CANTIDAD=$(expr $1 \* 24)
					LINEA=9
				;;
				*) 
					echo "Se necesita CANTIDAD y ARTICULO"
					exit 2
esac

rm "$DESTINO" 2>/dev/null
touch "$DESTINO"
awk 'NR==1'  "$ORIGEN" > "$DESTINO"
awk 'NR=='"$LINEA" "$ORIGEN" >> "$DESTINO"
sed -i "2 s,^0,$CANTIDAD," "$DESTINO"
mv "$DESTINO" "$IMPRESION"
