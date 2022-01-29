#!/usr/bin/bash
# -*- coding: utf-8 -*-

# if [ $# -lt 5 ]; then
#   echo "Example: sh Bulkdbf2mysql.sh <directory_where_files_are> <host> <database> <password> <user>"
#   echo "Example: sh Bulkdbf2mysql.sh /home/german/Documents/ localhost escuela root root dbf"
#   exit
# fi

# datos para acceder a la bd
ast="*"
dir=/home/ezequiel/Nextcloud/bcktrabajo/WEME/
host=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' previoborrar_mariadb_1)
database=weme
password=example
user=root

# busco el ultimo backup y lo extraigo
# comprimido=$(ls -at /media/trabajo/Trabajo/backupsistema/*.ZIP | head -1)

# unzip -P avellaneda $comprimido -d $dir -x "*2012/*" "*descarte/*" "*instalar/*" "*vacio/*" "parb*" "padr*" "foxy*" "login_*" "codpos*"

# rm -dR $dir'2012'
# rm -dR $dir'descarte'
# rm -dR $dir'instalar'
# rm -dR $dir'vacio'
# rm $dir'parbaret.'*
# rm $dir'padrarba.'*


# # borro la base de datos del docker si existe
bash -c "docker exec -it $(docker ps | grep maria | awk '{print $1}') mysql -uroot -pexample -e 'DROP DATABASE IF EXISTS weme; CREATE DATABASE weme; commit;'"
# bash -c "docker exec -it previoborrar_mariadb_1 mysql -uroot -pexample -e 'DROP DATABASE IF EXISTS weme; CREATE DATABASE weme; commit;'"

# # paso el dbf a mariadb


for file in $dir$ast.dbf
  do
    if [ -f "$file" ];then
      var=$(echo $file | awk -F"$dir$ast" '{print $1,$2}')
      set -- $var
      file_name=$1
      var=$(echo $file_name | awk -F".DBF" '{print $1,$2}')
      set -- $var
      uppercase=$1
      var=$(echo $uppercase | awk -F".dbf" '{print $1,$2}')
      set -- $var
      table_name=$(echo $1 | tr '[:upper:]' '[:lower:]')
      table=$table_name
      dbf2mysql -h "$host" -d "$database" -t "$table" -c -vvv -P "$password" -U "$user" "$file"
    fi
  done

      # dbf2mysql -h "$host" -d "$database" -t faccta.dbf -c -vvv -P "$password" -U "$user" "$file"
# rm -dR $dir