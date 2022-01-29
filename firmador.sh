#!/bin/bash
#~ set -xve
####
# SI HAY ERROR DE IMAGEMAGICK 412 CON ESTO SE ARREGLA

#~ sudo cp /etc/ImageMagick-6/policy.xml /etc/ImageMagick-6/policy.xml.bak
#~ sudo sed -i "s/rights\=\"none\" pattern\=\"PS\"/rights\=\"read\|write\" pattern\=\"PS\"/" /etc/ImageMagick-6/policy.xml
#~ sudo sed -i "s/rights\=\"none\" pattern\=\"EPI\"/rights\=\"read\|write\" pattern\=\"EPI\"/" /etc/ImageMagick-6/policy.xml
#~ sudo sed -i "s/rights\=\"none\" pattern\=\"PDF\"/rights\=\"read\|write\" pattern\=\"PDF\"/" /etc/ImageMagick-6/policy.xml
#~ sudo sed -i "s/rights\=\"none\" pattern\=\"XPS\"/rights\=\"read\|write\" pattern\=\"XPS\"/" /etc/ImageMagick-6/policy.xml

###################

TMP=tmp-folder-signpdf

IMPRESORA=$(lpstat -a | grep -v grep | grep HP-ZEROTIER | awk '{print $1}')
SIGNATURE="/media/trabajo/Trabajo/scripts/retencion-firma2.png"
PAGINA=1

DIR=`pwd`;
mkdir $TMP
cd $TMP

#~ pdftk "../$1" burst output page_%d.pdf
pdftk "$1" burst output page_%d.pdf

convert -density 300 page_$PAGINA.pdf page_$PAGINA.png

cd $DIR

composite -geometry 1200x"$dy"+900+1700 "$SIGNATURE" $TMP/page_$PAGINA.png $TMP/firmado.png
convert -density 300 $TMP/firmado.png $TMP/firmado_pagina_$PAGINA.pdf
pdftk $TMP/firmado_pagina_$PAGINA.pdf cat output "${1%.pdf}_Firmado.pdf"
gdialog --title "Impresion" --yesno "¿Imprime la Retencion? Se enviara a $IMPRESORA"
	if [ $? = 0 ]; then
	lpr -o fit-to-page -o media=a4 -P $IMPRESORA "${1%.pdf}_Firmado.pdf"
	mv "${1%.pdf}_Firmado.pdf" /media/trabajo/Trabajo/Administracion/ORDENES\ DE\ PAGO/SISTEMA/
	rm -r $TMP
	rm "$1"
	else
	mv "${1%.pdf}_Firmado.pdf" /media/trabajo/Trabajo/Administracion/ORDENES\ DE\ PAGO/SISTEMA/
	rm -r $TMP
	rm "$1"
	fi
