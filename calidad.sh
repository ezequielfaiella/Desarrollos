#!/bin/bash
export DISPLAY=:0.0
case $USER in
			ezequiel)
					IMPRESORA=$(lpstat -a | grep -v grep | grep HP-ZEROTIER | awk '{print $1}')
			;;
			administracion)
					IMPRESORA=$(lpstat -a | grep -v grep | grep Hewlett-Packard-HP-LaserJet-M1005 | awk '{print $1}')
			;;
esac

lpr -o fit-to-page -#1 -P $IMPRESORA "/media/trabajo/Trabajo/Administracion/Calidad/Planillas De Uso Diario/RE-CAL-21-02_Control_del_detector_de_metaleS_docx-20170621_071929.pdf"
lpr -o fit-to-page -#2 -P $IMPRESORA "/media/trabajo/Trabajo/Administracion/Calidad/Planillas De Uso Diario/RE-PRO-01-06 Registro de Elaboracion.pdf"
lpr -o fit-to-page -#3 -P $IMPRESORA "/media/trabajo/Trabajo/Administracion/Calidad/Planillas De Uso Diario/RE-CAL-06-01_Registro_de_Limpieza_diario-20181112_072831.pdf"
lpr -o fit-to-page -#1 -P $IMPRESORA "/media/trabajo/Trabajo/Administracion/Calidad/Planillas De Uso Diario/RE-CAL-11-01 Registro de Bloqueo y Liberacion de PT.pdf"
lpr -o fit-to-page -#1 -P $IMPRESORA "/media/trabajo/Trabajo/Administracion/Calidad/Planillas De Uso Diario/RE-PRO-19-01 Control de Temperatura de Camaras.pdf"
lpr -o fit-to-page -#3 -P $IMPRESORA "/media/trabajo/Trabajo/Administracion/Calidad/Planillas De Uso Diario/RE-PRO-11-01 Control de Stock Mercaderia en Camara.pdf"
lpr -o fit-to-page -#2 -P $IMPRESORA "/media/trabajo/Trabajo/Administracion/Calidad/Planillas De Uso Diario/RE-PRO-01-05 Registro de Dosificacion  de ingredientes.pdf"

gdialog --title "Impresion" --yesno "INGRESE LAS 6 HOJAS DE OSCAR PARA IMPRIMIR LA 2° PARTE"
	if [ $? = 0 ]; then
		lpr -o fit-to-page -#3 -P $IMPRESORA "/media/trabajo/Trabajo/Administracion/Calidad/Planillas De Uso Diario/RE-CAL-06-01_Registro_de_Limpieza_diario-20181112_072831.pdf"
	fi
