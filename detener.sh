#!/bin/bash
#~ set -x
export DISPLAY=:0.0
ps aux | grep -v grep | grep [r]ecibir_de_ediwin_asp.sh | awk '{print $2}' | xargs kill -15 2> /dev/null
ps aux | grep -v grep | grep [t]antasfacturas.sh | awk '{print $2}' | xargs kill -15 2> /dev/null
ps aux | grep -v grep | grep [j]ava | awk '{print $2}' | xargs kill -9 2> /dev/null
sleep 30
ps aux | grep -v grep | grep [r]ecibir_de_ediwin_asp.sh | awk '{print $2}' | xargs kill -9 2> /dev/null
ps aux | grep -v grep | grep [t]antasfacturas.sh | awk '{print $2}' | xargs kill -9 2> /dev/null
ps aux | grep -v grep | grep [j]ava | awk '{print $2}' | xargs kill -9 2> /dev/null
#~ case $USER in
			#~ administracion)
					#~ rm /media/sda3/Trabajo/scripts/tantasfacturas.sh.lock
					#~ rm /media/sda3/Trabajo/scripts/recibir_de_ediwin_asp.sh.lock
					#~ mv /media/sda3/Trabajo/scripts/_recibir_de_ediwin_asp.sh.lock /media/sda3/Trabajo/scripts/recibir_de_ediwin_asp.sh.lock
					#~ mv /media/sda3/Trabajo/scripts/_recibir_de_ediwin_asp.sh /media/sda3/Trabajo/scripts/recibir_de_ediwin_asp.sh
					#~ rm /tmp/recibir_de_ediwin_asp.sh.pid
					#~ rm /tmp/tantasfacturas.sh.pid
					#~ ;;
			#~ *)
					rm /media/trabajo/Trabajo/scripts/tantasfacturas.sh.lock 2> /dev/null
					rm /media/trabajo/Trabajo/scripts/recibir_de_ediwin_asp.sh.lock 2> /dev/null
					mv /media/trabajo/Trabajo/scripts/_recibir_de_ediwin_asp.sh.lock /media/trabajo/Trabajo/scripts/recibir_de_ediwin_asp.sh.lock 2> /dev/null
					mv /media/trabajo/Trabajo/scripts/_recibir_de_ediwin_asp.sh /media/trabajo/Trabajo/scripts/recibir_de_ediwin_asp.sh 2> /dev/null
					rm /tmp/recibir_de_ediwin_asp.sh.pid 2> /dev/null
					rm /tmp/tantasfacturas.sh.pid 2> /dev/null
					#~ ;;
#~ esac
