 #/bin/bash
 wget -a /tmp/ip.txt buffalonas.com/weme -O /tmp/weme
 IPNAS=$(sed -n -e '/Ubicación/p' /tmp/ip.txt |  awk '{ print $2 }' | cut -d/ -f3 | cut -d: -f1)
 echo $IPNAS
 rm /tmp/ip.txt
 rm /tmp/weme
