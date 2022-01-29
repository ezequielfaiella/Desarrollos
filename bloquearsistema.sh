#!/bin/bash
ESCRITORIO=$(grep XDG_DESKTOP_DIR ~/.config/user-dirs.dirs | cut -f2 -d \" | cut -f2 -d /)
pkill weme
if [ "$(ls -A /home/administracion/.WEME)" ]; then 
mv /home/administracion/.WEME /home/administracion/.WEME_
else 
mv /home/administracion/.WEME_ /home/administracion/.WEME
fi
