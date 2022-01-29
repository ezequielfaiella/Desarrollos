#!/bin/bash
# se fija si ya esta corriendo
if pidof -x $(basename $0) > /dev/null; then
  for p in $(pidof -x $(basename $0)); do
    if [ $p -ne $$ ]; then
      echo "El script $0 ya se está ejecutando. Saliendo..."
      exit
    fi
  done
fi
#
#
while true; do
		inotifywait -e create -e moved_to /media/trabajo/Trabajo/WEME/ASPEDI/PRODUCCION/SALIDA/
		sh /media/trabajo/Trabajo/scripts/tantasfacturas.sh
#		x-terminal-emulator -e "bash /media/trabajo/Trabajo/scripts/forzartantasfacturas.sh"	# muestra terminal con lo que esta haciendo
done
