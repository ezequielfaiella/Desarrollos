#!/bin/bash
RES=s
while [ $RES = s ]
do
	#echo "Introducir nombre de usuario:"
	#read USU
	ps aux|grep $USER
	echo "¿Desea continuar?"
	read RES
done
