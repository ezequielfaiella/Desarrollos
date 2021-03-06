#!/bin/bash
################
# si no escribio nada con el comando, notifica
################
if [ -z $1 ]
then
  lugar= echo "*** Debe escribir una conexion ***"
  exit 0
elif [ -n $1 ]
then
# otherwise make first arg as a rental
  lugar=$1
fi

################
# establece los casos
################
case $lugar in
   "adminlocal") RHOST="administracion@192.168.100.17 -p 77";;
   "adminremoto") RHOST="administracion@10.147.19.144 -p 77";;
  #  "casalocal") RHOST=192.168.1.66;;
  #  "casaremoto") RHOST=ezequiel.no-ip.info;;
   *) echo "Error, no conozco $lugar!";;
esac



LOCAL_PORT=6000
REMOTE_HOST=${RHOST}
REMOTE_PORT=5900

echo "Opening SSH tunnel"
# Do not use '-f' because '&' already forces background
# '-f' disables PID retrieval
ssh -C -NL ${LOCAL_PORT}:localhost:${REMOTE_PORT} ${REMOTE_HOST} &
SSH_PID=$!
echo "Connecting to ${REMOTE_HOST}"
sleep 15
vinagre ::${LOCAL_PORT}
kill ${SSH_PID}
