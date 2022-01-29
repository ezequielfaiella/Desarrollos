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
dirs="/media/trabajo/Trabajo/WEME/exportacion/ /home/$USER/PDF/ /media/trabajo/Trabajo/WEME/ASPEDI/PRODUCCION/SALIDA/"

while inotifywait -e create -e moved_to $dirs; do
	sh /media/trabajo/Trabajo/scripts/renombrarfa.sh &
	sh /media/trabajo/Trabajo/scripts/mail.sh &
	sh /media/trabajo/Trabajo/scripts/xlstoods.sh &
	sh /media/trabajo/Trabajo/scripts/tantasfacturas.sh &
#	x-terminal-emulator -e "bash /media/trabajo/Trabajo/scripts/forzartantasfacturas.sh"	# muestra terminal con lo que esta haciendo
done


#~ #!/bin/bash
#~ shopt -s globstar

#~ dirs="/media/trabajo/Trabajo/WEME/exportacion/ /home/$USER/PDF/ /media/trabajo/Trabajo/WEME/ASPEDI/PRODUCCION/SALIDA/"

#~ while inotifywait -e create -e delete -e modify -e attrib -e move $dirs; do
    #~ find $HOME/.local/bin -type l -delete
    #~ find $dirs -follow -mindepth 1 -maxdepth 1 -type f -executable -exec ln -s {} $HOME/.local/bin \;
#~ done
