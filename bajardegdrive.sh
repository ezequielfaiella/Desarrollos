#!/bin/bash
#~ fileid="### file id ###"
#~ filename="MyFile.csv"
#~ curl -c ./cookie -s -L "https://drive.google.com/uc?export=download&id=${fileid}" > /dev/null
#~ curl -Lb ./cookie "https://drive.google.com/uc?export=download&confirm=`awk '/download/ {print $NF}' ./cookie`&id=${fileid}" -o ${filename}

fileid="R5eXatTFnhw3ObBJb5RTYn_PhXxUPYn"
filename="ra1nusb-amd.dmg"
curl -c ./cookie -s -L "https://drive.google.com/uc?export=download&id=${fileid}" > /dev/null
curl -Lb ./cookie "https://drive.google.com/uc?export=download&confirm=`awk '/download/ {print $NF}' ./cookie`&id=${fileid}" -o ${filename}




#~ 1GSowqw_yqzdV2dEuW2BLQa3TkIGtCRTx;Venom.2018.1080p.part1.rar
#~ 1NQf9GeSIxHL2fYoDYQVPICoJmsygKLLr;Venom.2018.1080p.part2.rar
#~ 189CjB5I1yS_wqp4v2T66mMrSeoayuUKw;Venom.2018.1080p.part3.rar
#~ 1P7ogyityczTV4-j_q1oA2tRUauf04V0w;Venom.2018.1080p.part4.rar
#~ 1XZxn7hrQjG-FfloWi0dBG3bkIHfRjdxI;Venom.2018.1080p.part5.rar
#~ 1e4HI0q8wDrK-vtnNHi6khkI0Jy57djVB;Venom.2018.1080p.part6.rar
#~ 1HR8168MBSntoQTjEcZoJEegGBF00KF0O;Venom.2018.1080p.part7.rar
#~ 13SGz0X-MOfen4QlHZ-IaoKY51ZOQnnn5;Venom.2018.1080p.part8.rar
#~ https://drive.google.com/file/d/1-R5eXatTFnhw3ObBJb5RTYn_PhXxUPYn
