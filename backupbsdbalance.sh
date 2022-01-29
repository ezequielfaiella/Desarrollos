#! /bin/sh
#find dir/to/search -type f \( -iname '*foo*' -o -iname '*bar*' \) -exec mv -i -t /path/to/destination {} +
#find /media/trabajo/Trabajo/Administracion/Sueldos/ -type f \( -newermt 2013-09-15 ! -newermt 2013-10-15 \) -exec mv -i -t /media/trabajo/Trabajo/Administracion/Sueldos/201509 {} +
#	busca por las fechas y crea el zip
#find /media/trabajo/Trabajo/Administracion/Sueldos/ -type f \( -newermt 2015-09-16 ! -newermt 2015-10-15 \) -exec zip -j -T 201509.zip {} +
#
	set +x
#

#################################################################################
# REVISA QUE ESTE INSTALADO EL PAQUETE PARA COMPRIMIR
instalado() {
#Comprobamos si esta instalado el paquete wget mediante el comando aptitude
# aux=$(aptitude show p7zip-full | grep "Estado: instalado")
PROGRAMA=p7zip-full
aux=$(dpkg --get-selections | grep "$PROGRAMA" | grep "install")
# if `echo "$aux" | grep "Estado: instalado" >/dev/null`
if `echo "$aux" | grep "install" >/dev/null`
then
return 1
else
return 0
fi
}
# llamamos a la funcion
instalado &> /dev/null
#Comprobamos el resultado... si da 1 es que esta instalado y si da 0 es que no esta instalado.
if [ "$?" = "1" ]
then
#Si el paquete esta instalado mando un mensaje
echo el paquete $aux ya esta instado.
#Si no estuviese instalado...por  ejemplo lo instalamos...
else
#sudo apt-get install leafpad
echo El paquete $aux no esta instalado
sudo apt-get install $PROGRAMA
fi

moverzip() {
ruta=/media/trabajo/Trabajo/backupsistema/
find $ruta/*.ZIP -mtime +7 -fprint $ruta/files.txt
mv $(<$ruta/files.txt) /media/administracion/018A9ABF15B4D927/zip_sistema/
rm $ruta/files.txt
}
#################################################################################

# busca todos los archivos no .zip
	FECHA=$(date +%Y%m%d -d '-1 days')
	# FECHA=$(date +%Y%m%d)
	mkdir /media/trabajo/Trabajo/Administracion/BALANCES/balance_$FECHA
	find /media/trabajo/Trabajo/WEME/ -maxdepth 1 -type f \( -iname 'faccta.*' -o -iname 'campos.*' -o -iname 'sigaremi.*' -o -iname 'paccta.*' -o -iname 'pigaremi.*' -o -iname 'sigalie.*' -o -iname 'sigaprov.*' -o -iname 'sigaart.*' -o -iname 'sigaum.*' -o -iname 'sigalist.*' -o -iname 'sigaprec.*' -o -iname 'tablas.*' ! -iname '*.tar.gz' -o -iname 'retorno.*' -o -iname 'sigaclie.*' -o -iname 'sigatrem.*' -o -iname 'pigatrem.*' -o -iname 'campos.*' \) -exec 7z a /home/ezequiel/Documentos/balance_$FECHA/$FECHA.7z {} +
	#~ [[ ! -z `find /tmp/ -maxdepth 1 -name $FECHA'.7z'` ]] && echo "Se adjuntan las bases de datos al dia de la fecha a modo de backup para realizar el balance." | mutt -s "Backup Balance $FECHA" -a /tmp/$FECHA.7z -- grupoweme@gmail.com ; rm /tmp/$FECHA.7z
	cp /media/trabajo/Trabajo/Administracion/1\ Uso\ Diario/BancoFrances.ods /media/trabajo/Trabajo/Administracion/BALANCES/balance_$FECHA/
	cp /media/trabajo/Trabajo/Administracion/1\ Uso\ Diario/CAMI.ods /media/trabajo/Trabajo/Administracion/BALANCES/balance_$FECHA/
