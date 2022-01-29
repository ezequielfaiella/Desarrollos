# !/bin/bash
# sudo apt install xdotool
# xev -event keyboard        esto para tener la tecla presionada en terminal aparte
# xdotool getmouselocation --shell           para tener la posicion del mouse
# sleep 5; xdotool getactivewindow getwindowname        para tener el nombre de la ventana activa

# set -x


# 1280x1024  -------->  poweedge
# 1440x900 --------> desktop ezequiel
# 1366x768 --------> desktop administracion
# 1600x900 --------> desktop administracion


# resolucion=$(xdpyinfo | grep dimensions | sed -r 's/^[^0-9]*([0-9]+x[0-9]+).*$/\1/')
entra_al_sistema(){
    # resolucioninicial=$(xdpyinfo | grep dimensions | sed -r 's/^[^0-9]*([0-9]+x[0-9]+).*$/\1/')


    export resolucioninicial

    ESTADO=$(xset -q | grep Caps | awk {'print $4'})
    if [ "$ESTADO" = "on" ];then      
        xdotool key Caps_Lock
        sleep 1
    fi
    

    EQUIPO=$(hostname)
    if [ "$EQUIPO" = "PowerEdge-2950" ];then      
        bash /usr/local/bin/weme &
        proceso=$(ps -aux | grep [w]eme | grep .exe | awk {'print $2'})
        sleep 20
    else
        # if [[ "$resolucioninicial" != "1440x900" ]]; then
        #     xrandr -s 1440x900
        #     sleep 3
        # fi
        bash ~/.bin/weme &
        proceso=$(ps -aux | grep [w]eme | grep .exe | awk {'print $2'})
        sleep 5
    fi  
  
   # if [[ $(ps -aux | grep $proceso ) = '' ]]; then exit; fi       # esta bien pero 0036:fixme:event:wait_for_withdrawn_state window 0x4004e/9600004 wait timed out || There are no windows in the stack || Invalid window '%1' °|| Usage: windowfocus [window=%1] || --sync    - only exit once the window has focus


    # sistema=$(xdotool search --pid $proceso) 
    sistema=$(xdotool search --name "Sistema de Gestion administrativa") 
    if [ $sistema = '' ]; then exit; fi
    xdotool windowfocus $sistema
    xdotool windowsize $sistema 100% 100%
    xdotool type '02'
    xdotool key 'Return'
    xdotool type 'eze'
    xdotool key 'Return'
    xdotool key 'Return'
    sleep 4
    resolucion=$(xdpyinfo | grep dimensions | sed -r 's/^[^0-9]*([0-9]+x[0-9]+).*$/\1/')
    export resolucion

}
metepedidos(){
    if [ $sistema = '' ]; then exit; fi
    xdotool windowfocus $sistema
    # llegas hasta gestion clientes y entra
    xdotool key Alt_L 
    sleep 0.5
    xdotool key Right
    sleep 0.5 
    xdotool key Right 
    sleep 0.5
    xdotool key Right 
    sleep 0.5
    xdotool key Right 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    # baja hasta actualizacion de datos y entra
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Return  
    sleep 0.5
    # ordena la ejecucion
    xdotool key Tab 
    sleep 0.5
    xdotool key Return
    sleep 10 
    xdotool key Return
    sleep 1
}
salir(){
    if [ $sistema = '' ]; then exit; fi
    xdotool windowfocus $sistema 
    xdotool key Alt+x
    # xrandr -s $resolucioninicial
}
cierra_ventana(){
    xdotool key Escape
}
remitos_botonera(){
    xdotool mousemove 348 52 click 1
}
factura_botonera(){
    xdotool mousemove 432 59 click 1
}
remitos(){
    if [ $sistema = '' ]; then exit; fi
    xdotool windowfocus $sistema
    xdotool key 'Alt_L'
    sleep 0.5
    xdotool key 'Right'
    sleep 0.5
    xdotool key 'Right'
    sleep 0.5
    xdotool key 'Right'
    sleep 0.5
    xdotool key 'Right'
    sleep 0.5
    xdotool key 'Down'
    sleep 0.5
    xdotool key 'Down'
    sleep 0.5
    xdotool key 'Right'
    sleep 0.5
    xdotool key 'Return'
    sleep 2
}
facturas(){
    if [ $sistema = '' ]; then exit; fi
    xdotool windowfocus $sistema
    xdotool key Alt_L 
    sleep 0.5
    xdotool key Right 
    sleep 0.5
    xdotool key Right 
    sleep 0.5
    xdotool key Right 
    sleep 0.5
    xdotool key Right 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Right 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Return
    sleep 0.5
}
facturas_credito(){
    if [ $sistema = '' ]; then exit; fi
    xdotool windowfocus $sistema
    xdotool key Alt_L 
    sleep 0.5
    xdotool key Right 
    sleep 0.5
    xdotool key Right 
    sleep 0.5
    xdotool key Right 
    sleep 0.5
    xdotool key Right 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Right 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Return
}
emision_remito(){
        if [ $sistema = '' ]; then exit; fi
        xdotool windowfocus $sistema
        # cliente numero
        xdotool type '44' 
        xdotool key Return
        sleep 1
        #sucursal numero
        xdotool type $1 
        xdotool key Return
        sleep 1
        # carga los pedidos
        xdotool key F2
        sleep 5
        # presiona en seleccionar al primer pedido que tiene
        # xdotool mousemove 755 685 click 1    
    # 20210127 PRUEBA
        if [ $resolucion = "1440x900" ]; then xdotool mousemove 633 609 click 1; fi     # para la pantalla de mi pc desktop
        if [ $resolucion = "1366x768" ]; then xdotool mousemove 613 552 click 1; fi    # para la pantalla de mi notebook 1366x768
        if [ $resolucion = "1280x1024" ]; then xdotool mousemove 548 678 click 1; fi    # para la pantalla server
        if [ $resolucion = "1600x900" ]; then xdotool mousemove 727 607 click 1; fi
        if [ $resolucion = "1680x1050" ]; then xdotool mousemove 727 607 click 1; fi
        # xdotool key Tab 
        # xdotool key Tab 
        # xdotool key Return
    # 20210127 PRUEBA
        sleep 4
        # manda a guerdar/imprimir
        xdotool key F5
        sleep 5
        # le da enter al imprimir
        xdotool key Return
        sleep 7
}
emision_factura(){
    if [ $sistema = '' ]; then exit; fi
    xdotool windowfocus $sistema
    # cliente numero
    xdotool type '44' 
    xdotool key Return
    sleep 1
    #sucursal numero
    xdotool type $1 
    xdotool key Return
    sleep 1
    # carga los REMITOS
    if [ $resolucion = "1440x900" ]; then xdotool mousemove 630 662 click 1; fi   # para la pantalla de mi notebook 1366x768  
    if [ $resolucion = "1366x768" ]; then xdotool mousemove 611 603 click 1; fi   # para la pantalla de mi notebook 1366x768  
    if [ $resolucion = "1280x1024" ]; then xdotool mousemove 552 727 click 1; fi   # para la pantalla de server 
    if [ $resolucion = "1600x900" ]; then xdotool mousemove 711 662 click 1; fi 
    if [ $resolucion = "1680x1050" ]; then xdotool mousemove 747 736 click 1; fi 
    # xdotool key F4
    sleep 5
    # presiona en seleccionar al primer pedido que tiene
    # 20210127 PRUEBA    
    if [ $resolucion = "1440x900" ]; then xdotool mousemove 634 607 click 1; fi   # para la pantalla de mi pc desktop
    if [ $resolucion = "1366x768" ]; then xdotool mousemove 613 552 click 1; fi   # para la pantalla de mi notebook 1366x768  
    if [ $resolucion = "1280x1024" ]; then xdotool mousemove 556 679 click 1; fi   # para la pantalla de mi notebook 1366x768  
    if [ $resolucion = "1600x900" ]; then xdotool mousemove 715 609 click 1; fi
    # xdotool key Tab
    # xdotool key Tab
    # xdotool key Return
    # 20210127 PRUEBA    
    sleep 4
    # manda a guerdar/imprimir
    xdotool key F5
    sleep 4
    # le da enter al imprimir
    xdotool key Return
    sleep 7
}
emision_factura_martin(){
    if [ $sistema = '' ]; then exit; fi
    xdotool windowfocus $sistema
    # cliente numero
    xdotool type '19' 
    xdotool key Return
    sleep 1
    #sucursal numero
    xdotool type '1' 
    xdotool key Return
    xdotool key Left 
    xdotool key Left 
    xdotool key Left
    xdotool type $fecha
    xdotool key Tab 
    xdotool key Tab 
    xdotool key Tab
    sleep 1
    # carga los REMITOS
    if [ $resolucion = "1440x900" ]; then xdotool mousemove 630 662 click 1; fi   # para la pantalla de mi notebook 1366x768  
    if [ $resolucion = "1366x768" ]; then xdotool mousemove 611 603 click 1; fi   # para la pantalla de mi notebook 1366x768  
    if [ $resolucion = "1280x1024" ]; then xdotool mousemove 552 727 click 1; fi   # para la pantalla de server
    if [ $resolucion = "1600x900" ]; then xdotool mousemove 711 662 click 1; fi  
    if [ $resolucion = "1680x1050" ]; then xdotool mousemove 747 736 click 1; fi 
      # xdotool key F4
    sleep 5
    # presiona en seleccionar al primer pedido que tiene
    # 20210127 PRUEBA
    if [ $resolucion = "1440x900" ]; then xdotool mousemove 634 607 click 1; fi   # para la pantalla de mi pc desktop
    if [ $resolucion = "1366x768" ]; then xdotool mousemove 613 552 click 1; fi   # para la pantalla de mi notebook 1366x768  
    if [ $resolucion = "1280x1024" ]; then xdotool mousemove 556 679 click 1; fi   # para la pantalla de mi notebook 1366x768 
    if [ $resolucion = "1600x900" ]; then xdotool mousemove 715 609 click 1; fi 
    # xdotool hey Tab
    # xdotool hey Tab
    # xdotool hey Return
    # 20210127 PRUEBA
   sleep 4
    # manda a guerdar/imprimir
    xdotool key F5
    sleep 4
    # le da enter al imprimir
    xdotool key Return
    sleep 7
}
emision_factura_credito(){                          # VER RESOLUCION PANTALLA
        if [ $sistema = '' ]; then exit; fi
        xdotool windowfocus $sistema
        # cliente numero
        xdotool type '44' 
        xdotool key Return
        sleep 1
        #sucursal numero
        xdotool type $1 
        xdotool key Return
        sleep 1
        # carga los pedidos
        xdotool key F4
        sleep 3
        # presiona en seleccionar al primer pedido que tiene
        # if [ $resolucion = "1366x768" ]; then xdotool mousemove 755 685 click 1; fi    # para la pantalla de mi pc desktop
        if [ $resolucion = "1366x768" ]; then xdotool mousemove 613 552 click 1; fi    # para la pantalla de mi notebook 1366x768
        sleep 3
        # manda a guerdar/imprimir
        xdotool key F5
        sleep 1
        # le da enter al imprimir
        xdotool key Return
        xdotool mousemove 340 91 click 1  # para la pantalla de mi notebook 1366x768     REVISAR!!!!!!!
        sleep 7
}
emision_remito_martin(){
        if [ $sistema = '' ]; then exit; fi
        xdotool windowfocus $sistema
        # cliente numero
        xdotool type '19'
        xdotool key Return
        sleep 1
        #sucursal numero
        xdotool type '1' 
        xdotool key Return
        # vuelvo para tipear la fecha
        xdotool key 
        xdotool key Left 
        xdotool key Left
        xdotool type $fecha
        # vuelvo a la grilla para el pedido
        xdotool key Return 
        xdotool key Return
        sleep 1
        # carga el modelo de pedido
        if [ $resolucion = "1440x900" ]; then  xdotool mousemove 770 637 click 1; fi    # para la pantalla de mi pc desktop
        if [ $resolucion = "1366x768" ]; then xdotool mousemove 752 574 click 1; fi    # para la pantalla de mi notebook 1366x768 
        if [ $resolucion = "1280x1024" ]; then xdotool mousemove 693 702 click 1; fi    # para la pantalla de mi notebook 1366x768 
        if [ $resolucion = "1600x900" ]; then xdotool mousemove 848 632 click 1; fi        
        if [ $resolucion = "1680x1050" ]; then xdotool mousemove 889 710 click 1; fi        
        # xdotool key Return
        sleep 2
        # carga el modelo de pedido seleccionado
    # 20210127 PRUEBA
        if [ $resolucion = "1440x900" ]; then xdotool mousemove 535 609 click 1; fi
        if [ $resolucion = "1366x768" ]; then xdotool mousemove 515 549 click 1; fi    # para la pantalla de mi notebook 1366x768 
        if [ $resolucion = "1280x1024" ]; then xdotool mousemove 455 675 click 1; fi    # para la pantalla de mi notebook 1366x768 
        if [ $resolucion = "1600x900" ]; then xdotool mousemove 616 609 click 1; fi        
        # xdotool key Tab
        # xdotool key Tab
        # xdotool key Return
    # 20210127 PRUEBA
        sleep 4
        # guarda el remito
        xdotool key F5
        sleep 5
        xdotool key Return
        sleep 7
}
proceso_remito(){

    if [ ${#name[@]} = 0 ]; then
        exit
    elif [ ${#name[@]} = 1 ]; then
        emision_remito $name
    else
        for SUCURSAL in ${name[@]};
        do
            emision_remito $SUCURSAL
        done
    fi
}
proceso_factura(){

    if [ ${#name[@]} = 0 ]; then
        exit
    elif [ ${#name[@]} = 1 ]; then
        emision_factura $name
    else
        for SUCURSAL in ${name[@]};
        do
            emision_factura $SUCURSAL
        done
    fi
}
proceso_factura_credito(){

    if [ ${#name[@]} = 0 ]; then
        exit
    elif [ ${#name[@]} = 1 ]; then
        emision_factura_credito $name
    else
        for SUCURSAL in ${name[@]};
        do
            emision_factura_credito $SUCURSAL
        done
    fi
}
ejecuta_remito(){
    echo -n "Ingrese los numeros de sucursales separados por espacio y enter para terminar: "
    read -a name
    items=$((${#name[@]}*120))
    entra_al_sistema
    remitos
    proceso_remito
    cierra_ventana
    # salir
}
ejecuta_factura(){
    echo -n "Ingrese los numeros de sucursales separados por espacio y enter para terminar: "
    read -a name
    items=$((${#name[@]}*90))
    entra_al_sistema
    factura
    proceso_factura
    cierra_ventana
    # salir
}
ejecuta_factura_credito(){
    echo -n "Ingrese los numeros de sucursales separados por espacio y enter para terminar: "
    read -a name
    entra_al_sistema
    facturas_credito
    proceso_factura_credito
    cierra_ventana
    # salir
}
martin(){
    echo -n "Ingrese la fecha del remito/factura: "
    read -a fecha
    entra_al_sistema
    remitos
    emision_remito_martin
    facturas
    emision_factura_martin
    salir
}
deudores_inc(){
    if [ $sistema = '' ]; then exit; fi
    xdotool windowfocus $sistema
    Year=$(date +"%d%m%Y" -d'1 year')
    # llegas hasta gestion blientes y entra
    xdotool key Alt_L 
    sleep 0.5
    xdotool key Right 
    sleep 0.5
    xdotool key Right 
    sleep 0.5
    xdotool key Right 
    sleep 0.5
    xdotool key Right 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    # baja hasta ceuntas corrientes y entra
    xdotool key Down
    sleep 0.5 
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Right 
    sleep 0.5
    # dentro de cuentas corrientes baja 13 hasta deudores detallado y entra
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Return
    sleep 0.5
    # entro en el desplegable del formato y lo activo
    if [ $resolucion = "1440x900" ]; then xdotool mousemove 618 379 click 1; fi    # para la pantalla de mi notebook 1366x768
    if [ $resolucion = "1366x768" ]; then xdotool mousemove 672 320 click 1; fi    # para la pantalla de mi notebook 1366x768
    if [ $resolucion = "1280x1024" ]; then xdotool mousemove 612 450 click 1; fi    # para la pantalla de mi notebook 1366x768
    if [ $resolucion = "1600x900" ]; then xdotool mousemove 772 380 click 1; fi
    if [ $resolucion = "1680x1050" ]; then xdotool mousemove 814 455 click 1; fi
    # bao dos hasta el formato excel y lo selecciono
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Tab 
    sleep 0.5
    xdotool key Tab 
    sleep 0.5
    xdotool key Tab 
    sleep 0.5
    xdotool key Tab
    sleep 1
    # borro y escribo el nombre del archivo
    xdotool key Delete 
    sleep 0.5
    xdotool key Delete 
    sleep 0.5
    xdotool key Delete 
    sleep 0.5
    xdotool key Delete 
    sleep 0.5
    xdotool key Delete 
    sleep 0.5
    xdotool key Delete 
    sleep 0.5
    xdotool key Delete 
    sleep 0.5    
    xdotool key Delete 
    sleep 0.5
    xdotool key Delete 
    sleep 0.5
    xdotool key Delete 
    sleep 0.5
    xdotool key Delete
    sleep 0.5
    xdotool type 'inc.xls'
    # xdotool key Return
    # me voy a ejecutarlo y generar el reporte
    sleep 0.5
    xdotool key Tab 
    sleep 0.5
    xdotool key Tab 
    sleep 0.5
    xdotool key Tab 
    sleep 0.5
    xdotool key Tab 
    sleep 0.5
    xdotool key Tab 
    sleep 0.5
    xdotool key Tab 
    sleep 0.5
    xdotool key Tab 
    # ingreso la fecha
    xdotool type $Year
    # termino el proceso
    xdotool key Return 
    sleep 0.5
    xdotool key Return
    sleep 90
    xdotool key Tab 
    sleep 0.5
    xdotool key Return
}
recepciones(){
    if [ $sistema = '' ]; then exit; fi
    xdotool windowfocus $sistema    
    Year=$(date +"%d%m%Y" -d'- 1 month')
    # llegas hasta reportes y entra
    sleep 5
    xdotool key Alt_L 
    sleep 0.5
    xdotool key Right 
    sleep 0.5
    xdotool key Right  
    sleep 0.5
    xdotool key Right 
    sleep 0.5
    xdotool key Down 
    # baja hasta listado de recepciones y entra
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Return 
    # entro en el desplegable del formato y lo activo
    if [ $resolucion = "1440x900" ]; then xdotool mousemove 648 376 click 1; fi    # para la pantalla de mi notebook 1366x768
    if [ $resolucion = "1366x768" ]; then xdotool mousemove 672 320 click 1; fi    # para la pantalla de mi notebook 1366x768
    if [ $resolucion = "1280x1024" ]; then xdotool mousemove 639 446 click 1; fi    # para la pantalla de mi notebook 1366x768
    if [ $resolucion = "1600x900" ]; then xdotool mousemove 797 377 click 1; fi
    if [ $resolucion = "1680x1050" ]; then xdotool mousemove 836 453 click 1; fi
    # bajo dos hasta el formato excel y lo selecciono
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Tab 
    sleep 0.5
    xdotool key Tab 
    sleep 0.5
    xdotool key Tab 
    sleep 0.5
    xdotool key Tab 
    sleep 0.5
    xdotool key Tab 
    sleep 0.5
    xdotool key Tab 
    sleep 0.5
    xdotool key Tab
    sleep 1
    # borro y escribo el nombre del archivo
    xdotool key Delete 
    sleep 0.5
    xdotool key Delete 
    sleep 0.5
    xdotool key Delete 
    sleep 0.5
    xdotool key Delete 
    sleep 0.5
    xdotool key Delete 
    sleep 0.5
    xdotool key Delete 
    sleep 0.5
    xdotool key Delete 
    sleep 0.5
    xdotool key Delete 
    sleep 0.5
    xdotool key Delete 
    sleep 0.5
    xdotool key Delete 
    sleep 0.5
    xdotool key Delete
    sleep 0.5
    xdotool type 'rece.xls'
    sleep 3
    # xdotool key Return
    # me voy a ejecutarlo y generar el reporte
    xdotool key Tab 
    sleep 0.5
    xdotool key Tab 
    sleep 0.5
    xdotool key Tab 
    sleep 0.5
    xdotool key Tab 
    # ingreso la fecha
    sleep 0.5
    xdotool type $Year
    # xdotool type '24022020'
    # termino el proceso
    sleep 0.5
    xdotool key Return 
    sleep 0.5
    xdotool key Return 
    sleep 0.5
    xdotool key Return
    sleep 1
    # xdotool key Return
    sleep 15
    xdotool key Return  
    sleep 1                        
    xdotool key Tab 
    sleep 0.5
    xdotool key Return
}
ivaventas(){
    # if [ $sistema = '' ]; then exit; fi
    # xdotool windowfocus $sistema    
    mesanterior=$(date +"%m" -d'- 1 month')
    year=$(date +"%Y")
    if [[ $mesanterior = 12 ]]; then year=$(date +"%Y" -d'- 1 year'); fi
    ultimodia=`cal $mesanterior $year | grep -v '[A-Za-z]'|wc -w`
    # echo $ultimodia$mesanterior$year
    # llegas hasta gestion clientes y entra
    xdotool key Alt_L 
    sleep 0.5
    xdotool key Right 
    sleep 0.5
    xdotool key Right 
    sleep 0.5
    xdotool key Right 
    sleep 0.5
    xdotool key Right 
    sleep 0.5
    xdotool key Down 
    # baja hasta cuentas corrientes y entra
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Right 
    # dentro de cuentas corrientes baja hasta subdiario iva ventas y entra
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Return
    # entro en el desplegable del formato y lo activo
    if [ $resolucion = "1440x900" ]; then xdotool mousemove 640 391 click 1; fi    # para la pantalla de mi notebook 1366x768 
    if [ $resolucion = "1366x768" ]; then xdotool mousemove 629 336 click 1; fi    # para la pantalla de mi notebook 1366x768 
    if [ $resolucion = "1280x1024" ]; then xdotool mousemove 638 454 click 1; fi    # para la pantalla de poweredge 
    if [ $resolucion = "1600x900" ]; then xdotool mousemove 797 395 click 1; fi
    if [ $resolucion = "1650x1050" ]; then xdotool mousemove 838 469 click 1; fi
    sleep 1
    # bao dos hasta el formato excel y lo selecciono
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Return 
    sleep 0.5
    xdotool key Return
    sleep 1
    # borro y escribo el nombre del archivo
    sleep 0.5
    xdotool key Delete 
    sleep 0.5
    xdotool key Delete 
    sleep 0.5
    xdotool key Delete 
    sleep 0.5
    xdotool key Delete 
    sleep 0.5
    xdotool key Delete 
    sleep 0.5
    xdotool key Delete 
    sleep 0.5
    xdotool key Delete 
    sleep 0.5
    xdotool key Delete 
    sleep 0.5
    xdotool key Delete 
    sleep 0.5
    xdotool key Delete 
    sleep 0.5
    xdotool key Delete
    sleep 0.5
    xdotool type '/estudio/'$year$mesanterior'ivaventas.xls' 
    sleep 0.5
    xdotool key Tab 
    sleep 0.5
    xdotool key Tab #Tab
    sleep 3
    # ajusto las fechas
    sleep 0.5
    xdotool type '01'$mesanterior$year 
    sleep 0.5
    xdotool type $ultimodia$mesanterior$year  
    # xdotool key Return
    # me voy a ejecutarlo y generar el reporte
    xdotool key Return
    # espero que termine
    sleep 20
    # acepto el mensaje de finalizacion
    xdotool key Return  
    sleep 2                       
    # cierro la ventana
    xdotool key Tab Return
}
ivacompras(){
    # if [ $sistema = '' ]; then exit; fi
    # xdotool windowfocus $sistema    
    mesanterior=$(date +"%m" -d'- 1 month')
    year=$(date +"%Y")
    if [[ $mesanterior = 12 ]]; then year=$(date +"%Y" -d'- 1 year'); fi
    ultimodia=`cal $mesanterior $year | grep -v '[A-Za-z]'|wc -w`
    # echo $ultimodia$mesanterior$year
    # llegas hasta gestion proveedores y entra
    xdotool key Alt_L 
    sleep 0.5
    xdotool key Right 
    sleep 0.5
    xdotool key Right 
    sleep 0.5
    xdotool key Right 
    sleep 0.5
    xdotool key Right 
    sleep 0.5
    xdotool key Right 
    sleep 0.5
    xdotool key Down 
    # dentro de cuentas corrientes baja hasta subdiario iva ventas y entra
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    xdotool key Return
    # entro en el desplegable del formato y lo activo
    if [ $resolucion = "1440x900" ]; then xdotool mousemove 640 391 click 1; fi     
    if [ $resolucion = "1366x768" ]; then xdotool mousemove 629 336 click 1; fi        
    if [ $resolucion = "1280x1024" ]; then xdotool mousemove 636 454 click 1; fi        
    if [ $resolucion = "1600x900" ]; then xdotool mousemove 797 395 click 1; fi
    if [ $resolucion = "1680x1050" ]; then xdotool mousemove 838 469 click 1; fi
    sleep 1
    # bajo 3 hasta el formato excel y lo selecciono
    xdotool key Down 
    xdotool key Down 
    xdotool key Down Return Return
    sleep 1
    # borro y escribo el nombre del archivo
    xdotool key Delete Delete Delete Delete Delete Delete Delete Delete Delete Delete Delete
    xdotool type '/estudio/'$year$mesanterior'ivacpra.xls' 
    xdotool key Tab Tab Tab
    sleep 3
    # ajusto las fechas
    xdotool type '01'$mesanterior$year 
    xdotool type $ultimodia$mesanterior$year  
    # xdotool key Return
    # me voy a ejecutarlo y generar el reporte
    xdotool key Return
    # espero que termine
    sleep 20
    # acepto el mensaje de finalizacion
    xdotool key Return  
    sleep 2                      
    # cierro la ventana
    xdotool key Tab Return
}
cityventas(){
    if [ $sistema = '' ]; then exit; fi
    xdotool windowfocus $sistema    
    mesanterior=$(date +"%m" -d'- 1 month')
    year=$(date +"%Y")
    if [[ $mesanterior = 12 ]]; then year=$(date +"%Y" -d'- 1 year'); fi
    ultimodia=`cal $mesanterior $year | grep -v '[A-Za-z]'|wc -w`
    # llegas hasta gestion clientes y entra
    xdotool key Alt_L 
    xdotool key Right 
    xdotool key Right 
    xdotool key Right 
    xdotool key Right 
    xdotool key Down 
    # baja hasta cuentas corrientes y entra
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Right 
    # dentro de cuentas corrientes baja hasta subdiario iva ventas y entra
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Return
    # ajusto las fechas
    xdotool type '01'$mesanterior$year 
    xdotool type $ultimodia$mesanterior$year  
    # me voy a ejecutarlo y generar el reporte
    xdotool key Return
    # espero que termine
    sleep 20
    # cierro la vista previa del reporte
    if [ $resolucion = "1440x900" ]; then xdotool mousemove 268 101 click 1; fi    # para la pantalla de mi notebook 1366x768 
    if [ $resolucion = "1366x768" ]; then xdotool mousemove 310 94 click 1; fi    # para la pantalla de mi notebook 1366x768 
    if [ $resolucion = "1280x1024" ]; then xdotool mousemove 270 107 click 1; fi    # para la pantalla de mi notebook 1366x768 
    if [ $resolucion = "1600x900" ]; then xdotool mousemove 797 395 click 1; fi
    if [ $resolucion = "1680x1050" ]; then xdotool mousemove 838 469 click 1; fi
    sleep 1                   
    # cierro la ventana
    xdotool key Tab 
    xdotool key Return
    mv '/media/trabajo/Trabajo/WEME/exportacion/alicuota_cv_'*_$year'.txt' '/media/trabajo/Trabajo/WEME/exportacion/estudio/'
    mv '/media/trabajo/Trabajo/WEME/exportacion/reginfo_cv_'*_$year'.txt' '/media/trabajo/Trabajo/WEME/exportacion/estudio/'
}
citycompras(){
    if [ $sistema = '' ]; then exit; fi
    xdotool windowfocus $sistema    
    mesanterior=$(date +"%m" -d'- 1 month')
    year=$(date +"%Y")
    if [[ $mesanterior = 12 ]]; then year=$(date +"%Y" -d'- 1 year'); fi
    ultimodia=`cal $mesanterior $year | grep -v '[A-Za-z]'|wc -w`
    # llegas hasta gestion clientes y entra
    xdotool key Alt_L 
    xdotool key Right 
    xdotool key Right
    xdotool key Right 
    xdotool key Right 
    xdotool key Right 
    xdotool key Down 
    sleep 1
    # dentro de cuentas corrientes baja hasta subdiario iva ventas y entra
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Return
    # ajusto las fechas
    xdotool type '01'$mesanterior$year 
    xdotool type $ultimodia$mesanterior$year  
    # me voy a ejecutarlo y generar el reporte
    xdotool key Return
    # espero que termine
    sleep 20
    # cierro la vista previa
    if [ $resolucion = "1440x900" ]; then xdotool mousemove 268 101 click 1; fi    
    if [ $resolucion = "1366x768" ]; then xdotool mousemove 310 94 click 1; fi    
    if [ $resolucion = "1280x1024" ]; then xdotool mousemove 270 107 click 1; fi    # para la pantalla de mi notebook 1366x768 
    if [ $resolucion = "1600x900" ]; then xdotool mousemove 797 395 click 1; fi
    if [ $resolucion = "1680x1050" ]; then xdotool mousemove 838 469 click 1; fi
    sleep 1                     
    # cierro la ventana
    xdotool key Tab 
    xdotool key Return
    mv '/media/trabajo/Trabajo/WEME/exportacion/alicuota_cc_'*_$year'.txt' '/media/trabajo/Trabajo/WEME/exportacion/estudio/'
    mv '/media/trabajo/Trabajo/WEME/exportacion/reginfo_cc_'*_$year'.txt' '/media/trabajo/Trabajo/WEME/exportacion/estudio/'
}
emision_comprobantes(){
    set -x
    resolucion=$(xdpyinfo | grep dimensions | sed -r 's/^[^0-9]*([0-9]+x[0-9]+).*$/\1/')
    if [ $sistema = '' ]; then exit; fi
    xdotool windowfocus $sistema
    xdotool key Alt_L Right Right Right Right Down Down Right Down Down Down Down Down Down Down Return
    if [ $resolucion = "1440x900" ]; then xdotool mousemove 458 556 click 1; fi    # para la pantalla de mi notebook 1366x768
    if [ $resolucion = "1366x768" ]; then xdotool mousemove 442 498 click 1; fi    # para la pantalla de mi notebook 1366x768
    if [ $resolucion = "1280x1024" ]; then xdotool mousemove 373 652 click 1; fi    # para la pantalla de mi notebook 1366x768
    if [ $resolucion = "1600x900" ]; then xdotool mousemove 539 557 click 1; fi
    if [ $resolucion = "1680x1050" ]; then xdotool mousemove 581 633 click 1; fi
    echo $items
    sleep $items # 1,5 min espera por factura
    xdotool windowfocus $sistema
    if [ $resolucion = "1440x900" ]; then xdotool mousemove 972 555 click 1; fi    # para la pantalla de mi notebook 1366x768
    if [ $resolucion = "1366x768" ]; then xdotool mousemove 953 500 click 1; fi    # para la pantalla de mi notebook 1366x768
    if [ $resolucion = "1600x900" ]; then xdotool mousemove 1051 556 click 1; fi
    # if [ $resolucion = "1680x1050" ]; then xdotool mousemove 1051 556 click 1; fi
    # if [ $resolucion = "1280x1024" ]; then xdotool mousemove 1051 556 click 1; fi
}
percepciones(){
    if [ $sistema = '' ]; then exit; fi
    xdotool windowfocus $sistema    
    mesanterior=$(date +"%m" -d'- 1 month')
    year=$(date +"%Y")
    if [[ $mesanterior = 12 ]]; then year=$(date +"%Y" -d'- 1 year'); fi
    ultimodia=`cal $mesanterior $year | grep -v '[A-Za-z]'|wc -w`
    # llegas hasta gestion clientes y entra
    xdotool key Alt_L 
    xdotool key Right 
    xdotool key Right 
    xdotool key Right 
    xdotool key Right 
    xdotool key Down
    xdotool key 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Right 
    sleep 1
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Return
    sleep 1
    # # entro en el desplegable del formato y lo activo
    # ajusto las fechas
    xdotool type '01'$mesanterior$year 
    xdotool type $ultimodia$mesanterior$year  
    xdotool type '0003'  
    # me voy a ejecutarlo y generar el reporte
    xdotool key Return
    # espero que termine
    sleep 20
    # cierro la vista previa
    if [ $resolucion = "1440x900" ]; then xdotool mousemove 640 391 click 1; fi    
    if [ $resolucion = "1366x768" ]; then xdotool mousemove 310 94 click 1; fi    
    if [ $resolucion = "1280x1024" ]; then xdotool mousemove 270 103 click 1; fi 
    if [ $resolucion = "1600x900" ]; then xdotool mousemove 272 101 click 1; fi   
    if [ $resolucion = "1680x1050" ]; then xdotool mousemove 270 102 click 1; fi   
    sleep 1                     
    # cierro la ventana
    xdotool key Tab 
    xdotool key Return
    mv '/media/trabajo/Trabajo/WEME/exportacion/percep'*'.txt' '/media/trabajo/Trabajo/WEME/exportacion/estudio/'
}
retenciones(){                                  # se hace por quincena
    if [ $sistema = '' ]; then exit; fi
    xdotool windowfocus $sistema    
    mesanterior=$(date +"%m" -d'- 1 month')
    year=$(date +"%Y")
    dia=$(date +"%d")
    # dia=05
    mes=$(date +"%mm")
    # if [[ $mesanterior = 12 ]]; then year=$(date +"%Y" -d'- 1 year'); fi
    if [[ $mesanterior = 12 ]]; then year=$(date +"%Y" -d'- 1 year'); fi
    if [[ $dia -gt 15 ]]; then year=$(date +"%Y"); fi
    ultimodia=`cal $mesanterior $year | grep -v '[A-Za-z]'|wc -w`
    # llegas hasta gestion clientes y entra
    xdotool key Alt_L 
    xdotool key Right 
    xdotool key Right 
    xdotool key Right 
    xdotool key Right 
    xdotool key Right 
    xdotool key Down 
    sleep 1
    # dentro de cuentas corrientes baja hasta subdiario iva ventas y entra
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Down 
    xdotool key Return
    # ajusto las fechas
    if (( $dia >= 01 && $dia <= 15 )); then
    # if (( 01 <= $dia <= 15 )); then
        xdotool type '16'$mesanterior$year 
        xdotool type $ultimodia$mesanterior$year
    else
        xdotool type '01'$mes$year 
        xdotool type '15'$mes$year
    fi  
    # me voy a ejecutarlo y generar el reporte
    xdotool key Return
    # espero que termine
    sleep 20
    # cierro la vista previa
    if [ $resolucion = "1440x900" ]; then xdotool mousemove 640 391 click 1; fi    
    if [ $resolucion = "1366x768" ]; then xdotool mousemove 310 94 click 1; fi    
    if [ $resolucion = "1280x1024" ]; then xdotool mousemove 270 103 click 1; fi 
    if [ $resolucion = "1600x900" ]; then xdotool mousemove 272 101 click 1; fi      
    if [ $resolucion = "1680x1050" ]; then xdotool mousemove 270 102 click 1; fi   
    sleep 1                     
    # cierro la ventana
    xdotool key Tab 
    xdotool key Return
    mv '/media/trabajo/Trabajo/WEME/exportacion/retenc'*'.txt' '/media/trabajo/Trabajo/WEME/exportacion/estudio/'
}
deudores_gral(){
    if [ $sistema = '' ]; then exit; fi
    xdotool windowfocus $sistema
    
    mesanterior=$(date +"%m" -d'- 1 month')
    year=$(date +"%Y" -d' +1 year')
    year_real=$(date +"%Y")
    if [[ $mesanterior = 12 ]]; then year=$(date +"%Y" -d'- 1 year'); fi
    ultimodia=`cal $mesanterior $year | grep -v '[A-Za-z]'|wc -w`

    # llegas hasta gestion clientes y entra
    xdotool key Alt_L 
    sleep 0.5
    for i in {1..4}; do xdotool key Right; sleep 0.1; done
    xdotool key Down 
    sleep 0.5
    # baja hasta ceuntas corrientes y entra
    for i in {1..5}; do xdotool key Down; sleep 0.1; done
    xdotool key Right 
    sleep 0.5
    # dentro de cuentas corrientes baja 13 hasta deudores detallado y entra
    for i in {1..13}; do xdotool key Down; sleep 0.1; done
    xdotool key Return
    sleep 0.5
    # entro en el desplegable del formato y lo activo
    if [ $resolucion = "1440x900" ]; then xdotool mousemove 618 379 click 1; fi    # para la pantalla de mi notebook 1366x768
    if [ $resolucion = "1366x768" ]; then xdotool mousemove 672 320 click 1; fi    # para la pantalla de mi notebook 1366x768
    if [ $resolucion = "1280x1024" ]; then xdotool mousemove 614 441 click 1; fi    # para la pantalla de mi notebook 1366x768
    if [ $resolucion = "1600x900" ]; then xdotool mousemove 772 380 click 1; fi
    if [ $resolucion = "1680x1050" ]; then xdotool mousemove 814 455 click 1; fi
    # bao dos hasta el formato excel y lo selecciono
    xdotool key Down 
    sleep 0.5
    xdotool key Down 
    sleep 0.5
    for i in {1..4}; do xdotool key Tab; sleep 0.1; done

    sleep 1
    # borro y escribo el nombre del archivo
    for i in {1..11}; do xdotool key Delete; sleep 0.1; done
    xdotool type '/estudio/'$year_real$mesanterior'deudores.xls' 
    # xdotool key Return
    # me voy a ejecutarlo y generar el reporte
    sleep 0.5
    for i in {1..3}; do xdotool key Tab; sleep 0.1; done
    ############## creo q aca pongo el cliente y sucursal
    xdotool type '1'
    xdotool key Return
    xdotool type '1'
    xdotool key Return
    xdotool type '999999'
    xdotool key Return
    xdotool type '999'
    xdotool key Return
    # ingreso la fecha
    xdotool type $ultimodia$mesanterior$year
    # termino el proceso
    xdotool key Return 
    EQUIPO=$(hostname)
    if [ "$EQUIPO" = "PowerEdge-2950" ];then      
        sleep 480
    else
        sleep 60
    fi
    # xdotool key Return
    # echo 'espero q cree en informe'
    # sleep 180
    # echo 'termino informe informe'
    xdotool key Tab 
    sleep 0.5
    #     xdotool key Return
}
proveedores(){
    if [ $sistema = '' ]; then exit; fi
    xdotool windowfocus $sistema
    
    mesanterior=$(date +"%m" -d'- 1 month')
    year=$(date +"%Y" -d' +1 year')
    year_real=$(date +"%Y")
    if [[ $mesanterior = 12 ]]; then year=$(date +"%Y" -d'- 1 year'); fi
    ultimodia=`cal $mesanterior $year | grep -v '[A-Za-z]'|wc -w`
    
    # llegas hasta gestion proveedores y entra
    xdotool key Alt_L 
    sleep 0.1
    for i in {1..5}; do xdotool key Right; sleep 0.1; done
    xdotool key Down 
    sleep 0.1
    # dentro de proveedores baja 13 hasta deudores detallado y entra
    for i in {1..15}; do xdotool key Down; sleep 0.1; done
    xdotool key Return
    sleep 0.5
    # se queda en la casilla para introducir numero de proveedor desde hasta
    xdotool type '1'
    xdotool key Return
    xdotool type '999999'
    sleep 1
    xdotool type $ultimodia$mesanterior$year
    # entro en el desplegable del formato y lo activo
    if [ $resolucion = "1440x900" ]; then xdotool mousemove 618 379 click 1; fi
    if [ $resolucion = "1366x768" ]; then xdotool mousemove 672 320 click 1; fi
    if [ $resolucion = "1280x1024" ]; then xdotool mousemove 612 441 click 1; fi
    if [ $resolucion = "1600x900" ]; then xdotool mousemove 772 380 click 1; fi
    if [ $resolucion = "1680x1050" ]; then xdotool mousemove 814 455 click 1; fi
    for i in {1..2}; do xdotool key Down; sleep 0.1; done
    for i in {1..4}; do xdotool key Tab; sleep 0.1; done
    for i in {1..11}; do xdotool key Delete; sleep 0.1; done
    xdotool type '/estudio/'$year_real$mesanterior'prov.xls' 
    for i in {1..6}; do xdotool key Tab; sleep 0.5; done
    sleep 3
    xdotool key Return
        EQUIPO=$(hostname)
    if [ "$EQUIPO" = "PowerEdge-2950" ];then      
        sleep 480
    else
        sleep 60
    fi
    xdotool key Tab 
    sleep 0.5
    xdotool key Return
    xdotool key Tab 
    xdotool key Return

}

produccion(){
    if [ $sistema = '' ]; then exit; fi
    xdotool windowfocus $sistema
    
    mesanterior=$(date +"%m" -d'- 1 month')
    year=$(date +"%Y")
    if [[ $mesanterior = 12 ]]; then year=$(date +"%Y" -d'- 1 year'); fi
    ultimodia=`cal $mesanterior $year | grep -v '[A-Za-z]'|wc -w`

    echo $mesanterior

    # llegas hasta gestion blientes y entra
    xdotool key Alt_L 
    sleep 0.5
    for i in {1..6}; do xdotool key Right; sleep 0.1; done
    sleep 0.5
    for i in {1..3}; do xdotool key Down; sleep 0.1; done
    xdotool key Return
    sleep 1
    xdotool type '01'$mesanterior$year 
    xdotool type $ultimodia$mesanterior$year
    if [ $resolucion = "1440x900" ]; then xdotool mousemove 714 395 click 1; fi    # para la pantalla de mi notebook 1366x768 
    # if [ $resolucion = "1366x768" ]; then xdotool mousemove 310 94 click 1; fi    # para la pantalla de mi notebook 1366x768 
    if [ $resolucion = "1280x1024" ]; then xdotool mousemove 637 456 click 1; fi    # para la pantalla de mi notebook 1366x768 
    # if [ $resolucion = "1600x900" ]; then xdotool mousemove 797 395 click 1; fi
    # if [ $resolucion = "1680x1050" ]; then xdotool mousemove 838 469 click 1; fi  
    for i in {1..2}; do xdotool key Down; sleep 0.1; done
    for i in {1..3}; do xdotool key Tab; sleep 0.1; done
        for i in {1..11}; do xdotool key Delete; sleep 0.1; done
    xdotool type '/estudio/'$year$mesanterior'prod.xls'
    for i in {1..5}; do xdotool key Tab; sleep 0.1; done
    xdotool key Return
    sleep 10
    xdotool key Return
    sleep 0.5
    xdotool key Tab
    sleep 0.5
    xdotool key Return
}

actualiza_padron(){
    mes=$(date +"%m")
    year=$(date +"%Y")
    if [ $sistema = '' ]; then exit; fi
    xdotool windowfocus $sistema
    # entra al menu
    xdotool key Alt_L 
    sleep 0.5
    # 7 a la derecha
    for i in {1..7}; do xdotool key Right; sleep 0.1; done
    sleep 0.5
    for i in {1..12}; do xdotool key Down; sleep 0.1; done
    sleep 0.5
    xdotool key Return
    xdotool type 'PadronRGSPer'$mes$year'.TXT'
    xdotool key Tab
    xdotool type 'PadronRGSRet'$mes$year'.TXT'
    xdotool key Tab
    xdotool key Return
    sleep 180
    xdotool key Tab
    xdotool key Return

}


# entra_al_sistema              
# metepedidos
# remitos
# sleep 3
# cierra_ventana
# sleep 3
# facturas
# facturas_credito  
# deudores_inc
# emision_remito_martin
# proceso_remito
# gdialog --msgbox "Remitos Emitidos" 
# cierra_ventana
# cityventas
# sleep 3
# citycompras
# sleep 3
# recepciones
# deudores_inc
# metepedidos
# salir
# percepciones
# deudores_gral
# actualiza_padron