#!/bin/bash
source /media/trabajo/Trabajo/scripts/fuente.sh

libreoffice --headless --print-to-file --outdir /tmp/ /media/trabajo/Trabajo/Administracion/1\ Uso\ Diario/Inventario.ods

# JPEG
gs -sDEVICE=jpeg -r100 -sPAPERSIZE=a4 -dBATCH -dNOPAUSE -sOutputFile=/tmp/Inventario.jpg /tmp/Inventario.ps
# [[ ! -z `find /tmp/ -maxdepth 1 -name 'Stock.jpg'` ]] | mutt -s "Stock de Mercaderia" -a /tmp/Stock.jpg -- administracion@panificadoradelsur.com.ar ; rm /tmp/Stock.jpg; rm /tmp/Stock.ps
[[ ! -z `find /tmp/ -maxdepth 1 -name 'Inventario.jpg'` ]] | send_f "/tmp/Inventario.jpg" ; rm /tmp/Inventario.jpg; rm /tmp/Inventario.ps

# PDF
# gs -sDEVICE=pdfwrite -r100 -sPAPERSIZE=a4 -dBATCH -dNOPAUSE -sOutputFile=/tmp/Logistica.pdf /tmp/Logistica.ps
# [[ ! -z `find /tmp/ -maxdepth 1 -name 'Logistica.pdf'` ]] | mutt -s "Reparto De Mañana" -a /tmp/Logistica.pdf -- administracion@panificadoradelsur.com.ar ; rm /tmp/Logistica.pdf; rm /tmp/Logistica.ps
