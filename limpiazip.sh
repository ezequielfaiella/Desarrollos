#!/bin/bash

FECHA=$(date +'%Y%m%d')
 #~ FECHA=20190401

zip --delete /media/trabajo/Trabajo/backupsistema/$FECHA.ZIP /instalar/GARBAGE/\* /reparar/\* *.sync-conflict* -P avellaneda
find /media/trabajo/Trabajo -type f -iname "*sync-conflict*" -exec mv {} -t "/home/$USER/sync-conflict/" \;
