#! /bin/bash
# set -x -v
# sudo umount /media/audio
# sudo fusermount -u /media/trabajo

# esto busca el proceso x, lo filtra y obtiene su pid, luego lo mata
ps waux | grep /home/$USER/servicios.sh | grep -v grep | awk '{print $2}' | xargs kill 2> /dev/null
sudo umount /media/trabajo
