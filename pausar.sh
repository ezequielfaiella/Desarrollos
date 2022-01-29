#!/bin/bash
	ps aux | grep -v grep | grep recibir_de_ediwin_asp.sh | awk {print'$2'} > /media/trabajo/Trabajo/scripts/pid.log
	ps aux | grep -v grep | grep java | awk {print'$2'} >> /media/trabajo/Trabajo/scripts/pid.log
	kill -STOP $(cat /media/trabajo/Trabajo/scripts/pid.log)
sleep 60
	kill -CONT $(cat /media/trabajo/Trabajo/scripts/pid.log)

