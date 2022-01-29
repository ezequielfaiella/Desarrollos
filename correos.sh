#!/bin/sh
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
    inotifywait -e create -e moved_to /home/$USER/PDF/ 
    sh /media/trabajo/Trabajo/scripts/renombrarfa.sh
    sh /media/trabajo/Trabajo/scripts/mail.sh
done
