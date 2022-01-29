#!/bin/bash

FUENTE=~/fuente.sh
if [ -f $FUENTE ]; then
	source $FUENTE
else
	DISPLAY=:0 gdialog --msgbox "No se encuentra el archivo fuente en el HOME"
	#~ echo "No se encuentra el archivo fuente en el HOME"
	exit
fi
set -x
arranque
ESCRITORIO=$(grep XDG_DESKTOP_DIR ~/.config/user-dirs.dirs | cut -f2 -d \" | cut -f2 -d /)
cd /home/$USER/.WEME
#cd /media/trabajo/Trabajo/WEME
SISTEMA=$(ls -at weme*.exe | head -1)
SISTEMASERVER=$(ls -at /media/trabajo/Trabajo/WEME/weme* | head -1)

if [ $(basename -s .exe $SISTEMA) != $(basename $SISTEMASERVER) ]; then
	gdialog --msgbox "Version del Sistema de Gestion Desactualizada. Version actual $SISTEMASERVER.exe, version instalada $SISTEMA" 
	cd /media/trabajo/Trabajo/WEME
	WEME=$(ls -at weme2* | head -1)
	cp $WEME /home/$USER/.WEME/$WEME.exe
	exit
fi

if [ "$(ls -A ${DIRTRABAJO2})" ]; then 
notify-send $SISTEMA
wine $SISTEMA
else 
gdialog --msgbox "Debe montar el directorio Trabajo antes de iniciar el sistema (weme.sh)" 
fi

