#!/bin/bash
conexiones=()
zero=()

# obtengo nombre de interfaz cableada
# cable=$(ifconfig | grep "enp" | awk '{print $1}' | cut -c 1-8)
cable=$(networkctl -a 2>/dev/null | grep "enp" | awk '{print $2}')
# echo $cable
# obtengo nombre de interfaz wifi
wifi=$(ifconfig | grep "wl" | awk '{print $1}' | cut -c 1-7)

# obtengo nombre de interfaz zerotier
zero=$(networkctl -a 2>/dev/null | grep "zt" | awk '{print $2}')

# creo el array con los elementos de cable que la variable no los separa
for i in ${cable[@]}; do
    conexiones=("${conexiones[@]}" $i)
done

# iplocal=$(ip addres show $cable | grep "192.168")
# echo $iplocal
# echo ${conexiones[0]}

PHY_IFACE=${conexiones[0]}
ZT_IFACE=${zero[0]}

# echo $PHY_IFACE
# echo $ZT_IFACE

sudo iptables -t nat -A POSTROUTING -o $PHY_IFACE -j MASQUERADE
sudo iptables -A FORWARD -i $PHY_IFACE -o $ZT_IFACE -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i $ZT_IFACE -o $PHY_IFACE -j ACCEPT

sudo apt install iptables-persistent
sudo bash -c iptables-save > /etc/iptables/rules.v4
