#! /bin/sh
# DIRECTORIO
# cd /home/ezequiel/PDF/

# MAYUSCULAS A MINUSCULAS
for FILE in * ; do mv $FILE `echo $FILE | tr '[A-Z]' '[a-z]'` ; done

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
