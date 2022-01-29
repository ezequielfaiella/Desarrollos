#!/bin/sh
#
# script bash pour télécharger et installer Systemback sur Ubuntu 17.10 - 18.04
# BDMaster et Babdu89 12/12/2017
#
# Le shell s'attend à être dans / home / user (user = user_name)
# Télécharger l'outil Systemback 'Systemback_Install_Pack_v1.8.402.tar.xz'
# dans le dossier / home, puis décompressez le fichier tar pour obtenir le
# dossier /home/Systemback_Install_Pack_v1.8.402 qui contient les fichiers
# pour l'installation.
# Après cela, il va copier le nouveau shell dans le dossier
# installation /home/Systemback_Install_Pack_v1.8.402/install.sh
# et lui transmettra le chèque pour effectuer l'installation proprement dite.
# Start

# sudo wget -P /home https://sourceforge.net/projects/systemback/files/1.8/Systemback_Install_Pack_v1.8.402.tar.xz

# sudo tar xpvf /home/Systemback_Install_Pack_v1.8.402.tar.xz -C /home/

# sudo chmod 755 /home/Systemback_Install_Pack_v1.8.402/install.sh

# sudo sed -i '9 i # Ubuntu 17.10 Artful Aardvark,' /home/Systemback_Install_Pack_v1.8.402/install.sh
# sudo sed -i '10 i # Ubuntu 18.04 Bionic Beaver,' /home/Systemback_Install_Pack_v1.8.402/install.sh
# sudo sed -i '16 i # Last modification: 2017.12.12. by Biagio De Maio <email address hidden>' /home/Systemback_Install_Pack_v1.8.402/install.sh
# sudo sed -i '17 i # and friend of mine Babdu89 <email>' /home/Systemback_Install_Pack_v1.8.402/install.sh
# sudo sed -i '46 i \ artful)' /home/Systemback_Install_Pack_v1.8.402/install.sh
# sudo sed -i '47 i \ release=Ubuntu_Xenial' /home/Systemback_Install_Pack_v1.8.402/install.sh
# sudo sed -i '48 i \ ;;' /home/Systemback_Install_Pack_v1.8.402/install.sh
# sudo sed -i '49 i \ bionic)' /home/Systemback_Install_Pack_v1.8.402/install.sh
# sudo sed -i '50 i \ release=Ubuntu_Xenial' /home/Systemback_Install_Pack_v1.8.402/install.sh
# sudo sed -i '51 i \ ;;' /home/Systemback_Install_Pack_v1.8.402/install.sh
# sudo sed -i '75 i \ 5 ─ Ubuntu 17.10 (Artful Aardvark)' /home/Systemback_Install_Pack_v1.8.402/install.sh
# sudo sed -i '76 i \ 6 ─ Ubuntu 18.04 (Bionic Beaver)' /home/Systemback_Install_Pack_v1.8.402/install.sh
# sudo sed -i '77d' /home/Systemback_Install_Pack_v1.8.402/install.sh
# sudo sed -i '77 i \ 7 ─ Debian 8.0 (Jessie)' /home/Systemback_Install_Pack_v1.8.402/install.sh
# sudo sed -i '104 i \ 5)' /home/Systemback_Install_Pack_v1.8.402/install.sh
# sudo sed -i '105 i \ release=Ubuntu_Xenial' /home/Systemback_Install_Pack_v1.8.402/install.sh
# sudo sed -i '106 i \ ;;' /home/Systemback_Install_Pack_v1.8.402/install.sh
# sudo sed -i '107 i \ 6)' /home/Systemback_Install_Pack_v1.8.402/install.sh
# sudo sed -i '108 i \ release=Ubuntu_Xenial' /home/Systemback_Install_Pack_v1.8.402/install.sh
# sudo sed -i '109 i \ ;;' /home/Systemback_Install_Pack_v1.8.402/install.sh
# sudo sed -i '110d' /home/Systemback_Install_Pack_v1.8.402/install.sh
# sudo sed -i '110 i \ 7)' /home/Systemback_Install_Pack_v1.8.402/install.sh

# /home/Systemback_Install_Pack_v1.8.402/install.sh

# End
cd /tmp
git clone https://github.com/fconidi/systemback-install_pack-1.9.4.git
cd systemback-install_pack-1.9.4/
chmod +x install.sh
sudo ./install.sh