#!/bin/bash
set -x
RETENCION=$( ls /media/trabajo/Trabajo/Administracion/ORDENES\ DE\ PAGO/SISTEMA/TT20*.pdf)
	for FILE in $RETENCION ; do
					IMPRESORA=$(lpstat -a | grep -v grep | grep 1005 | awk '{print $1}')
					# IMPRESORA="Hewlett-Packard-HP-LaserJet-M1536dnf-MFP"
					NAME=`basename "$FILE"`
						case $NAME in
						*EDICOM_CONNECTING_BUSINESS_SA*signed.pdf)
								rm /media/trabajo/Trabajo/Administracion/ORDENES\ DE\ PAGO/SISTEMA/TT*EDICOM_CONNECTING_BUSINESS_SA.pdf
								echo "Tenemos el agrado de hacerles llegar el detalle del realizado. Saludamos atte." | mutt -s "Orden de Pago" -a /media/trabajo/Trabajo/Administracion/ORDENES\ DE\ PAGO/SISTEMA/*EDICOM_CONNECTING_BUSINESS_SA*.pdf -- ezequiel@panificadoradelsur.com.ar
								sleep 5
								rm /media/trabajo/Trabajo/Administracion/ORDENES\ DE\ PAGO/SISTEMA/TT*EDICOM_CONNECTING_BUSINESS_SA*.pdf
						;;
						*CONO_SUR_LEVADURAS_SRL*signed.pdf)
								rm /media/trabajo/Trabajo/Administracion/ORDENES\ DE\ PAGO/SISTEMA/TT*CONO_SUR_LEVADURAS_SRL.pdf
								echo "Tenemos el agrado de hacerles llegar el detalle del realizado. Saludamos atte." | mutt -s "Orden de Pago" -a /media/trabajo/Trabajo/Administracion/ORDENES\ DE\ PAGO/SISTEMA/*CONO_SUR_LEVADURAS_SRL*.pdf -- ezequiel@panificadoradelsur.com.ar
								sleep 5
								rm /media/trabajo/Trabajo/Administracion/ORDENES\ DE\ PAGO/SISTEMA/TT*CONO_SUR_LEVADURAS_SRL*.pdf
						;;
						*.pdf)
								rm /media/trabajo/Trabajo/Administracion/ORDENES\ DE\ PAGO/SISTEMA/TT*signed.pdf
								gdialog --title "Impresion" --yesno "¿Imprime la Orden de Pago? Se enviara a $IMPRESORA"
								if [ $? = 0 ]; then
								#~ lpr -o fit-to-page -o media=a4 -P $IMPRESORA /media/trabajo/Trabajo/Administracion/ORDENES\ DE\ PAGO/SISTEMA/$NAME
								rm /media/trabajo/Trabajo/Administracion/ORDENES\ DE\ PAGO/SISTEMA/$NAME*
								else
								rm /media/trabajo/Trabajo/Administracion/ORDENES\ DE\ PAGO/SISTEMA/$NAME*
								fi
						;;
						esac	
							
							
							

	done
