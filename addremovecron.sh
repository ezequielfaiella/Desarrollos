#! /bin/bash
croncmd="export DISPLAY=:0 && /usr/local/bin/weme"
cronjob="*/1 * * * * $croncmd"
case $1 in
add)
	( crontab -l | grep -v -F "$croncmd" ; echo "$cronjob" ) | crontab -
	;;
remove)
	( crontab -l | grep -v -F "$croncmd" ) | crontab -
	;;
esac
