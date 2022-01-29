#! /bin/bash
#~ set -ex
IMPUESTOS=/media/trabajo/Trabajo/Administracion/Impuestos
# SACA LAS OP DE LA CARPETA PDF Y LOS PONE EN TRABAJO
cd /home/$USER/PDF
for T in *"OP "* ; do mv "$T" /media/trabajo/Trabajo/Administracion/ORDENES\ DE\ PAGO/SISTEMA/"$T" ; done
# TRAE TODOS LOS ARCHIVOS PDF DE LA CARPETA COMPRATIDA A LA MAQUINA VIRTUAL
cd /home/ezequiel/Público/
for T in *.pdf ; do mv "$T" $IMPUESTOS/"$T" ; done
for T in *.PDF ; do mv "$T" $IMPUESTOS/"$T" ; done
cd $IMPUESTOS
# PASA TODO A MAYUSCULAS
for FILE in * ; do mv "$FILE" "`echo "$FILE" | tr '[a-z]' '[A-Z]'`" ; done
# SIEMPRE PRIMERO PORQUE SACA LOS GASTOS PARTICULARES DIFICIL DE INDIVIDUALIZAR
for T in *RETA* ; do mv "$T" PARTICULAR/"$T" ; done
for T in *SASTRE* ; do mv "$T" PARTICULAR/"$T" ; done
for T in *CRISANTEMOS* ; do mv "$T" PARTICULAR/"$T" ; done
# TODO EL RESTO DE COMPROBANTES
for T in *MOVISTAR* ; do mv "$T" MOVISTAR/"$T" ; done
for T in *TELEFONICA* ; do mv "$T" TELEFONICA/"$T" ; done
for T in *METROGAS* ; do mv "$T" METROGAS/"$T" ; done
for T in *AYSA* ; do mv "$T" AYSA/"$T" ; done
for T in *EDESUR* ; do mv "$T" EDESUR/"$T" ; done
for T in *EDEA* ; do mv "$T" COSTA/"$T" ; done
for T in *DOLORES* ; do mv "$T" COSTA/"$T" ; done
for T in *CABLEVISION* ; do mv "$T" PARTICULAR/"$T" ; done
for T in *ECHEVERRIA* ; do mv "$T" PARTICULAR/"$T" ; done
for T in *TSG* ; do mv "$T" MUNICIPALIDAD/TSG/"$T" ; done
for T in *HIG* ; do mv "$T" MUNICIPALIDAD/Seguridad\ e\ Higiene/"$T" ; done
for T in *MOTORES* ; do mv "$T" MUNICIPALIDAD/Motores/"$T" ; done
for T in *171003-0* ; do mv "$T" ARBA/"$T" ; done
for T in *171006-1* ; do mv "$T" ARBA/"$T" ; done
for T in *171007-8* ; do mv "$T" ARBA/"$T" ; done
for T in *171008-5* ; do mv "$T" ARBA/"$T" ; done
for T in *ARBA* ; do mv "$T" ARBA/"$T" ; done
for T in *NEXTEL* ; do mv "$T" NEXTEL/"$T" ; done
for T in *"BELGRANO 924"* ; do mv "$T" ALQUILER/"$T" ; done
for T in *SUELDOS* ; do mv "$T" /media/trabajo/Trabajo/Administracion/Sueldos/"$T" ; done
for T in *ADELANTO* ; do mv "$T" /media/trabajo/Trabajo/Administracion/Sueldos/"$T" ; done
for T in *VACACIONES* ; do mv "$T" /media/trabajo/Trabajo/Administracion/Sueldos/"$T" ; done
for T in *"OP "* ; do mv "$T" /media/trabajo/Trabajo/Administracion/ORDENES\ DE\ PAGO/SISTEMA/"$T" ; done
for T in *"1-OP "* ; do mv "$T" /media/trabajo/Trabajo/Administracion/ORDENES\ DE\ PAGO/SISTEMA/"$T" ; done
for T in *LVG982* ; do mv "$T" PATENTES/"$T" ; done
for T in *AA715EX* ; do mv "$T" PATENTES/"$T" ; done
for T in *PBZ256* ; do mv "$T" PATENTES/"$T" ; done
for T in *MOR715* ; do mv "$T" PATENTES/"$T" ; done
for T in *KXZ843* ; do mv "$T" PATENTES/"$T" ; done
for T in CM* ; do mv "$T" /media/trabajo/Trabajo/Administracion/Impuestos/AFIP/IIBB/"$T" ; done
