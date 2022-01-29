#! /bin/bash
#			USO
#	inotifywait -m -e create -e moved_to /media/trabajo/Trabajo/WEME/ASPEDI/PRODUCCION/SALIDA/ | while read FILE
#	do
#	sh /media/trabajo/Trabajo/scripts/tantasfacturas.sh
#	notify-send "Se Envia a Facturar $FILE"
#	done
#
#
	inotifywait -m -e create -e moved_to /media/trabajo/Trabajo/WEME/ASPEDI/PRODUCCION/SALIDA/ | while read FILE
	do
	rm /media/trabajo/Trabajo/scripts/recibir_de_ediwin_asp.sh.lock		
	sh /media/trabajo/Trabajo/scripts/tantasfacturas.sh
	notify-send "Se Envia a Facturar $FILE"
	done

while true; do
    inotifywait -m -e create -e moved_to -e modify /media/trabajo/Trabajo/scripts/lab/carpeta/ |    sh /media/trabajo/Trabajo/scripts/mail.sh
done