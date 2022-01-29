#! /bin/bash
sudo apt-get install -y sendxmpp
touch /home/$USER/.sendxmpprc
echo 'grupoweme@gmail.com;talk.google.com panificadoradelsur gmail.com' >> /home/$USER/.sendxmpprc
#	miusuario@gmail.com;talk.google.com mipassword
chmod 600 /home/$USER/.sendxmpprc

#	USO
#		echo "Hola, probando" | sendxmpp -t -u miusuario -o gmail.com destinatario@gmail.com	
#
