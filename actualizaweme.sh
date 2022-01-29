#! /bin/bash/
#~ set -x
#
# AGREGAR CONTROL DE INTEGRIDAD
# CON SHA
#

#WEME=weme1613.exe
cd /media/trabajo/Trabajo/WEME
WEME=$(ls -at weme2* | head -1)
cp $WEME /home/ezequiel/.WEME/$WEME.exe
scp /home/ezequiel/.WEME/$WEME.exe adminremoto:/home/administracion/.WEME/$WEME.exe
scp /home/ezequiel/.WEME/$WEME.exe 10.147.19.183:/home/administracion/.WEME/$WEME.exe
