#!/usr/bin/python3
#-*-coding: utf-8 -*-

import os
import easygui

# Establecemos donde estan los pedidos a analizar
directorio = ( "/media/trabajo/Trabajo/WEME/ASPEDI/PRODUCCION/ENTRADA/pedidos/" )    
temporario = ( "/tmp/pendientes" )

# Borramos este archivo que ses genera por algun error o linea vacia al procesar los archivos
if os.path.isfile( directorio + ".TXT.txt" ):
		os.remove( directorio + ".TXT.txt" )

# Generamos la lista de los pedidos pendientes en la carpeta (antes los mando a un archivo temporario sin extension para mostrar en pantalla la lista)
pendientes = open( temporario, "w", encoding='utf-8' )

for nombreArchivo in os.listdir( directorio ):
    if nombreArchivo.endswith( ".txt" ):
        if nombreArchivo == "":
            print ( "No hay pedidos Pendientes" )
            quit()
        pendientes.write( nombreArchivo + '\n')  
				
pendientes.close()

with open( temporario, 'r' ) as f:
    for i, line in enumerate(f, start=0):
        print('{} = {}'.format(i, line.strip()))


# pido el numero de pedido a mostrar

# pedidos = open( temporario, 'r', encoding='utf-8')

# numeropedidos = [ pedidos.readlines() ]

# pedidos.close()

with open(temporario,'r') as pedidos: 
    numeropedidos = [linea.strip() for linea in pedidos]

totalpedidos = (len(numeropedidos))

ingreso = input( "Ingrese el Numero de Pedido: " )

# print ( ingreso )
# print( numeropedidos[int(ingreso)] )
ingresoint = int(ingreso)
# pedidoseleccionado = open( temporario, 'r' )
# numeropedido = pedidoseleccionado.readfiles()
# print ( pedidoseleccionado[ingresoint] )

######## ver aca
if int(ingreso) > totalpedidos:
    print ("El numero no puede ser mayor que ", totalpedidos)
    quit()
######################3
with open(directorio + numeropedidos[ingresoint],'r') as pedidos:
    print( pedidos.read() )

os.remove( "/tmp/pendientes" )