#!/usr/bin/python3
# -*- coding: utf-8 -*-

# REQUISITO pip3 install
# apt-get install python-tk

import os
import csv
from tkinter import *
from tkinter import scrolledtext
from haypedidos import resumen

path = "/media/trabajo/Trabajo/WEME/ASPEDI/PRODUCCION/ENTRADA/"
pathpedido = path + 'pedidos/'
articulos = [7798329040588, 7798329040571, 7798329040274, 7798329040281, 7798329040137, 7798329040519, 7798329040526, 7798329040557, 2664178000002, 2664179000001, 7798329040564, 7798329040311, 7798329040304, 7798329040106, 7798329040328, 7798329040540, 7798329040502, 7798329040533, 7798329040083, 7798329040120, 7798329040335, 7798329040090, 7798329040342, 7798329040441]

def visualizador():
                window = Tk()
                window.title("Detalle De Pedidos")
                #window.geometry('607x300')
                window.resizable(0,0) # no deja agrandar o achicar la ventana
                resumen = open(pathpedido+'resumen.txt', 'r', encoding='utf-8')
                informe = resumen.read()
                txt = scrolledtext.ScrolledText(window)#,width=73,height=17)
                txt.insert(INSERT,informe)
                txt.grid(column=0,row=0)
                window.mainloop()
                if os.path.exists(pathpedido+'resumen.txt'):
                    os.remove(pathpedido+'resumen.txt')

if os.path.exists(pathpedido+'resumen.txt'):
    os.remove(pathpedido+'resumen.txt')
resumen()
visualizador()
