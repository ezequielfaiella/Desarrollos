#! /bin/bash
set -x

if [ $(wc -c <"/home/$USER/sent") -ge 1000000 ]; then
	cat /dev/null > /home/$USER/sent
fi

# echo "Te adjunto los archivos" | mutt -s "Asunto" -a ~/Docs/file1.odt ~/Docs/file2.odt -- destinatario@servidor.com
# [[ ! -z `find '/home/$USER/PDF/' -maxdepth 1 -name 'Groupon*.pdf'` ]] && echo "Tenemos el agrado de hacerles llegar la proxima comida. Saludamos atte." | mutt -s "Le Morfi" -a /home/$USER/PDF/Groupon*.pdf -- $USERfaiella@gmail.com ; rm /home/$USER/PDF/Groupon*.pdf || echo "not found"

# Latin Chemical - Martin Fonticelli
#[ ! -z `find /home/$USER/PDF/ -maxdepth 1 -name 'FA0003????????-019*.pdf'` ] && echo "Tenemos el agrado de hacerles llegar la factura por el pedido realizado. Saludamos atte." | mutt -s "Factura Electrónica" -a /home/$USER/PDF/FA0003????????-019*.pdf -- mfonticelli@latinchemical.com.ar ; rm /home/$USER/PDF/FA0003????????-019*.pdf

# Groupon - Romina - Ezequiel
[ ! -z `find /home/$USER/PDF/ -maxdepth 1 -name 'Groupon*.pdf'` ] && echo "Tenemos el agrado de hacerles llegar la proxima comida. Saludamos atte." | mail -s "Le Morfi" -a /home/$USER/PDF/Groupon*.pdf -- ezequielfaiella@gmail.com ; rm /home/$USER/PDF/Groupon*.pdf

# Plastiferro - Juan Pablo Pesculich
[ ! -z `find /home/$USER/PDF/ -maxdepth 1 -name 'FA0003????????-018*.pdf'` ] && echo "Tenemos el agrado de hacerles llegar la factura por el pedido realizado. Saludamos atte." | mail -s "Factura Electrónica" -a /home/$USER/PDF/FA0003????????-018*.pdf -- juanpablo@plastiferro.com ; rm /home/$USER/PDF/FA0003????????-018*.pdf

# Distribuidora Carroso
[ ! -z `find /home/$USER/PDF/ -maxdepth 1 -name 'Carroso*.pdf'` ] && echo "Tenemos el agrado de hacerles llegar el resumen de su cuenta corriente. Saludamos atte." | mail -s "Estado de Cuenta" -a /home/$USER/PDF/Carroso*.pdf -- distribuidoracarrosso@hotmail.com ; rm /home/$USER/PDF/Carroso*.pdf

# Wayback
#[ ! -z `find /home/$USER/PDF/ -maxdepth 1 -name 'FA0003????????-016*.pdf'` ] && echo "Tenemos el agrado de hacerles llegar la factura por el pedido realizado. Saludamos atte." | mutt -s "Factura Electrónica" -a /home/$USER/PDF/FA0003????????-016*.pdf -- compras@wayback.com.ar, m.trivi@wayback.com.ar ; rm /home/$USER/PDF/FA0003????????-016*.pdf

# Pedido Tortassh mail
[ ! -z `find /home/$USER/PDF/ -maxdepth 1 -name 'Robles.pdf'` ] && echo "Adjunto el pedido de tortas, por favor confirmar recepcion. Saludos." | mail -s "Pedido" -a /home/$USER/PDF/Robles*.pdf -- tortasrobles@yahoo.com.ar ; rm /home/$USER/PDF/Robles*.pdf

# Cuenta Carlos
[ ! -z `find /home/$USER/PDF/ -maxdepth 1 -name 'cuenta_carlos*.pdf'` ] && echo "Tenemos el agrado de hacerles llegar el resumen de su cuenta corriente. Saludamos atte." | mail -s "Estado de Cuenta" -a /home/$USER/PDF/cuenta_carlos*.pdf -- carlsgastronomia@gmail.com ; rm /home/$USER/PDF/cuenta_carlos*.pdf

# Ordenes de Pago
#~ for T in /home/$USER/PDF/*"OP "* ; do mv "$T" /media/trabajo/Trabajo/Administracion/ORDENES\ DE\ PAGO/SISTEMA/"$T" ; done

# MANDA A IMPRIMIR FACTURAS A PDF
sleep 2
sh /media/trabajo/Trabajo/scripts/print.sh

# Reimpresion de Facturas
#[ ! -z `find /home/$USER/PDF/ -maxdepth 1 -name 'factura*.pdf'` ] && lpr -P HP-LaserJet-M1005-MFP -l factura*.pdf; rm factura*.pdf ; notify-send "Se Envio 1 Factura a $FACTURA" || notify-send "Sin Facturas Pendientes"

# Reimpresion de Remitos
#[[ ! -z `find /home/$USER/PDF/ -maxdepth 1 -name 'remito*.pdf'` ]] && lpr -P $REMITO -l remito*.pdf; rm remito*.pdf  || notify-send "Sin Remitos Pendientes"
