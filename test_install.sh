#! /bin/bash
set -x
#################################################################################
# REVISA QUE ESTE INSTALADO EL PAQUETE PARA COMPRIMIR
instalado() {
#Comprobamos si esta instalado el paquete wget mediante el comando aptitude
# aux=$(aptitude show p7zip-full | grep "Estado: instalado")
PROGRAMA=p7zip-full
aux=$(dpkg --get-selections | grep "$PROGRAMA" | grep "install")
# if `echo "$aux" | grep "Estado: instalado" >/dev/null`
if `echo "$aux" | grep "install" >/dev/null`
then
return 1
else
return 0
fi
}
# llamamos a la funcion
instalado $1 &> /dev/null
#Comprobamos el resultado... si da 1 es que esta instalado y si da 0 es que no esta instalado.
if [ "$?" = "1" ]
then
#Si el paquete esta instalado mando un mensaje
echo el paquete $aux ya esta instado.
#Si no estuviese instalado...por  ejemplo lo instalamos...
else
#sudo apt-get install leafpad
echo El paquete $aux no esta instalado
sudo apt-get install $PROGRAMA
fi
#################################################################################
