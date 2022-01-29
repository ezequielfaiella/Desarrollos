#!/bin/bash
# no usar. hay que probar.
#sudo curlftpfs -o allow_other nonempty ftp://remoto:30363864@fayu666.dyndns.org/disk1/Trabajo /media/trabajo
#sudo curlftpfs -o allow_other ftp://remoto:30363864@ls-wxl9c9.local/disk1/Trabajo /media/trabajo
# local x ssh#   sshfs -o allow_other root@192.168.1.6:/mnt/disk1/Trabajo /media/trabajo

#sshfs -o allow_other root@fayu666.dyndns.org:/mnt/disk1/Trabajo /media/trabajo

sshfs -o allow_other admin@wemeserver.no-ip.info:/mnt/disk1/Trabajo /media/trabajo

# monta como root local. funciona.
#sshfs -o allow_other root@192.168.1.6:/mnt/disk1/Trabajo /media/trabajo

# obtener el nombre de la conexion wireless
# nm-tool |grep --only-matching '*[^ ][^:]*' |sed 's/^*//'
