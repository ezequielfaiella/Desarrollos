#! /bin/bash
#tail -f /var/log/syslog | grep CRON
#tail -f /var/log/syslog | grep recibir_de_ediwin_asp.sh
tail -n 5 /var/log/syslog | grep recibir_de_ediwin_asp.sh
