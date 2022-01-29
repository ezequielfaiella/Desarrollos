#/bin/bash
LOG_FILE=/tmp/syncnas.log
set -x
#~ exec >& /home/administracion/syncnas.log
#exec 1>/home/administracion/syncnas.log 2>&1

#wget -a /tmp/ip.txt buffalonas.com/weme -O /tmp/weme
#IPNAS=$(sed -n -e '/Location/p' /tmp/ip.txt |  awk '{ print $2 }' | cut -d/ -f3 | cut -d: -f1)
 #IPNAS=158.101.197.50
# echo $IPNAS
#rm /tmp/ip.txt
#rm /tmp/weme

FECHA=$(date +'%Y%m%d')

zip --delete /media/trabajo/Trabajo/backupsistema/$FECHA.ZIP /instalar/GARBAGE/\* /reparar/\* *.sync-conflict* -P avellaneda
find /media/trabajo/Trabajo -type f -iname "*sync-conflict*" -exec mv {} -t "/home/ezequiel/sync-conflict/" \;

IPNAS=100.112.134.59
#~ IPNAS=fayu666.mooo.com
# IPNAS=fayu666.ddns.net
# IPNAS=fayu66.duckdns.org
# IPNAS=10.147.19.160

exec 2>&1 
{
date
echo "NAS EN CASA"
# sshpass -p password rsync -avz -e 'ssh -p2222 -o StrictHostKeyChecking=no -o KexAlgorithms=+diffie-hellman-group1-sha1' /media/trabajo/Trabajo/ root@$IPNAS:/mnt/disk2/bckptrabajo --exclude 'scripts/.git/'
sshpass -p fayu4519 rsync -avz -e 'ssh -o StrictHostKeyChecking=no -o KexAlgorithms=+diffie-hellman-group1-sha1' /media/trabajo/Trabajo/ admin@$IPNAS:/mnt/disk2/bckptrabajo --exclude 'scripts/.git/'
#~ ssh -p2222 root@$IPNAS
#sshpass -p fayu4519 rsync -avz -e 'ssh -p22  -o StrictHostKeyChecking=no' /media/trabajo/Trabajo/ pi@$IPNAS:/home/pi/backtrabajo --exclude 'scripts/.git/' --exclude '.git/'
echo
echo
echo
echo
echo "-------------------------------------------------------------------------------------------------"
echo
echo
echo
echo "VPS de ORACLE"
rsync -avz -e 'ssh -i /home/ezequiel/.ssh/ssh-key-vps1.key -p22' --no-whole-file --no-perms --delete --exclude '.Trash-1000/' --exclude '/home/ezequiel/Documentos/bckptrabajo/SinUso/impresora.tar.gz' --exclude 'scripts/.git/' /media/trabajo/Trabajo/ ubuntu@158.101.197.154:bckptrabajo
# date
} | tee $LOG_FILE

	
	TOKEN="xxxxxxxxxxxxxxxxx"
	ID="xxxxxxxxx"
	URLT="https://api.telegram.org/bot$TOKEN/sendMessage"
	MENSAJE=$(cat $LOG_FILE )
	curl -s -X POST $URLT -d chat_id=$ID -d text="$MENSAJE"
	
#cat $LOG_FILE | mutt -s "Backup NAS" -- grupoweme@gmail.com
cat $LOG_FILE | mail -s "Backup NAS" grupoweme@gmail.com

rm $LOG_FILE
