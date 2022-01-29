#!/bin/bash
#### REQUISITOS
# sudo apt-get install zenity ghostscript
set -x
guitool=zenity

pulmon=rtsp://weme:200161walter@192.168.100.7:554/h264/ch1/sub/av_stream
harinera=rtsp://weme:200161walter@192.168.100.7:554/h264/ch2/main/av_stream
fermentacion=rtsp://weme:200161walter@192.168.100.7:554/h264/ch3/main/av_stream
envasado=rtsp://weme:200161walter@192.168.100.7:554/h264/ch4/main/av_stream
amasado_fondo=rtsp://weme:200161walter@192.168.100.7:554/h264/ch5/main/av_stream
amasado_frente=rtsp://weme:200161walter@192.168.100.7:554/h264/ch6/main/av_stream
reefer=rtsp://weme:200161walter@192.168.100.7:554/h264/ch7/main/av_stream
pasillo_fermentadora=rtsp://weme:200161walter@192.168.100.7:554/h264/ch8/main/av_stream
carga=rtsp://weme:200161walter@192.168.100.7:554/h264/ch9/main/av_stream
puerta=rtsp://weme:200161walter@192.168.100.7:554/h264/ch10/main/av_stream
no_anda=rtsp://weme:200161walter@192.168.100.7:554/h264/ch11/main/av_stream
hornos=rtsp://weme:200161walter@192.168.100.7:554/h264/ch12/main/av_stream
garage=rtsp://weme:200161walter@192.168.100.7:554/h264/ch13/main/av_stream
vestuario=rtsp://weme:200161walter@192.168.100.7:554/h264/ch14/main/av_stream
entrada_envasado=rtsp://weme:200161walter@192.168.100.7:554/h264/ch15/main/av_stream
pasillo_entrada=rtsp://weme:200161walter@192.168.100.7:554/h264/ch16/main/av_stream

#~ mpv --end=$duracion --loop --mute --title="Camaras" --ontop --no-border --autofit=$tamano --geometry=$posicion $ch1 $ch2 $ch3 $ch4 $ch5 $ch6 $ch7 $ch8 $ch9 $ch10 $ch11 $ch12 $ch13 $ch14 $ch15 $ch16
play() {
	mpv --mute --title='Camara' --ontop --geometry=$posicion $camara
}


# Dialog box to choose thumb's size
while [[ "$CALIDAD" != "cancel" ]]; do

	CALIDAD="$( $guitool --list --height=450 --title="Seleccionar la Cámara" --text="Selecciona la cámara que quieres ver" --radiolist --column=$"Marcar" --column=$"Zona" "" "Pulmon" "" "Puerta" "" "Pasillo entrada" "" "Vestuario" "" "Harinera" "" "Porton carga" "" "Amasado frente" "" "Amasado fondo" "" "Pasillo fermentadora" "" "Hornos" "" "Fermentacion" "" "Entrada envasado" "" "Carga" "" "Envasado" "" "Garage" "" "Reefer" || echo cancel )"
	[[ "$CALIDAD" = "cancel" ]] && exit

	if [[ "$CALIDAD" = "" ]]; then
	$guitool --error --text="Cámara no especificada. Selecciona la cámara deseada. "
	exit 1
	fi

	if [[ "$CALIDAD" = "Pulmon" ]] ; then
	camara=$pulmon
	play
	fi
	if [[ "$CALIDAD" = "Puerta" ]] ; then
	camara=$puerta
	play 
	fi
	if [[ "$CALIDAD" = "Pasillo entrada" ]] ; then 
	camara=$pasillo_entrada
	play 
	fi
	if [[ "$CALIDAD" = "Vestuario" ]] ; then 
	camara=$vestuario
	play 
	fi
	if [[ "$CALIDAD" = "Harinera" ]] ; then 
	camara=$harinera
	play 
	fi
	if [[ "$CALIDAD" = "Porton carga" ]] ; then 
	camara=$porton_carga
	play 
	fi
	if [[ "$CALIDAD" = "Amasado frente" ]] ; then 
	camara=$amasado_frente
	play 
	fi
	if [[ "$CALIDAD" = "Amasado fondo" ]] ; then 
	camara=$amasado_fondo
	play 
	fi
	if [[ "$CALIDAD" = "Pasillo fermentadora" ]] ; then 
	camara=$pasillo_fermentadora
	play 
	fi
	if [[ "$CALIDAD" = "Hornos" ]] ; then 
	camara=$hornos
	play 
	fi
	if [[ "$CALIDAD" = "Fermentacion" ]] ; then 
	camara=$fermentacion
	play $
	fi
	if [[ "$CALIDAD" = "Entrada envasado" ]] ; then 
	camara=$entrada_envasado
	play 
	fi
	if [[ "$CALIDAD" = "Carga" ]] ; then 
	camara=$carga
	play 
	fi
	if [[ "$CALIDAD" = "Garage" ]] ; then 
	camara=$garage
	play 
	fi
	if [[ "$CALIDAD" = "Envasado" ]] ; then 
	camara=$envasado
	play 
	fi
	if [[ "$CALIDAD" = "Reefer" ]] ; then 
	camara=$reefer
	play 
	fi
done
