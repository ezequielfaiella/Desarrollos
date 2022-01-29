# -a : Esta opción combina el parámetro -r para que el recorra toda la estructura de directorios que le indiquemos, el -l para que copie enlaces
# simbólicos como enlaces simbólicos, la -p para que mantenga los permisos, la -t para que se mantenga la hora del fichero, la -g para que se
# mantenga el grupo, la -o para que se mantenga el propietario, la -D para que se mantengan los ficheros de dispositivo (sólo para root). Ni se
# mantienen los hard links (-H) ni las ACLs (-A) por defecto. En definitiva, con la opción -a obtenemos una copia exacta de una jerarquía de 
# ficheros y directorios.
#
# -v: es para que nos muestre información más detallada sobre lo que hace
#
# -W: copia archivo completo, no solo los cambios del mismo
#
# -z: comprime
#
# Efectivamente, /path/foo significa “el directorio foo“, mientras que /path/foo/ significa “lo que hay dentro de foo“. 
#
# --delete: En muchos casos, es posible que hayamos borrados ficheros de origen que ya no queremos que aparezcan en el destino, pero por defecto 
# rsync no los elimina. Para que lo haga, debemos usar la opción
#
# -n/--dry-run: para que el comando no haga nada en realidad y así podamos depurar el comando antes de ponerlo en funcionamiento definitivamente
#
# -u, para que no se sobreescriban los ficheros del destino que son más recientes que los del origen
#
# -r la sincronización se realizará recursivamente, haciendo un recorrido del origen y creando los subdirectorios necesarios en el destino
#

#NOTA IMPORTANTE de SINTAXIS de RSYNC: Cuando una ruta de directorio tiene un espacio en blanco, en la terminal escribimos

#$ cd directorio\ con\ espacios

#! /bin/bash
#sudo mount -t smbfs -o username=administrador,password=123,uid=ezequiel,gid=users //192.168.1.3/H/Trabajo /media/trabajo
#~ sudo umount /media/trabajo
mkdir /tmp/trabajo
sudo mount -t cifs -o username=backup,password=666,uid=$USER,gid=users //192.168.2.6/Trabajo /tmp/trabajo
rsync -avz --progress --delete --exclude '/tmp/trabajo/Trabajo/WEME/ASPEDI' --exclude '/tmp/trabajo/Trabajo/WEME/cache' /tmp/trabajo/Trabajo /home/ezequiel/Box/trabajo
sudo umount /tmp/trabajo
# sincroniza de este disco al disco extraible
#rsync -avz --delete /media/EXPRESSGATE/bcktrabajo /media/ezequiel/UUI/pendrive/bcktrabajo
