#! /bin/bash
# instala el servidor
# sudo apt-get install openssh-server

# crea la clave rsa para ingresar sin password
ssh-keygen -t rsa -b 4096 -o -a 100

# opcional se mete al directorio de ssh y envia por mail el public rsa
[[ ! -z `find ~/.ssh -maxdepth 1 -name 'id_rsa.pub'` ]] && echo "Adjunto la clave publica del servidor $(uname -a) Saludos." | mutt -s "Id_Rsa.Pub" -a ~/.ssh/id_rsa.pub -- ezequielfaiella@gmail.com

# opcion mas posible viable es usar el comando de copia de la id
#ssh-copy-id hostalqueseloquieroenviar

# si quiero editar las opciones como por ejemplo el puerto, habilitar el envio de X11, etc
#sudo mousepad /etc/ssh/sshd_config

# como agregar la clave a la lista de autorizaciones. es un ejemplo para actualizarlo remoto. ajustarlo para hacerlo con el archivo local es posible tambien.
# cat ~/.ssh/id_rsa.pub | ssh hostname "cat >> ~/.ssh/authorized_keys"

