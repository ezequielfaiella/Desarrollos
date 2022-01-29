#!/usr/bin/bash
# -*- coding: utf-8 -*-

# requisito python3 -m pip install dbf-to-sqlite
# pip install sqlite3-to-mysql para mandarlo a mariadb
# sqlite3mysql --help
#  sudo apt install -y dbf2mysql        # del dbf directamente a mariadb o mysql
# sudo apt install mariadb-client-core-10.3         para tener mysql y podes borrar y crear la tabla

if [[ $HOSTNAME = 'ezequiel-desktop' ]]; then
    BASE='/media/trabajo/Trabajo'
else
    BASE='home/ezequie/trabajo/Trabajo'

fi

ruta=$BASE'/WEME'
# ruta='/home/ezequiel/Nextcloud/bcktrabajo/WEME/'
rutadestino=$BASE
mkdir '/tmp/db'
rutatemp='/tmp/db'

files=('sigaclie.fpt' 'sigaremi.cdx' 'sigaclie.cdx' 'campos.dbf' 'campos.fpt' 'campos.cdx' 'sigaclie.dbf' 'sigaremi.dbf' 'faccta.dbf' 'faccta.cdx' 'paccta.dbf' 'paccta.fpt' 'paccta.cdx' 'pigaremi.dbf' 'pigaremi.fpt' 'pigaremi.cdx' 'retorno.dbf' 'sigaart.dbf' 'sigaart.cdx' 'sigalist.dbf' 'sigalist.fpt' 'sigalist.cdx' 'sigaprec.dbf' 'sigaprec.cdx' 'sigatrem.dbf' 'sigatrem.cdx' 'sigatrem.fpt' 'sigaum.dbf' 'sigaum.cdx' 'tablas.dbf' 'tablas.fpt' 'tablas.cdx' 'pigatrem.dbf' 'pigatrem.fpt' 'pigatrem.cdx') # 'sigaprov.dbf' 'sigaprov.cdx')

for i in ${files[@]}; do
     #echo $ruta$i
    cp $ruta/$i $rutatemp
done

for i in $rutatemp/*.dbf; do 
 	# echo $i
    dbf-to-sqlite $i $rutatemp/wemeback.db; 
done
 
mv $rutatemp/wemeback.db $rutadestino/wemeback.db

sqlite3 $rutadestino/wemeback.db 'delete from faccta WHERE (tipodoc="FA" or tipodoc="FE") and cae="                    "'

# paso de sqlite a la base de maria db

bash -c "docker exec -it $(docker ps | grep maria | awk '{print $1}') mysql -uroot -pexample -e 'DROP DATABASE IF EXISTS weme; CREATE DATABASE weme; commit;'"

sqlite3mysql -f $rutadestino/wemeback.db -d weme -u root --mysql-password example -h localhost





# ## SE BORRAN LOS ARCHIVOS DEL DIRECTORIO TEMPORAL
rm -dR $rutatemp


