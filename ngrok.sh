##! /bin/sh
source /home/ezequiel/fuente.sh

activo=$(pidof ngrok)
if [[ $activo -eq '' ]]; then
  cd /home/ezequiel/Descargas
  ./ngrok start --all \
    --config=/home/ezequiel/.ngrok2/ngrok.yml \
    --log=stdout \
    > /home/ezequiel/.ngrok2/ngrok.log &


  sleep 15

  url=$(curl http://localhost:4040/api/tunnels | jq .tunnels[0].public_url)

  send_t "url del servicio inventario $url"
else

  url=$(curl http://localhost:4040/api/tunnels | jq .tunnels[0].public_url)

  send_t "url del servicio inventario $url"

fi