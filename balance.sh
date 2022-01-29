#! /bin/bash 
cd /media/trabajo/Trabajo/
HOY=$(date +"%Y%m%d") 
tar cvzf BALANCE_ARCHIVOS_$HOY.tar --exclude='media/trabajo/Trabajo/WEME/2012' --exclude='media/trabajo/Trabajo/WEME/ASPEDI' --exclude='media/trabajo/Trabajo/WEME/descarte' --exclude='media/trabajo/Trabajo/WEME/PDF' --exclude='media/trabajo/Trabajo/WEME/instalar' --exclude='media/trabajo/Trabajo/WEME/reparar' --exclude='media/trabajo/Trabajo/WEME/vacio' --exclude='media/trabajo/Trabajo/WEME/weme*' --exclude='media/trabajo/Trabajo/WEME/padrarba*' --exclude='media/trabajo/Trabajo/WEME/parbaret*' /media/trabajo/Trabajo/WEME/* "/media/trabajo/Trabajo/Administracion/1 Uso Diario/CAMI.ods" "/media/trabajo/Trabajo/Administracion/1 Uso Diario/BancoFrances.ods"
mv BALANCE_ARCHIVOS_$HOY.tar /home/ezequiel/Sync/

