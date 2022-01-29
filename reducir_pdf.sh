#!/bin/bash
#### REQUISITOS
# sudo apt-get install zenity ghostscript

guitool=zenity

exit_me(){
rm -rf ${tempdir}
exit 1
}

trap "exit_me 0" 0 1 2 5 15


LOCKFILE="/tmp/.${USER}-$(basename $0).lock"
[[ -r $LOCKFILE ]] && PROCESS=$(cat $LOCKFILE) || PROCESS=" "

if (ps -p $PROCESS) >/dev/null 2>&1
then
echo "E: $(basename $0) is already running"
$guitool --error --text="$(basename $0) is already running"
exit 1
else
rm -f $LOCKFILE
echo $$ > $LOCKFILE
fi

# Dialog box to choose thumb's size
CALIDAD="$( $guitool --list --height=340 --title="Seleccionar la calidad del PDF" --text="Selecciona la calidad que quieres que tenga el PDF" --radiolist --column=$"Marcar" --column=$"Calidad" "" "Calidad 72 dpi" "" "Estándard" "" "Calidad Media 150 dpi" "" "Calidad Alta 300 dpi" "" "Calidad Alta 300 dpi preservando color" || echo cancel )"
[[ "$CALIDAD" = "cancel" ]] && exit

if [[ "$CALIDAD" = "" ]]; then
$guitool --error --text="Calidad no especificada. Selecciona la calidad deseada. "
exit 1
fi

# precache
PROGRESS=0
NUMBER_OF_FILES="$#"
let "INCREMENT=100/$NUMBER_OF_FILES"

( for i in "$@"
do
echo "$PROGRESS"
#~ file="$i"
file="$1"

# precache
dd if="$file" of=/dev/null 2>/dev/null

# increment progress
let "PROGRESS+=$INCREMENT"
done
) | $guitool --progress --title "Precaching..." --percentage=0 --auto-close --auto-kill
# Creating thumbnails. Specific work on picture should be add there as convert's option

# How many files to make the progress bar
PROGRESS=0
NUMBER_OF_FILES="$#"
let "INCREMENT=100/$NUMBER_OF_FILES"

mkdir -p "PDF's Reducidos"

( for i in "$@"
do
echo "$PROGRESS"
file="$i"
filename="${file##*/}"
filenameraw="${filename%.*}"
echo -e "# Transformando: \t ${filename}"

if [[ "$CALIDAD" = "Estándard" ]] ; then
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dDetectDuplicateImages=true -dPDFSETTINGS=/default -dNOPAUSE -dQUIET -dBATCH -sOutputFile="PDF's Reducidos/${filename%\.*}.pdf" "${file}"
fi
if [[ "$CALIDAD" = "Calidad 72 dpi" ]] ; then
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dDetectDuplicateImages=true -dPDFSETTINGS=/screen -dNOPAUSE -dQUIET -dBATCH -sOutputFile="PDF's Reducidos/${filename%\.*}.pdf" "${file}"
fi
if [[ "$CALIDAD" = "Calidad Media 150 dpi" ]] ; then 
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dDetectDuplicateImages=true -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile="PDF's Reducidos/${filename%\.*}.pdf" "${file}"
fi
if [[ "$CALIDAD" = "Calidad Alta 300 dpi" ]] ; then 
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dDetectDuplicateImages=true -dPDFSETTINGS=/printer -dNOPAUSE -dQUIET -dBATCH -sOutputFile="PDF's Reducidos/${filename%\.*}.pdf" "${file}"
fi
if [[ "$CALIDAD" = "Calidad Alta 300 dpi preservando color" ]] ; then 
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dDetectDuplicateImages=true -dPDFSETTINGS=/prepress -dNOPAUSE -dQUIET -dBATCH -sOutputFile="PDF's Reducidos/${filename%\.*}.pdf" "${file}"
fi

let "PROGRESS+=$INCREMENT"
done
) | $guitool --progress --width=450 --title "Transformando PDF..." --percentage=0 --auto-close --auto-kill

$guitool --info --text="Finalizado, Puedes encontrar los PDF's en el directorio 'PDF's Reducidos'"
