#!bin/bash
#echo "INGRESE EL SCRIPT O PROGRAMA A BUSCAR Y PULSE ENTER"
PROGRAMA=$1
ps waux | grep -v grep | grep -v $0 | grep $PROGRAMA
