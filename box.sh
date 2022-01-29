#! /bin/bash
sudo apt-get install davfs2
sudo dpkg-reconfigure davfs2
sudo adduser $USER davfs2
mkdir ~/.davfs2
mkdir ~/Box
cp /etc/davfs2/davfs2.conf ~/.davfs2
# ver q el archivo davfs2.con tenga use_locks 0
sudo cp /etc/davfs2/secrets ~/.davfs2
sudo chown $USER ~/.davfs2/secrets
#~ echo "https://dav.box.com/dav   fayu666@hotmail.com   30363864" >> ~/.davfs2/secrets
echo "https://dav.box.com/dav   administracion@panificadoradelsur.com.ar   gratis" >> ~/.davfs2/secrets
mount -t davfs https://dav.box.com/dav ~/Box
# gregar al fstab
# https://dav.box.com/dav /home/user/box.net davfs rw,user,noauto 0 0
