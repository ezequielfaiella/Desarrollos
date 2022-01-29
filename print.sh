#! /bin/bash
set -ex
# source ~/.bash_aliases
scriptname=$(basename $0)
pidfile="/tmp/${scriptname}.pid"



#######################
# CUANDO RECIBE ALGUNA SEÑAL BORRA EL .PID
function finish {
  rm -rf "$pidfile"

	}
trap finish TERM EXIT KILL
# inicio de log
	{
#######################

# IMPRESORA="HP-LaserJet-M1005-MFP"
# IMPRESORA="Hewlett-Packard-HP-LaserJet-M1536dnf-MFP"
#
# para ver las impresoras del sistema y su estado
# lpc status
# lpstat -a | cut -f1 -d ' ' # otra alternativa que da solo el nombre
#

if [[ $USER = "ezequiel" ]]; then
	# IMPRESORA=$(lpstat -a | grep -v grep | grep HP-ZEROTIER | awk '{print $1}');
	IMPRESORA=$(lpstat -a | grep -v grep | grep HP-LaserJet-M1005 | awk '{print $1}');
	IMPRESORA_BLANCO=$(lpstat -a | grep -v grep | grep HP-LaserJet-M1005 | awk '{print $1}');
	# IMPRESORA_BLANCO=$(lpstat -a | grep -v grep | grep HP_LaserJet_1018 | awk '{print $1}');
	# echo $IMPRESORA
	# echo $IMPRESORA_BLANCO
fi	
if [[ $USER = "administracion" ]]; then
	IMPRESORA=$(lpstat -a | grep -v grep | grep HP-LaserJet-M1005 | awk '{print $1}');
	IMPRESORA_BLANCO=$(lpstat -a | grep -v grep | grep HP-LaserJet-M1005 | awk '{print $1}');
	# IMPRESORA_BLANCO=$(lpstat -a | grep -v grep | grep HP_LaserJet_1018 | awk '{print $1}');
	# echo $IMPRESORA
fi

#~ for FILE in /home/$USER/PDF/FA* ; do NEWFILE2=`echo ${FILE:0:22}` ; mv $FILE $NEWFILE2 ; done
#~ for FILE in /home/$USER/PDF/FA* ; do mv $FILE $FILE.pdf ; done

comprimir() {
	ruta="/media/trabajo/Trabajo/Administracion/ORDENES DE PAGO/SISTEMA"
	find "$ruta"/*.pdf "$ruta"/*.PDF -mtime +2 -fprint "$ruta"/files.txt
	7z a "$ruta"/OPVIEJAS.7z @"$ruta"/files.txt
	xargs -a "$ruta"/files.txt -d'\n' rm
	#~ rm "$(<"$ruta"/files.txt)"
	rm "$ruta"/files.txt
	}
### FUNCIONES

imprime(){
	# set -x
	echo $FILE
	echo "Impresora: "$IMPRESORA_BLANCO
	lpr -o fit-to-page -P $IMPRESORA_BLANCO $FILE
	NAME=`basename "$FILE"`
	mv $FILE /media/trabajo/Trabajo/WEME/PDF/
	}
imprime2(){
	lpr -o fit-to-page -# 2 -P $IMPRESORA_BLANCO $FILE
	NAME=`basename "$FILE"`
	mv $FILE /media/trabajo/Trabajo/WEME/PDF/
	}
imprimedisco(){
	NAME=`basename "$FILE"`
	cp $FILE '/media/trabajo/Trabajo/Administracion/Documentacion/Facturas Credito A'
	lpr -o fit-to-page -#2 -P $IMPRESORA_BLANCO $FILE
	}
imprimepregunta() {
	gdialog --title "Impresion" --yesno "¿Imprime la Factura $FILE? Se enviara a $IMPRESORA_BLANCO"
	if [ $? = 0 ]; then
	lpr -o fit-to-page -P $IMPRESORA_BLANCO $FILE
	NAME=`basename "$FILE"`
	mv $FILE /media/trabajo/Trabajo/WEME/PDF/
	fi
	}
imprimepregunta2() {
	# cd /home/$USER/PDF/
	gdialog --title "Impresion" --yesno "¿Imprime la Factura? Se enviara a $IMPRESORA_BLANCO"
	if [ $? = 0 ]; then
	lpr -o fit-to-page -#2 -P $IMPRESORA_BLANCO $FILE
	NAME=`basename "$FILE"`
	mv $FILE /media/trabajo/Trabajo/WEME/PDF/
	fi
	}
latin() {
	cd /home/$USER/PDF/
	echo "Tenemos el agrado de hacerles llegar la factura por el pedido realizado. Saludamos atte." | mail -s "Factura Electrónica" -A FA0003????????-019-001.pdf -- mfonticelli@latinchemical.com.ar
	NAME=`basename "$FILE"`
	sleep 10
	mv $FILE /media/trabajo/Trabajo/WEME/PDF/Enviados/
	}
dia() {
	cd /home/$USER/PDF/
	echo "Tenemos el agrado de hacerles llegar la factura por el pedido entregado. Saludamos atte." | mail -s "Factura Electrónica" -A FE0006????????-027-*.pdf -- ezequiel@panificadoradelsur.com.ar #dia.ar.fcelectronica@diagroup.com
	NAME=`basename "$FILE"`
	sleep 10
	mv $FILE /media/trabajo/Trabajo/Administracion/Documentacion/Facturas\ Credito\ A/
	}
carlos() {
	cd /home/$USER/PDF/
	echo "Tenemos el agrado de hacerles llegar la factura por el pedido realizado. Saludamos atte." | mail -s "Factura Electrónica" -A FA0003????????-021-*.pdf -- carls.gastronomia@gmail.com
	NAME=`basename "$FILE"`
	sleep 10
	mv $FILE /media/trabajo/Trabajo/WEME/PDF/Enviados/
	}
wayback() {
	cd /home/$USER/PDF/
	echo "Tenemos el agrado de hacerles llegar la factura por el pedido realizado. Saludamos atte." | mail -s "Factura Electrónica" -A FA0003????????-016-001.pdf -- compras@wayback.com.ar, m.trivi@wayback.com.ar
	NAME=`basename "$FILE"`
	sleep 10
	mv $FILE /media/trabajo/Trabajo/WEME/PDF/Enviados/
	}
gala() {
	cd /home/$USER/PDF/
	echo "Tenemos el agrado de hacerles llegar la factura por el pedido realizado. Saludamos atte." | mail -s "Factura Electrónica" -A FA0003????????-020-001.pdf -- administracion@grupogala.com.ar, proveedores@grupogala.com.ar
	NAME=`basename "$FILE"`
	sleep 10
	mv $FILE /media/trabajo/Trabajo/WEME/PDF/Enviados/
	}
carlos_credito() {
	cd /home/$USER/PDF/
	echo "Tenemos el agrado de hacerles llegar la siguiente nota de crédito. Saludamos atte." | mail -s "Nota de Crédito Electrónica" -A CA0003????????-022-*.pdf -- carls.gastronomia@gmail.com
	NAME=`basename "$FILE"`
	sleep 10
	mv $FILE /media/trabajo/Trabajo/WEME/PDF/CA/
	}
gala_credito() {
	cd /home/$USER/PDF/
	echo "Tenemos el agrado de hacerles llegar la siguiente nota de crédito. Saludamos atte." | mail -s "Nota de Crédito Electrónica" -A CA0003????????-020-001.pdf -- administracion@grupogala.com.ar, proveedores@grupogala.com.ar
	NAME=`basename "$FILE"`
	sleep 10
	mv $FILE /media/trabajo/Trabajo/WEME/PDF/CA/
	}
wayback_credito() {
	cd /home/$USER/PDF/
	echo "Tenemos el agrado de hacerles llegar la siguiente nota de crédito. Saludamos atte." | mail -s "Nota de Crédito Electrónica" -A CA0003????????-016-001.pdf -- compras@wayback.com.ar, m.trivi@wayback.com.ar
	NAME=`basename "$FILE"`
	sleep 10
	mv $FILE /media/trabajo/Trabajo/WEME/PDF/CA/
	}
naviera_credito() {
	cd /home/$USER/PDF/
	echo "Tenemos el agrado de hacerles llegar la siguiente nota de crédito. Saludamos atte." | mail -s "Nota de Crédito Electrónica" -A CA0003????????-024-001.pdf -- GCastelli@ssa-shipping.com.ar, felectronica@navieradelsud.com, administracion@panificadoradelsur.com.ar
	NAME=`basename "$FILE"`
	sleep 10
	mv $FILE /media/trabajo/Trabajo/WEME/PDF/CA/
	}
marsano() {
	cd /home/$USER/PDF/
	echo "Tenemos el agrado de hacerles llegar la factura por el pedido realizado. Saludamos atte." | mail -s "Factura Electrónica" -A FA0003????????-047-*.pdf -- karina@marsanogroup.com
	NAME=`basename "$FILE"`
	sleep 10
	mv $FILE /media/trabajo/Trabajo/WEME/PDF/Enviados/
	}
palma() {
	cd /home/$USER/PDF/
	echo "Tenemos el agrado de hacerles llegar la factura por el pedido realizado. Saludamos atte." | mail -s "Factura Electrónica" -A FA0003????????-022-*.pdf -- carls.gastronomia@gmail.com, administracion@panificadoradelsur.com.ar
	NAME=`basename "$FILE"`
	sleep 10
	mv $FILE /media/trabajo/Trabajo/WEME/PDF/Enviados/
	}
naviera() {
	#~ lpr -o fit-to-page -P $IMPRESORA $FILE
	cd /home/$USER/PDF/
	echo "Tenemos el agrado de hacerles llegar la factura por el pedido realizado. Saludamos atte." | mail -s "Factura Electrónica" -A FA0003????????-024-*.pdf -- GCastelli@ssa-shipping.com.ar, felectronica@navieradelsud.com, administracion@panificadoradelsur.com.ar
	NAME=`basename "$FILE"`
	sleep 10
	mv $FILE /media/trabajo/Trabajo/WEME/PDF/Enviados/
	}
ncredito(){
		# credito=/home/$USER/PDF/CA0003*.pdf
	#~ if [ -f $credito ] ; then
		for FILE in $credito ; do
			# IMPRESORA=$(lpstat -a | grep -v grep | grep HP-ZEROTIER | awk '{print $1}')
			# IMPRESORA="Hewlett-Packard-HP-LaserJet-M1536dnf-MFP"
						cliente=$(echo -n $credito | tail -c 12)
							case $cliente in
								*-016-001.pdf)
									wayback_credito
								;;
								*-022-???.pdf)
									carlos_credito
								;;
								*-021-002.pdf)
									carlos_credito
								;;
								*-021-003.pdf)
									carlos_credito
								;;
								*-020-001.pdf)
									gala_credito
								;;
								*-024-001.pdf)
									naviera_credito
								;;
							esac
				gdialog --title "Impresion" --yesno "¿Imprime la Nota de Credito? Se enviara a $IMPRESORA_BLANCO"
				if [ $? = 0 ]; then
				lpr -o fit-to-page -P $IMPRESORA_BLANCO $FILE
				NAME=$(basename "$FILE")
					if [ $FILE = CA* ]; then
						mv $FILE /media/trabajo/Trabajo/WEME/PDF/CA/
					else
						mv $FILE /media/trabajo/Trabajo/Administracion/Documentacion/Nota\ Credito\ A\ Mipyme/
					fi
				else
					if [ $FILE = CA* ]; then
						mv $FILE /media/trabajo/Trabajo/WEME/PDF/CA/
					else
						mv $FILE /media/trabajo/Trabajo/Administracion/Documentacion/Nota\ Credito\ A\ Mipyme/
					fi
				fi
		done
	#~ fi
	}
facturador() {
	# set -x
		# factura=(/home/$USER/PDF/FA0003*.pdf)
		# fe=(/home/$USER/PDF/FE0003*.pdf)
	#~ if [ -f $factura ]; then
			case $USER in
				ezequiel)
						# IMPRESORA=$(lpstat -a | grep -v grep | grep HP-LaserJet-M1005 | awk '{print $1}')     # HP-LaserJet-M1005 local
						# IMPRESORA=$(lpstat -a | grep -v grep | grep HP-ZEROTIER | awk '{print $1}')
						# IMPRESORA=$IMPRESORAE
						cd /home/$USER/PDF/
						echo $factura
						for FILE in $factura ; do
							cliente=$(echo -n $factura | tail -c 13)
							echo $cliente
							case $cliente in
								*-036-001-O.pdf)
									imprimedisco
								;;
								*-044-006.pdf)
									imprimepregunta2
								;;
								*-044-927-O*.pdf)
									imprime
								;;
								*-044-927-D*.pdf)
								# imprime
								;;
								*-016-001.pdf)
									wayback
								;;
								*-019-001.pdf)
									latin
								;;
								*-021-???.pdf)
									carlos
								;;
								*-021-002.pdf)
									carlos
								;;
								*-021-003.pdf)
									carlos
								;;
								*-020-001.pdf)
									gala
								;;
								*-047-*.pdf)
									marsano
								;;
								*-024-*.pdf)
									naviera
								;;
								*-044-*.pdf)
									imprime
								;;
								*-027-???-*O*.pdf)
									dia
								;;
								*)
									imprimepregunta
								# 	# imprime
								;;
							esac
						done
						# for FILE in $fe ; do
						# 	case $FILE in
						# 		*-044-927-O*.pdf)
						# 		  imprime
						# 		;;
						# 		*-044-927-D*.pdf)
						# 		  # imprime
						# 		;;
						# 	esac
						# done
						exit 0
					;;
				administracion)
						# IMPRESORA="$IMPRESORAA"
						# IMPRESORA=$(lpstat -a | grep -v grep | grep HP-LaserJet-M1005 | awk '{print $1}')
						cd /home/$USER/PDF/
						for FILE in $factura ; do
							cliente=$(echo -n $factura | tail -c 12)
							case $cliente in
								*-044-006.pdf)
									imprime
								;;
								*-044-927-O*.pdf)
								imprime
								;;
								*-044-927-D*.pdf)
								# imprime
								;;
								*-036-001*.pdf)
									imprimedisco
								;;
								*-019-001.pdf)
									latin
								;;
								*-024-001.pdf)
									naviera
								;;
								*-020-001.pdf)
									gala
								;;
								*-047-*.pdf)
									marsano
								;;
								*-044-???.pdf)
									imprime
									#~ imprimepregunta
								;;
								*-027-*O*.pdf)
									dia
								;;
							esac
						done
						# for FILE in $fe ; do
						# 	case $FILE in
						# 		*-044-927-O*.pdf)
						# 		  imprime
						# 		;;
						# 		*-044-927-D*.pdf)
						# 		  # imprime
						# 		;;
						# 	esac
						# done
					;;
				esac
	#~ else
		#~ notify-send "Sin Facturas Pendientes"
	#~ fi
	}
pagos(){
		# PAGO=/home/$USER/PDF/OP000*.pdf
	#~ if [ -f $PAGO ] ; then
		for FILE in $PAGO ; do
						# IMPRESORA=$(lpstat -a | grep -v grep | grep HP-ZEROTIER | awk '{print $1}')
						#~ IMPRESORA=$(lpstat -a | grep -v grep | grep PDF | awk '{print $1}')
						# IMPRESORA="Hewlett-Packard-HP-LaserJet-M1536dnf-MFP"
							gdialog --title "Impresion" --yesno "¿Imprime la Orden de Pago? Se enviara a $IMPRESORA_BLANCO"
							if [ $? = 0 ]; then
							lpr -o fit-to-page -o media=a4 -P $IMPRESORA_BLANCO $FILE
							#~ NAME=`basename "$FILE"`
							#~ echo $NAME
							#~ mv $FILE /media/trabajo/Trabajo/Administracion/ORDENES\ DE\ PAGO/SISTEMA/
							#~ else
							#~ mv $FILE /media/trabajo/Trabajo/Administracion/ORDENES\ DE\ PAGO/SISTEMA/
							fi
		done
	#~ fi
	}
pagoscli(){
	# PAGOCLI=/home/$USER/PDF/PC000*.pdf
	if [ -f $PAGOCLI ] ; then
		for FILE in $PAGOCLI ; do
						#~ IMPRESORA=$(lpstat -a | grep -v grep | grep HP-ZEROTIER | awk '{print $1}')
						#~ # IMPRESORA="Hewlett-Packard-HP-LaserJet-M1536dnf-MFP"
							#~ gdialog --title "Impresion" --yesno "¿Imprime la Orden de Pago? Se enviara a $IMPRESORA"
							#~ if [ $? = 0 ]; then
							#~ lpr -o fit-to-page -o media=a4 -P $IMPRESORA $FILE
							#~ NAME=`basename "$FILE"`
							#~ mv $FILE /media/trabajo/Trabajo/Administracion/ORDENES\ DE\ PAGO/SISTEMA/
							#~ else
							mv $FILE /media/trabajo/Trabajo/Administracion/Pagos\ Clientes/PCSISTEMA/
							#~ fi
		done
	fi
	}
remitos1(){
	# REMITO1=/home/$USER/PDF/remito*.pdf
	#~ if [ -f $REMITO ] ; then
		for FILE in $REMITO1 ; do
			#~ IMPRESORA="HP-LaserJet-M1005"
			IMPRESORA=$(lpstat -a | grep -v grep | grep M1005 | awk '{print $1}')
				#~ gdialog --title "Impresion" --yesno "¿Imprime el Remito $FILE? Se enviara a $IMPRESORA"
				#~ if [ $? = 0 ]; then
				#~ lpr -o raw -r -P $IMPRESORA $FILE
				lpr -o fit-to-page -o media=legal -r -P $IMPRESORA $FILE
				#~ NAME=`basename "$FILE"`
				#~ mv $FILE /media/trabajo/Trabajo/WEME/PDF/REMITOS/
				#~ fi
		done
	#~ fi
	}
remitos2(){
		# REMITO2=/home/$USER/PDF/Z__home_administracion_clientes_weme_fuentes_reportes_remito-2*.pdf
	#~ if [ -f $REMITO2 ] ; then
		for FILE in $REMITO2 ; do
			IMPRESORA=$(lpstat -a | grep -v grep | grep HP-ZEROTIER | awk '{print $1}')
			# IMPRESORA="Hewlett-Packard-HP-LaserJet-M1536dnf-MFP"
				#~ gdialog --title "Impresion" --yesno "¿Imprime el Remito $FILE? Se enviara a $IMPRESORA"
				#~ if [ $? = 0 ]; then
				#~ lpr -o raw -r -P $IMPRESORA $FILE
				lpr -o fit-to-page -o media=legal -r -P $IMPRESORA $FILE
				#~ NAME=`basename "$FILE"`
				#~ mv $FILE /media/trabajo/Trabajo/WEME/PDF/REMITOS/
				#~ fi
		done
	#~ fi
	}

export -f facturador
export -f pagos
export -f ncredito
export -f pagoscli
export -f remitos1
export -f remitos2
export -f imprime
export -f imprimedisco
export -f imprimepregunta
export -f gala
export -f gala_credito
export -f naviera
export -f latin
export -f dia
export -f marsano
export IMPRESORA
export IMPRESORA_BLANCO

# exec >> /media/trabajo/Trabajo/scripts/print.logfile 2>&1

# set -ex

sh /media/trabajo/Trabajo/scripts/renombrarfa.sh
# sh /media/trabajo/Trabajo/scripts/renombrarfa.sh

find /home/$USER/PDF/ -maxdepth 1 -iname h__trabajo_weme_retencion-reimp*.pdf -exec /media/trabajo/Trabajo/scripts/firmador.sh {} \; #-exec mv -t /media/trabajo/Trabajo/Administracion/Pagos\ Clientes/PCSISTEMA/ {} \;
find /home/$USER/PDF/ -maxdepth 1 -iname TT20*.pdf -exec /media/trabajo/Trabajo/scripts/firmador.sh {} \; #-exec mv -t /media/trabajo/Trabajo/Administracion/Pagos\ Clientes/PCSISTEMA/ {} \;
find /home/$USER/PDF/ -maxdepth 1 -iname retencion-reimp*.pdf -exec /media/trabajo/Trabajo/scripts/firmador.sh {} \; #-exec mv -t /media/trabajo/Trabajo/Administracion/Pagos\ Clientes/PCSISTEMA/ {} \;
find /home/$USER/PDF/ -maxdepth 1 -iname retencion*.pdf -exec /media/trabajo/Trabajo/scripts/firmador.sh {} \; #-exec mv -t /media/trabajo/Trabajo/Administracion/Pagos\ Clientes/PCSISTEMA/ {} \;
find /home/$USER/PDF/ -maxdepth 1 -iname PC000*.pdf -exec mv -t /media/trabajo/Trabajo/Administracion/Pagos\ Clientes/PCSISTEMA/ {} \;
find /home/$USER/PDF/ -maxdepth 1 -iname CA0003*.pdf -exec bash -c 'credito="{}" ncredito "{}"' \;
find /home/$USER/PDF/ -maxdepth 1 -iname CE0006*.pdf -exec bash -c 'credito="{}" ncredito "{}"' \;
find /home/$USER/PDF/ -maxdepth 1 -iname FA0003*.pdf -exec bash -c 'factura="{}" facturador "{}"' \;
find /home/$USER/PDF/ -maxdepth 1 -iname FE0006*036-001*O*.pdf -exec bash -c 'factura="{}" facturador "{}"' \;
find /home/$USER/PDF/ -maxdepth 1 -iname FE0006*027-*O.pdf -exec bash -c 'factura="{}" facturador "{}"' \;
find /home/$USER/PDF/ -maxdepth 1 -iname FE0006*O*.pdf -exec mv -t /media/trabajo/Trabajo/Administracion/Documentacion/Facturas\ Credito\ A {} \;
find /home/$USER/PDF/ -maxdepth 1 -iname FE0006*D*.pdf -exec mv -t /media/trabajo/Trabajo/Administracion/Documentacion/Facturas\ Credito\ A {} \;
find /home/$USER/PDF/ -maxdepth 1 -iname OP0000*.pdf -exec bash -c 'PAGO="{}" pagos "{}"' \; -exec mv -t /media/trabajo/Trabajo/Administracion/ORDENES\ DE\ PAGO/SISTEMA/ {} \;
find /home/$USER/PDF/ -maxdepth 1 -iname remito*.pdf -exec bash -c 'REMITO1="{}" remitos1 "{}"' \;
find /home/$USER/PDF/ -maxdepth 1 -iname *_remito-2*.pdf -exec bash -c 'REMITO2="{}" remitos2 "{}"' \;

nousar(){
	for i in /home/$USER/PDF/*.pdf /home/$USER/PDF/*.PDF ; do
	#~ RETENCION=$( ls /media/trabajo/Trabajo/Administracion/ORDENES\ DE\ PAGO/SISTEMA/TT20*.pdf)
		for FILE in $RETENCION ; do
						IMPRESORA=$(lpstat -a | grep -v grep | grep HP-ZEROTIER | awk '{print $1}')
						# IMPRESORA="Hewlett-Packard-HP-LaserJet-M1536dnf-MFP"
						NAME=`basename "$FILE"`
							case $NAME in
							*EDICOM_CONNECTING_BUSINESS_SA*signed.pdf)
									rm /media/trabajo/Trabajo/Administracion/ORDENES\ DE\ PAGO/SISTEMA/TT*EDICOM_CONNECTING_BUSINESS_SA.pdf
									echo "Tenemos el agrado de hacerles llegar el detalle del pago realizado. Saludamos atte." | mail -s "Orden de Pago" -A /media/trabajo/Trabajo/Administracion/ORDENES\ DE\ PAGO/SISTEMA/*EDICOM_CONNECTING_BUSINESS_SA*.pdf -- ezequiel@panificadoradelsur.com.ar
									sleep 5
									rm /media/trabajo/Trabajo/Administracion/ORDENES\ DE\ PAGO/SISTEMA/TT*EDICOM_CONNECTING_BUSINESS_SA*.pdf
							;;
							*CONO_SUR_LEVADURAS_SRL*signed.pdf)
									rm /media/trabajo/Trabajo/Administracion/ORDENES\ DE\ PAGO/SISTEMA/TT*CONO_SUR_LEVADURAS_SRL.pdf
									echo "Tenemos el agrado de hacerles llegar el detalle del pago realizado. Saludamos atte." | mail -s "Orden de Pago" -A /media/trabajo/Trabajo/Administracion/ORDENES\ DE\ PAGO/SISTEMA/*CONO_SUR_LEVADURAS_SRL*.pdf -- ezequiel@panificadoradelsur.com.ar
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
	done
	}

#~ comprimir


 } |  tee -a /media/trabajo/Trabajo/scripts/print.logfile 2>&1 # fin de log
