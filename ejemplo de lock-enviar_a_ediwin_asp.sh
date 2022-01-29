#!/bin/bash

lockfile=/media/trabajo/Trabajo/WEME/ASPEDI/enviar_a_ediwin_asp.sh.lock

if ( set -o noclobber; echo "$$" > "$lockfile") 2> /dev/null;
then
trap 'rm -f $lockfile; exit' INT TERM EXIT
touch $lockfile
		cd /home/$(whoami)/ASPEDI/
scriptname="ENVIAR SII--EBI--JS (30711378355)"


java -Xmx512m -Xms128m -jar ebinetx.jar -update 86400 -basedir $PWD -headless -property script="$scriptname" -property user.dir=$PWD -property user.log=log/ -property java.io.tmpdir=$PWD/tmp -property mode=CMD -properties ebiadapter.properties



exit



rm $lockfile
trap - INT TERM EXIT

else

echo "ya hay otro proceso corriendo"

fi

