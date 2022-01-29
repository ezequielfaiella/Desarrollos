#!/bin/bash

# Initial Trusted Domain
IFACE=$( ip r | grep "default via" | awk '{ print $5 }' )
IP=$( ip a | grep "$IFACE" | grep -oP '\d{1,3}(.\d{1,3}){3}' | head -1 )

docker run -d -p 4443:4443 -p 443:443 -p 80:80 -v ncdata:/data --name nextcloudpi ownyourbits/nextcloudpi $IP

# Configure static IP as trusted domain in nextcloudpi container
#~ sudo docker exec -ti nextcloudpi /bin/bash
#~ sed -i "10i 3 =&gt; 'STATIC-IP'," /var/www/nextcloud/config/config.php
# The line number '10' and array index '3' needs to be figured out for your setup
