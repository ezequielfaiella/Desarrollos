#!/usr/bin/python3
# -*- coding: utf-8 -*-

'''
if sys.platform == "Windows": 
    os.system("md " + dir_name) 
elif sys.platform == "Linux": 
    os.system("mkdir " + dir_name) 
'''
import tkinter as tk
from tkinter import *
from tkinter import scrolledtext
import haypedidos
import os
import subprocess as sub
from modulos.promedio import calculopromedio
from modulos.tiendas_faltantes import obtenerfaltantes
from shutil import which

def close():
    v_principal.destroy()
    v_principal.quit()
    
def ver_pedidos():
    path = "/media/trabajo/Trabajo/WEME/ASPEDI/PRODUCCION/ENTRADA/"
    pathpedido = path + 'pedidos/'
    if os.path.exists(pathpedido+'resumen.txt'):
        os.remove(pathpedido+'resumen.txt')
    txt.delete(1.0,END)
    haypedidos.resumen()
    resumen = open(pathpedido+'resumen.txt', 'r', encoding='utf-8')
    informe = resumen.read()
    txt.insert(INSERT,informe)
    resumen.close()
    if os.path.exists(pathpedido+'resumen.txt'):
        os.remove(pathpedido+'resumen.txt')

def oculta_pedido():
    txt.delete(1.0,END)

def arma_reparto_xls():
    txt.delete(1.0,END)
    txt.insert(INSERT,'Se Esta abriendo la planilla de reparto')
    os.system('python3 /media/trabajo/Trabajo/scripts/logistica.py')

def etiquetas_xls():
    txt.delete(1.0,END)
    txt.insert(INSERT,'Se Esta abriendo la planilla de etiquetas')
    office = which('soffice')
    if office == None:
         ejecutalibre = 'libreoffice7.2 "/media/trabajo/Trabajo/Administracion/1 Uso Diario/Produccion.ods"'      
    else:
        ejecutalibre = 'soffice "/media/trabajo/Trabajo/Administracion/1 Uso Diario/Produccion.ods"'
    os.system(ejecutalibre)

def borra_pedido():
    txt.delete(1.0,END)
    path = "/media/trabajo/Trabajo/WEME/ASPEDI/PRODUCCION/ENTRADA/"
    pathpedido = path + 'pedidos/'
    ordendecompra = numero_pedido.get()
    if os.path.exists(pathpedido+ordendecompra+'.txt'):
        os.remove(pathpedido+ordendecompra+'.txt')
        txt.insert(INSERT,'El pedido fue borrado') 
    else:
        txt.insert(INSERT,'El pedido es Inexistente o esta la la Orden de Compra') 


def martin():
    txt.delete(1.0,END)
    txt.insert(INSERT,'Se Esta ejecutando la emision de remito y factura de Latin Chemical')
    os.system('bash /media/trabajo/Trabajo/scripts/remitoyfacturamartin.sh') 
    
def web_inc():
    txt.delete(1.0,END)
    txt.insert(INSERT,'Se Esta abriendo el navegador en la web de proveedores de Carrefour')
    os.system('python3 /media/trabajo/Trabajo/scripts/inc.py') 
    
def remitoyfactura():
    txt.delete(1.0,END)
    txt.insert(INSERT,'Se Esta ejecutando la emision de remito y factura de Inc')
    os.system('python3 /media/trabajo/Trabajo/scripts/haypedidos.py') 
    os.system('bash /media/trabajo/Trabajo/scripts/remitoyfactura.sh') 
    
def recepciones():
    txt.delete(1.0,END)
    txt.insert(INSERT,'Se Esta ejecutando la actualizacion de la planilla recepciones')
    os.system('bash /media/trabajo/Trabajo/scripts/recepciones.sh') 
    
def ingreso_pedido():
    txt.delete(1.0,END)
    txt.insert(INSERT,'Se Esta ejecutando el ingreso de los pedidos pendientes.')
    # os.system('bash /media/trabajo/Trabajo/scripts/ingreso_pedidos.sh')
    sub.call(['bash /media/trabajo/Trabajo/scripts/ingreso_pedidos.sh'], shell=True)
    txt.insert(INSERT,'\nHecho.')
    
def promedio_f():
    import csv
    txt.delete(1.0,END)
    txt.insert(INSERT,'Se Esta ejecutando la consulta...')
    # os.system('bash /media/trabajo/Trabajo/scripts/ingreso_pedidos.sh')
    calculopromedio()
    with open('/tmp/promedio.csv') as csv_file:
        txt.delete(1.0,END)
        csv_reader = csv.reader(csv_file, delimiter=',')
        for row in csv_reader:
            if not ('art_cod' in row):   #con esto saco la linea con las cabeceras de las consulta
                txt.insert(INSERT, row[1]+': '+row[2] + '\n')

def faltante_pedido():
    txt.delete(1.0,END)
    obtenerfaltantes()
    with open('/tmp/tiendas_sin_pedido.txt',"r") as file:
        faltantes = file.read()
        txt.insert(INSERT, faltantes)

#################################################################################################################

v_principal = tk.Tk()
v_principal.title("Panel de Comandos")
# v_principal.geometry('660x550')
v_principal.resizable(0, 0)
v_principal.update()
txt = scrolledtext.ScrolledText(v_principal)
txt.grid(column=1,row=4)
botonera = tk.Frame(v_principal)
botonera.grid(column=1, row=0, padx=5, pady=5)


pedidos = Button(botonera, text="Ver Pedidos", width=10, command=ver_pedidos)
pedidos.grid(column=1, row=0, padx=5, pady=5)

oculta_pedidos = Button(botonera, text="Limpiar Pantalla", width=10, command=oculta_pedido)
oculta_pedidos.grid(column=2, row=0, padx=5, pady=5)

martin = Button(botonera, text="Latin", width=10, command=martin)
martin.grid(column=3, row=0, padx=5, pady=5)

logistica = Button(botonera, text="Logistica", width=10, command=arma_reparto_xls)
logistica.grid(column=4, row=0, padx=5, pady=5)

etiquetas = Button(botonera, text="Etiquetas", width=10, command=etiquetas_xls)
etiquetas.grid(column=5, row=0, padx=5, pady=5)

cerrar = Button(botonera, text="Salir", width=10, command=close, bg="red")
cerrar.grid(column=6, row=0, padx=5, pady=5)

web_inc = Button(botonera, text="Web Inc", width=10, command=web_inc)
web_inc.grid(column=1, row=1, padx=5, pady=5)

remitoyfactura = Button(botonera, text="Facturacion", width=10, command=remitoyfactura)
remitoyfactura.grid(column=2, row=1, padx=5, pady=5)

recepciones = Button(botonera, text="Recepciones", width=10, command=recepciones)
recepciones.grid(column=3, row=1, padx=5, pady=5)

i_pedidos = Button(botonera, text="Ing. Pedidos", width=10, command=ingreso_pedido)
i_pedidos.grid(column=4, row=1, padx=5, pady=5)

promedio = Button(botonera, text="Promedio Prod.", width=10, command=promedio_f)
promedio.grid(column=5, row=1, padx=5, pady=5)

numero_pedido = Entry(botonera, width=12)
numero_pedido.grid(column=1, row=3, padx=5, pady=5) 

elimina_pedido = Button(botonera, text="Borrar Pedido", width=10, command=borra_pedido)
elimina_pedido.grid(column=2, row=3, padx=5, pady=5)

faltante_pedido = Button(botonera, text="Faltante Pedido", width=10, command=faltante_pedido)
faltante_pedido.grid(column=3, row=3, padx=5, pady=5)

v_principal.mainloop()
