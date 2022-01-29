#!/usr/bin/python3
# -*- coding: utf-8 -*-

# REQUISITO pip3 install
# apt-get install python-tk

import os
import csv
from tkinter import *
from tkinter import scrolledtext

# a tener muy en cuenta para hacer cuentas y cortar partes
# def PrintThree(string):
    # return string[:3]

# path = "/media/trabajo/Trabajo/scripts/lab/pedidos/"
path = "/media/trabajo/Trabajo/WEME/ASPEDI/PRODUCCION/ENTRADA/"
pathpedido = path + 'pedidos/'

articulos = [7798329040588, 7798329040571, 7798329040274, 7798329040281, 7798329040137, 7798329040519, 7798329040526, 7798329040557, 2664178000002, 2664179000001, 7798329040564, 7798329040311, 7798329040304, 7798329040106, 7798329040328, 7798329040540, 7798329040502, 7798329040533, 7798329040083, 7798329040120, 7798329040335, 7798329040090, 7798329040342, 7798329040441]
articulosaeliminar = [7798329040137]


def crealistapedidos():
                    # path = "/media/trabajo/Trabajo/WEME/ASPEDI/PRODUCCION/ENTRADA/"
                    ordenesdecompra = []
                    with os.scandir(path) as ficheros:
                        for fichero in ficheros:
                            if fichero.name.startswith("CABPED"):
                                if fichero.name.endswith(".TXT"):
                                    ordenesdecompra.append(fichero.name[7:23] )
                    return ordenesdecompra

def pedidosindividual(ordendecompra):
                    filenames = ["CABPED_"+ordendecompra+".TXT", "LINPED_"+ordendecompra+".TXT"]
                    with open(pathpedido+ordendecompra+'.txt', 'w') as outfile:

                        for fname in filenames:

                            with open(path+fname) as infile:

                                outfile.write(infile.read())

def edicionpedidos(ordendecompra):
                        pedido = open(pathpedido+ordendecompra+'.txt', 'r+', encoding='utf-8')
                        temporario = open(pathpedido+'tmp_'+ordendecompra+'.txt', 'w', encoding='utf-8')
                        totales = open(pathpedido+'totales.txt', 'a', encoding='utf-8')
                        # resumen = open(pathpedido+'resumen.txt', 'a', encoding='utf-8')
                        lineas = pedido.readlines()
                        total_lineas = len(lineas)
                        sucursal = lineas[0]
                        temporario.write("Tienda: "+sucursal[466:499]+" | Fecha de entrega: "+sucursal[66:74])
                        separador = "_" * 70
                        # resumen.write("\n" + separador + "\n")
                        # resumen.write("\nTienda: "+sucursal[466:499]+" | Fecha de entrega: "+sucursal[66:74])
                        for n in range(1,total_lineas):
                            articulo = lineas[n]
                            temporario.write("\nItem: "+articulo[121:156]+" | Cantidad: "+articulo[351:359]+" | Precio: "+articulo[299:321]+" | EAN: "+articulo[20:33])
                            # resumen.write("\nItem: "+articulo[121:145]+" | Cantidad: "+articulo[351:357]+" | EAN: "+articulo[20:33])
                            totales.write(articulo[20:33]+"|"+articulo[121:156]+"|"+articulo[351:359]+"|"+articulo[299:321]+"|"+ordendecompra+"\n")
                        os.remove(pathpedido+ordendecompra+'.txt')
                        os.replace(pathpedido+'tmp_'+ordendecompra+'.txt', pathpedido+ordendecompra+'.txt')
                        totales.close()
                        # return resumen

def resumen():
                    resumen = open(pathpedido+'resumen.txt', 'a', encoding='utf-8')
                    ordenesdecomprapendientes = []
                    tiendas = open(pathpedido+'tiendas.txt', 'w', encoding='utf-8')
                    with os.scandir(pathpedido) as ficheros:
                        for fichero in ficheros:
                            if fichero.name.endswith(".txt"):
                                ordenesdecomprapendientes.append(fichero.name[0:20] )
                    ordenesdecomprapendientes.remove("totales.txt")
                    ordenesdecomprapendientes.remove("resumen.txt")
                    ordenesdecomprapendientes.remove("tiendas.txt")
                    for pendiente in ordenesdecomprapendientes:
                        #print(pendiente)
                        with open(pathpedido+pendiente, 'r') as file:
                            lineas = file.readlines()
                            total_lineas = len(lineas)
                            sucursal = lineas[0]
                            separador = "_" * 70
                            resumen.write("\n" + separador + "\n")
                            resumen.write("\nTienda: "+sucursal[8:34]+" | Fecha de entrega: "+sucursal[62:71])
                            tiendas.write(sucursal[8:34]+"\n")
                            for n in range(1,int(total_lineas)-1):
                                articulo = lineas[n]
                                resumen.write("\nItem: "+articulo[6:34]+" | Cantidad: "+articulo[54:60]+" | EAN: "+articulo[103:117])
                    # return sucursales
                    ordenesdecomprapendientes = []

def creaciontotales(ean): # totales pendientes a ingresar
                    conteo = open(pathpedido+'total.txt', 'a', encoding='utf-8')
                    with open(pathpedido+"totales.txt", 'r') as file:
                        pedidoleido = csv.reader(file, delimiter='|')
                        tot = 0
                        art = ""
                        for linea in pedidoleido:
                            if linea[0] == str(ean):
                                art = str(linea[1])
                                sub = int(linea[2])//100
                                tot = sub + tot
                        conteo.write(art+":"+str(tot)+"\n")
                            # conteo.write("Total de "+art+": "+str(tot)+"\n")
                        # print("Total de "+art+": "+str(tot))
                    # os.remove(pathpedido+'totales.txt')

def creaciontotalespedidos(orden): # se arma el total de cada pedido
                    total = open(pathpedido+orden+'.txt', 'a', encoding='utf-8')
                    with open(pathpedido+orden+'.txt', 'r') as file:
                        pedidoleido = file.readlines()[1:]
                        tot = 0
                        for lineas in pedidoleido:
                            sub = int(lineas[54:60])
                            tot = sub + tot
                        total.write("\nTotal del pedido:"+str(tot))


def pendientesdeentrega(): # arma con todos los pedidos pendientes un archivo unico
                    if os.path.exists(pathpedido+'pendientes.txt'):
                        os.remove(pathpedido+'pendientes.txt')
                    pendientesdeentrega = open(pathpedido+'pendientes.txt', 'a', encoding='utf-8')
                    ordenesdecomprapendientes = []
                    with os.scandir(pathpedido) as ficheros:
                        for fichero in ficheros:
                                if fichero.name.endswith(".txt"):
                                    ordenesdecomprapendientes.append(fichero.name[0:20] )
                    for pendiente in ordenesdecomprapendientes:
                        with open(pathpedido+pendiente, 'r') as file:
                            for linea in file:
                                pendientesdeentrega.write(linea)


def aentregar(ean): # aca se crea el archivo y entrega que tiene los totales de pendientedeentrega

                    entrega = open(pathpedido+'entrega.txt', 'a', encoding='utf-8')
                    tot = 0
                    art = ""
                    with open(pathpedido+"pendientes.txt", 'r') as file:
                        for linea in file:
                            if linea[103:116] == str(ean):
                                art = str(linea[6:42])
                                sub = int(linea[54:60])
                                tot = sub + tot
                        entrega.write(art+":"+str(tot)+"\n")


def total_pedidos():
    with os.scandir(path) as ficheros:
        total_pedidos = 0
        for fichero in ficheros:
            if fichero.name.startswith("CABPED"):
                if fichero.name.endswith(".TXT"):
                    total_pedidos = total_pedidos + 1
        ped = str( total_pedidos )
        # print(ped)
        return ped

def total_recepciones():   
    with os.scandir(path) as ficheros:
        total_rece = 0
        for fichero in ficheros:
            if fichero.name.startswith("CABCRE"):
                if fichero.name.endswith(".TXT"):
                    total_rece = total_rece + 1
        rec = str(total_rece)
        # print(rec)
        return rec

def visualizador():
                window = Tk()
                window.title("Detalle De Pedidos")
                # window.geometry('607x300')
                window.resizable(0,0) # no deja agrandar o achicar la ventana
                resumen = open(pathpedido+'resumen.txt', 'r', encoding='utf-8')
                informe = resumen.read()
                txt = scrolledtext.ScrolledText(window)#,width=73,height=17)
                txt.insert(INSERT,informe)
                txt.grid(column=0,row=0)
                window.mainloop()
                if os.path.exists(pathpedido+'resumen.txt'):
                    os.remove(pathpedido+'resumen.txt')

def borrabasura():
	if os.path.exists(pathpedido+'.TXT.txt'):
		os.remove(pathpedido+'.TXT.txt')


#if os.path.exists(path+'CABPED*.TXT'):
existe = [x for x in os.listdir(path) if len(x) >= 6 and  x[:6] == "CABPED"]
#print(existe)
if existe:
    for item in articulosaeliminar:
        borra = "sed -i '/" + str(item) + "/d' " + path + "LINPED*.TXT"
        os.system(borra)

    if os.path.exists(pathpedido+'totales.txt'):
        os.remove(pathpedido+'totales.txt')

    if os.path.exists(pathpedido+'total.txt'):
        os.remove(pathpedido+'total.txt')

    if os.path.exists(pathpedido+'resumen.txt'):
        os.remove(pathpedido+'resumen.txt')

    if os.path.exists(pathpedido+'pendientes.txt'):
        os.remove(pathpedido+'pendientes.txt')

    if os.path.exists(pathpedido+'entrega.txt'):
        os.remove(pathpedido+'entrega.txt')

    ordenesdecompra = crealistapedidos()

    cantidadpedidos = len(ordenesdecompra)

    for orden in ordenesdecompra:
        pedidosindividual(orden)
        edicionpedidos(orden)
        creaciontotalespedidos(orden)
    borrabasura()

    resumen()
    #
    for ean in articulos:
        creaciontotales(ean)
        pendientesdeentrega()
        limpiar1 = "sed -i '/Tienda/d' " + pathpedido + "pendientes.txt"
        os.system(limpiar1)
        limpiar2 = "sed -i '/Total/d' " + pathpedido + "pendientes.txt"
        os.system(limpiar2)
        aentregar(ean)
        os.remove(pathpedido+'pendientes.txt')
    borrabasura()
    resu = "sed -i '/^$/d' " + pathpedido + "resumen.txt"
    os.system(resu)
    resu1 = "sed -i '/Tienda: jas/d' " + pathpedido + "resumen.txt"
    os.system(resu1)
    resu2 = "sed -i '/Item: Items=/d' " + pathpedido + "resumen.txt"
    os.system(resu2)
    os.system(resu2)
    resu3 = "sed -i '/ | Cantidad:  | EAN: /d' " + pathpedido + "resumen.txt"
    os.system(resu3)
    os.system(resu3)
    resu4 = "sed -i '/Item: Entrega=/d' " + pathpedido + "resumen.txt"
    os.system(resu4)
    resu5 = "sed -i '/^ | Fecha de entrega: /d' " + pathpedido + "resumen.txt"
    os.system(resu5)
    resu6 = "sed -i '/^:0/d' " + pathpedido + "total.txt"
    os.system(resu6)
    resu6 = "sed -i '/^:0/d' " + pathpedido + "entrega.txt"
    os.system(resu6)
    # resu6 = "sed -i '$!N;/^\(.*\)\n\1$/!P;D' " + pathpedido + "resumen.txt" # funciona bien en la terminal pero aca no. es para borrar las rayas duplicadas
    # os.system(resu6)                                                        # que aparecen por el txt vacio que se crea
    # ver esta opcion con awl """"    awk '!seen[$0]' inicial.txt final.txt
    borrabasura()
    with open("/media/trabajo/Trabajo/scripts/informe.log", 'w') as file:  
        totalespendientesdeentrega = 0
        totalespendientesdeingresar = 0
        with open(pathpedido+"entrega.txt", 'r') as file2:
            for linea in file2:
                sub2 = int(linea[37:])
                totalespendientesdeentrega = sub2 + totalespendientesdeentrega
        totalespendientesdeingresar = 0
        with open(pathpedido+"total.txt", 'r') as file3:
            for linea2 in file3:
                sub3 = int(linea2[36:])
                totalespendientesdeingresar = sub3 + totalespendientesdeingresar
        separador = "_" * 45
        file.write( "\nHAY " + total_pedidos() + " PEDIDO(S)" )
        file.write( "\nHAY " + total_recepciones() + " RECEPCIONE(S)" )
        file.write("\n" + str(separador) + "\n\n" )
        with open(pathpedido+'total.txt', 'r', encoding='utf-8') as total:
            for linea in total:
                file.write(str(linea))
        file.write("\nTOTAL PENDIENTE DE INGRESAR: " + str(totalespendientesdeingresar) + "\n")
        file.write( str(separador) + "\n\n" )
        with open(pathpedido+'tiendas.txt', 'r', encoding='utf-8') as total:
            for linea in total:
                file.write(str(linea))
        file.write( str(separador) + "\n\n" )
        file.write("TOTAL PENDIENTE DE ENTREGA: " + str(totalespendientesdeentrega) + "\n\n")
        with open(pathpedido+'entrega.txt', 'r', encoding='utf-8') as entregas:
            for linea in entregas:
                file.write(str(linea)) 

    if os.path.exists(pathpedido+'totales.txt'):
        os.remove(pathpedido+'totales.txt')

    if os.path.exists(pathpedido+'tiendas.txt'):
        os.remove(pathpedido+'tiendas.txt')
    borrabasura()
    visualizador()
'''
else:
    
    separador = "_" * 45
    borrabasura()
    pendientesdeentrega()
    for ean in articulos:
        aentregar(ean)
    resu6 = "sed -i '/^:0/d' " + pathpedido + "entrega.txt"  
    os.system(resu6)
    with open("/media/trabajo/Trabajo/scripts/informe.log", 'w') as file:  
        
        totalespendientesdeentrega = 0
        totalespendientesdeingresar = 0
        with open(pathpedido+"entrega.txt", 'r') as file2:
            for linea in file2:
                sub2 = int(linea[37:])
                totalespendientesdeentrega = sub2 + totalespendientesdeentrega
        totalespendientesdeingresar = 0
        if os.path.exists(pathpedido+'total.txt'):
            with open(pathpedido+"total.txt", 'r') as file3:
                for linea2 in file3:
                    sub3 = int(linea2[36:])
                    totalespendientesdeingresar = sub3 + totalespendientesdeingresar
        separador = "_" * 45
        
        file.write( "\nHAY " + total_pedidos() + " PEDIDO(S)" )
        file.write( "\nHAY " + total_recepciones() + " RECEPCIONE(S)" )
        file.write("\n" + str(separador) + "\n\n" )
        if os.path.exists(pathpedido+'total.txt'):
            with open(pathpedido+'total.txt', 'r', encoding='utf-8') as total:
                for linea in total:
                    file.write(str(linea))
        file.write("\nTOTAL PENDIENTE DE INGRESAR: " + str(totalespendientesdeingresar) + "\n")
        file.write( str(separador) + "\n\n" )
        if os.path.exists(pathpedido+'tiendas.txt'):
            with open(pathpedido+'tiendas.txt', 'r', encoding='utf-8') as total:
                for linea in total:
                    file.write(str(linea))
        file.write( str(separador) + "\n\n" )
        file.write("TOTAL PENDIENTE DE ENTREGA: " + str(totalespendientesdeentrega) + "\n\n")
        with open(pathpedido+'entrega.txt', 'r', encoding='utf-8') as entregas:
            for linea in entregas:
                file.write(str(linea)) 
    borrabasura()  
'''