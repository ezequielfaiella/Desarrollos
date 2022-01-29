#! /bin/bash
cat <<EOF > /etc/cron.d/administracion
45 * * * * administracion /home/administracion/sync.sh
00 01 * * * administracion export DISPLAY=:0 && /usr/bin/weme
55 23 * * * administracion pkill -15 weme
30 01 * * * administracion pkill -15 weme
30 15 * * 1,2,3,4,5,6 administracion /media/sda3/Trabajo/scripts/reparto.sh
00 19 * * * administracion /media/sda3/Trabajo/scripts/backupbsd.sh
30 19 * * * administracion /media/sda3/Trabajo/scripts/inc.sh
*/9 * * * * administracion /media/sda3/Trabajo/scripts/recibir_de_ediwin_asp.sh
EOF
