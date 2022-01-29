#!bin/bash
PROGRAMA=$1
ps waux | grep $PROGRAMA | grep -v grep | grep -v $0 | awk '{print $2}' | xargs kill -15 # cambie 9 por 15, supuestamente con 15 mata los hijos primero
