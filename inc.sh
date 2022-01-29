#! /bin/bash
# set -x
moverRETzip() {
ruta=/media/trabajo/Trabajo/WEME/ASPEDI/PRODUCCION/ENTRADA/
find $ruta/RET*.TXT -mmin +180 -fprint $ruta/files.txt
7z a $ruta/RET.7z @$ruta/files.txt
rm $(<$ruta/files.txt)
rm $ruta/files.txt
}
borrarfainc() {
ruta=/media/trabajo/Trabajo/WEME/PDF/Enviados/Inc/
find $ruta/*.pdf -mtime +2 -fprint $ruta/files.txt
rm $(<$ruta/files.txt)
rm $ruta/files.txt
}
borrarfamultifood() {
ruta=/media/trabajo/Trabajo/WEME/PDF/Enviados/Multifood/
find $ruta/*.pdf -mtime +2 -fprint $ruta/files.txt
rm $(<$ruta/files.txt)
rm $ruta/files.txt
}
comprimir() {
#~ set -x
ruta="/media/trabajo/Trabajo/Administracion/ORDENES DE PAGO/SISTEMA"
#~ find "$ruta"/*.pdf "$ruta"/*.PDF -mtime +2 -fprint "$ruta"/files.txt
find "$ruta"/*.pdf "$ruta"/*.PDF -fprint "$ruta"/files.txt
7z a "$ruta"/OPVIEJAS.7z @"$ruta"/files.txt
xargs -a "$ruta"/files.txt -d'\n' rm
#~ rm "$(<"$ruta"/files.txt)"
rm "$ruta"/files.txt
# set +x
}
envioOP2(){
	# if [ ! -z "/media/trabajo/Trabajo/Administracion/ORDENES DE PAGO/SISTEMA/"*${CLIENTE}*.pdf ] ; then
	count_file=$(ls -1 "/media/trabajo/Trabajo/Administracion/ORDENES DE PAGO/SISTEMA/"*${CLIENTE}*.pdf 2>/dev/null | wc -l)
	if [ $count_file != 0 ] ; then
		find /media/trabajo/Trabajo/Administracion/ORDENES\ DE\ PAGO/SISTEMA/ -maxdepth 1 -iname "*${CLIENTE}*.pdf" > /tmp/${CLIENTE}.txt 
		if [ -s /tmp/${CLIENTE}.txt ]; then
			while IFS= read -r attachment; do
				attachments+=( -a "$attachment" )
			done < /tmp/${CLIENTE}.txt
			#echo "Se adjuntan los comprobantes electrónicos del pago realizado. Saludamos atte." | mutt -s "Orden de Pago" "${attachments[@]}" -- "${CLIENTEMAIL}" grupoweme@gmail.com
			echo "Se adjuntan los comprobantes electrónicos del pago realizado. Saludamos atte." | mail -s "Orden de Pago" -A "${attachments[@]}" -- "${CLIENTEMAIL}" grupoweme@gmail.com
			rm /tmp/${CLIENTE}.txt
			unset attachments[@]
			else
			# exit
			break
		fi
	fi
}
envioOP(){
	if [ ! -z "/media/trabajo/Trabajo/Administracion/ORDENES DE PAGO/SISTEMA/"*${CLIENTE}*.pdf ] ; then
		cd /media/trabajo/Trabajo/Administracion/ORDENES\ DE\ PAGO/SISTEMA/
		# echo "Se adjuntan los comprobantes electrónicos del pago realizado. Saludamos atte." | mail -s "Orden de Pago" -A *${CLIENTE}*.pdf  -- grupoweme@gmail.com "${CLIENTEMAIL}"
		echo "Se adjuntan los comprobantes electrónicos del pago realizado. Saludamos atte." | mutt -s "Orden de Pago" -a *${CLIENTE}*.pdf  -- grupoweme@gmail.com "${CLIENTEMAIL}"
	fi
}

unirpdf(){
	count_file=$(ls -1 "/media/trabajo/Trabajo/Administracion/ORDENES DE PAGO/SISTEMA/"*${CLIENTE}*.pdf 2>/dev/null | wc -l)
	if [ $count_file != 0 ] ; then
		ruta="/media/trabajo/Trabajo/Administracion/ORDENES DE PAGO/SISTEMA"
		nombre=$(basename -s .pdf "$(ls "$ruta"/*${CLIENTE}*.pdf | head -1)" )
		pdftk "$ruta"/*${CLIENTE}*.pdf cat output /tmp/$nombre.pdf
		rm "$ruta"/*${CLIENTE}*.pdf
		mv /tmp/$nombre.pdf /"$ruta"
	fi
}

[[ ! -z `find /media/trabajo/Trabajo/WEME/PDF/ -maxdepth 1 -name 'FA0003????????-044-*.pdf'` ]] && \
echo "Se adjuntan los comprobantes electrónicos de las facturas de las próximas entregas. Saludamos atte." \
| mutt -s "Factura Electrónica" -a /media/trabajo/Trabajo/WEME/PDF/FA0003????????-044-*.pdf -- grupoweme@gmail.com #ar_contabilidad_proveedores@carrefour.com
[ $? == 0 ] && mv /media/trabajo/Trabajo/WEME/PDF/FA0003????????-044-*.pdf /media/trabajo/Trabajo/WEME/PDF/Enviados/Inc/
mv /media/trabajo/Trabajo/WEME/PDF/FA0003????????-002-*.pdf /media/trabajo/Trabajo/WEME/PDF/Enviados/Multifood/ 2>/dev/null
rm /media/trabajo/Trabajo/WEME/PDF/FA0003????????-019-*.pdf 2>/dev/null
rm /media/trabajo/Trabajo/WEME/PDF/Enviados/FA0003????????-019-*.pdf 2>/dev/null
rm /media/trabajo/Trabajo/WEME/PDF/FA0003????????-016-*.pdf 2>/dev/null
rm /media/trabajo/Trabajo/WEME/PDF/Enviados/FA0003????????-016-*.pdf 2>/dev/null
rm /media/trabajo/Trabajo/WEME/PDF/Enviados/FA0003????????-021-*.pdf 2>/dev/null
rm /media/trabajo/Trabajo/WEME/PDF/Enviados/FA0003????????-047-*.pdf 2>/dev/null
rm /media/trabajo/Trabajo/WEME/PDF/Enviados/FA0003????????-022-*.pdf 2>/dev/null
rm /media/trabajo/Trabajo/WEME/PDF/Enviados/FA0003????????-020-*.pdf 2>/dev/null
rm /media/trabajo/Trabajo/WEME/PDF/CA0003????????-*.pdf 2>/dev/null
moverRETzip
borrarfainc
borrarfamultifood
#
set -x
CLIENTE="EDICOM"
CLIENTEMAIL="adminar@edicomgroup.com"
# unirpdf
envioOP

CLIENTE="CONO_SUR"
CLIENTEMAIL="ga.cristaldo@lesaffre.com"
# unirpdf
envioOP
# 
CLIENTE="SERV_AMB"
CLIENTEMAIL="administracion@serviciosambientales.com.ar"
# unirpdf
envioOP
# #
CLIENTE="YOHAI"
CLIENTEMAIL="facturacionplusplast@hotmail.com"
# unirpdf
envioOP
# #
CLIENTE="ABC"
CLIENTEMAIL="ventas@abcempaques.com.ar"
# unirpdf
envioOP
#
CLIENTE="MAGI-PACK"
CLIENTEMAIL="ventas@magipack.com.ar"
# unirpdf
envioOP
#
CLIENTE="GEMS"
CLIENTEMAIL="gemsint@gems-int.com"
# unirpdf
envioOP
#
CLIENTE="MITO"
CLIENTEMAIL="cobranzas@mitolaboral.com.ar"
# unirpdf
envioOP
#
CLIENTE="VICTORY"
CLIENTEMAIL="mflores@victorylimpieza.com.ar"
# unirpdf
envioOP
#
CLIENTE="ALIMENTARIA"
CLIENTEMAIL="contaduria@asmlab.com.ar"
# unirpdf
envioOP
#
CLIENTE="MARSANO"
CLIENTEMAIL="salineramarzano@hotmail.com"
# unirpdf
envioOP
#
CLIENTE="RESIS_TACK"
CLIENTEMAIL="martin_mateljan@hotmail.com"
# unirpdf
envioOP
#
CLIENTE="VASEPLUS"
CLIENTEMAIL="cobranzas@vaseplus.com.ar, elisa@vaseplus.com.ar"
# unirpdf
envioOP
#
CLIENTE="PLANEXWARE"
CLIENTEMAIL="cobranzas@planexware.com"
# unirpdf
envioOP
#
CLIENTE="IRIARTE"
CLIENTEMAIL="Cintia@giriarte.com.ar"
# unirpdf
envioOP
#
CLIENTE="VELASCO"
CLIENTEMAIL="imprentavelasco@yahoo.com.ar"
# unirpdf
envioOP
#
CLIENTE="CALDERON"
CLIENTEMAIL="sistemas@estudiocalderon.com.ar "
# unirpdf
envioOP
#
CLIENTE="KATZ"
CLIENTEMAIL="polibm@hotmail.com"
# unirpdf
envioOP
#
CLIENTE="CALSA"
CLIENTEMAIL="Norma.Fiorella@calsa.com.ar"
# unirpdf
envioOP
#
CLIENTE="SUPER_CONGELADOS"
CLIENTEMAIL="supercongelados@scrp.com.ar"
# unirpdf
envioOP
#       
comprimir
#~ 

# set +x
FECHA=$(date "+Y%m%d")
date >> /media/trabajo/Trabajo/scripts/limpieza.txt
USADO=$(wc -l /media/trabajo/Trabajo/scripts/limpieza.txt | awk {'print $1'})
if [ $USADO -ge 30 ]; then
cat /dev/null > /media/trabajo/Trabajo/scripts/limpieza.txt
fi
if [ $USADO -eq 30 ]; then
mv /media/trabajo/Trabajo/WEME/ASPEDI/PRODUCCION/ENTRADA/pedidos/pedidosviejos.7z /media/trabajo/Trabajo/Administracion/Varios/BORRARMENSUAL/${FECHA}_pedidosviejos.7z
find /media/trabajo/Trabajo/Administracion/ -maxdepth 1 -type f -mtime +45 -name '*.tar.xz' -exec mv '{}' /media/trabajo/Trabajo/Administracion/Varios/BORRARMENSUAL/ \;
fi
