#! /bin/sh
# DIRECTORIO
set -ex
#~ exec >> /home/ezequiel/PDF/renombrado2.log 2>&1
cd /home/$USER/PDF/
#~ sleep 3
FECHA=$(date +'%Y%m%d%H%M%S')
echo $PWD
#~ BASE=`for FILE in FA*.pdf ; do NEWFILE=`echo $FILE | sed 's/.pdf$//'` ; mv $FILE $NEWFILE ; done`
#for FILE in FA* ; do NEWFILE2=`echo ${FILE:0:22}` ; mv $FILE $NEWFILE2 ; done

for FILE in H__TRABAJO_WEME_*.pdf ; do rename 's/(^H__TRABAJO_WEME_)//' H__TRABAJO_WEME_*.pdf ; done 2>/dev/null
for FILE in FA*.pdf ; do rename 's/(.{22})(.*).pdf/$1.pdf/' FA*.pdf ; done 2>/dev/null
# for FILE in FE*.pdf ; do rename 's/(.{22})(.*).pdf/$1.pdf/' FE*.pdf ; done 2>/dev/null
for FILE in H__TRABAJO_WEME_FA*-O.frx_ted_files.pdf ; do rename 's/(.{22})(.*).pdf/$1.pdf/' H__TRABAJO_WEME_FA*-O.frx_ted_files.pdf ; done 2>/dev/null
for FILE in CA*.pdf ; do rename 's/(.{22})(.*).pdf/$1.pdf/' CA*.pdf ; done 2>/dev/null
for FILE in H__TRABAJO_WEME_CA*.pdf ; do rename 's/(.{22})(.*).pdf/$1.pdf/' H__TRABAJO_WEME_CA*.pdf ; done 2>/dev/null
for FILE in H__TRABAJO_WEME*.pdf ; do rename 's/(.{22})(.*).pdf/$1.pdf/' H__TRABAJO_WEME_CA*.pdf ; done 2>/dev/null


for FILE in *_Linux-generated_files*.pdf ; do rename 's/(_Linux-generated_files)//' *_Linux-generated_files*.pdf ; done 2>/dev/null
for FILE in *..frx_ated_files*.pdf ; do rename 's/(.frx_ated_files.)//' *..frx_ated_files*.pdf ; done 2>/dev/null
for FILE in *.frx_ted_files*.pdf ; do rename 's/(.frx_ted_files-job_[0-9][0-9][0-9][0-9])//' *.frx_ted_files*.pdf ; done 2>/dev/null
for FILE in *.frx_ted_files*.pdf ; do rename 's/(.frx_ted_files-job_[0-9][0-9][0-9])//' *.frx_ted_files*.pdf ; done 2>/dev/null
for FILE in *.frx_ted_files*.pdf ; do rename 's/(.frx_ted_files-job_[0-9][0-9])//' *.frx_ted_files*.pdf ; done 2>/dev/null
for FILE in *.frx_ted_files*.pdf ; do rename 's/(.frx_ted_files-job_[0-9])//' *.frx_ted_files*.pdf ; done 2>/dev/null
for FILE in *.frx_files*.pdf ; do rename 's/(.frx_files)//' *.frx_files*.pdf ; done 2>/dev/null
for FILE in *.frx_ers__e.g*.pdf ; do rename 's/(.frx_ers__e.g)//' *.frx_ers__e.g*.pdf ; done 2>/dev/null
for FILE in *.frx___e.g.pdf ; do rename 's/(.frx_ers__e.g)//' *.frx___e.g.pdf ; done 2>/dev/null
for FILE in *.frx_es*.pdf ; do rename 's/(.frx_es)//' *.frx_es*.pdf ; done 2>/dev/null
for FILE in *H__Trabajo_WEME_clientes_weme_fuentes_reportes_v_*.pdf ; do rename 's/(H__Trabajo_WEME_clientes_weme_fuentes_reportes_v_)//' *H__Trabajo_WEME_clientes_weme_fuentes_reportes_v_*.pdf ; done 2>/dev/null
for FILE in *Z__Trabajo_WEME_clientes_weme_fuentes_reportes_v_*.pdf ; do rename 's/(H__Trabajo_WEME_clientes_weme_fuentes_reportes_v_)//' *H__Trabajo_WEME_clientes_weme_fuentes_reportes_v_*.pdf ; done 2>/dev/null



#### RENOMBRADO SEGUN NOMBRE ARCHIVO
find /home/$USER/PDF/ -iname *E_LISPREALFA.frx*.pdf -exec bash -c 'mv {} 'Lista_De_Precios-${FECHA}' ' \;
find /home/$USER/PDF/ -iname *e_lispedclie1.frx*.pdf -exec bash -c 'mv {} 'Listado_De_Pedidos-${FECHA}' ' \;
find /home/$USER/PDF/ -iname *LISTADEUDETA.frx*.pdf -exec bash -c 'mv {} 'Listado_De_Deuda-${FECHA}' ' \;
find /home/$USER/PDF/ -iname *LISTAEST6.frx*.pdf -exec bash -c 'mv {} 'Produccion_General-${FECHA}'' \;
find /home/$USER/PDF/ -iname *LISTAEST1.frx*.pdf -exec bash -c 'mv {} 'Venta_por_Cuenta_Madre-${FECHA}'' \;
find /home/$USER/PDF/ -iname *LISTAACREDETA.frx*.pdf -exec bash -c 'mv {} 'Acreedores_Detallado-${FECHA}'' \;
find /home/$USER/PDF/ -iname *LISTARETENC.frx*.pdf -exec bash -c 'mv {} 'Retenciones-${FECHA}'' \;
find /home/$USER/PDF/ -iname *LISTAPERCEP.frx*.pdf -exec bash -c 'mv {} 'Percepciones-${FECHA}'' \;
find /home/$USER/PDF/ -iname *LIBROIVAVENTAS2.frx.frx*.pdf -exec bash -c 'mv {} 'Iva_Ventas-${FECHA}'' \;

#for FILE in FA* ; do mv $FILE $FILE.pdf ; done

# MAYUSCULAS A MINUSCULAS
#~ for FILE in * ; do mv $FILE `echo $FILE | tr '[A-Z]' '[a-z]'` ; done

# QUITAR ESPACIOS EN BLANCO Y REEMPLAZAR POR _
# for FILE in *.mp3 ; do NEWFILE=`echo $FILE | sed 's/ /_/g'` ; mv "$FILE" $NEWFILE ; done

# Añadir un sufijo (.TXT POR EJEMPLO)
# for FILE in * ; do mv $FILE $FILE.txt ; done

# AÑADIR UN PREFIJO (MATHS_ POR EJEMPLO)
# for FILE in * ; do mv $FILE maths_$FILE ; done

# Eliminar un prefijo (MATHS_ POR EJEMPLO)
# for FILE in * ; do NEWFILE=`echo $FILE | sed 's/^maths_//'` ; mv $FILE $NEWFILE ; done

# eliminar un sufijo (.TXT POR EJEMPLO)
# for FILE in *.txt ; do NEWFILE=`echo $FILE | sed 's/.txt$//'` ; mv $FILE $NEWFILE ; done

# De mayúsculas a minúsculas (sólo sufijo)
# for FILE in *.TXT ; do NEWFILE=`echo $FILE | sed 's/.TXT$/.txt/'` ; mv $FILE $NEWFILE ; done

# apéndice
# NUM=0 ; for FILE in * ; do NUM=`expr $NUM + 1` ; mv $FILE foolish\($NUM\) ; done
# NUM=0 ; for FILE in * ; do NUM=`expr $NUM + 1` ; mv $FILE ${FILE}_$NUM ; done
