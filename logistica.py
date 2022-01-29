#!/usr/bin/python3
# -*- coding: utf-8 -*-

#python3 -m pip install pyodbc openpyxl pandas dbf-to-sqlite

#sudo apt-get install unixodbc-dev libsqliteodbc unixodbc python3 build-essential


import pyodbc
import pandas as pd
import os
import datetime
import shutil
import dbf_to_sqlite
import tkinter as tk
from tkinter import simpledialog


if __name__ == '__main__':
    
    ## CUADRO DE DIALOGO QUE PIDE LA FECHA 
    ROOT = tk.Tk()
    ROOT.withdraw()
    # the input dialog
    fecha = simpledialog.askstring(title="Ingrese Los Datos Necesarios",
                                    prompt="Fecha en Formato AAAA/MM/DD:")
    # fecha = "2021/03/13"
    #fecha = input("ingrese la fecha a buscar en formato AAAA-MM-DD:\n")
    
    ## SE COPIAN LOS DBF AL DIRECTORIO TEMPORAL Y SE CONVIERTE A SQLITE CON DBF-TO-SQLITE
    ruta='/media/trabajo/Trabajo/WEME/'
    rutatemp='/tmp/'
    files=('sigaclie.fpt', 'sigaremi.cdx' , 'sigaclie.cdx' , 'sigaclie.dbf' , 'sigaremi.dbf')
    for file in files:
        shutil.copy(str(ruta + file),'/tmp/')
    creabasedato = 'for i in /tmp/*.dbf;do dbf-to-sqlite $i /tmp/pedido.db;done'
    os.system(creabasedato)
    
    ## SE ABRE LA BASE DE DATO, SE VERIFICA LA FECHA
    cnxn = pyodbc.connect("Driver={libsqlite3odbc.so};"
                                "Server=localhost;"
                                "Database=/tmp/pedido.db;"
                                "trusted_connection=yes;")


    #si esta formateada 2222/22/22
    if len(fecha) == 10 and fecha[4] == "/" and fecha[7] == "/":
        fecha = fecha[:4] + "-" + fecha[5:7] + "-" + fecha[8:]
    #si esta formateada 22222222
    elif len(fecha) == 8:
        fecha = fecha[:4] + "-" + fecha[4:6] + "-" + fecha[6:]
    #si esta vacia
    elif len(fecha) == 0:
        fecha = datetime.date.today() + datetime.timedelta(days=1)
    #si esta formateada 2222-22-22
    elif len(fecha) == 10 and fecha[4] == "-" and fecha[7] == "-":
        pass
    else:
        print("Formato de fecha no válida")
        exit()
    ## LA LINEA DE CONSULTA SE SQLITE
    script = '''SELECT sigaremi.codprov, sigaremi.nro_suc, sigaremi.tipodoc, sigaremi.suc_ent, sigaremi.nro_rem, sigaremi.fecha, sigaremi.art_cod, sigaremi.art_um, sigaremi.art_cant, sigaremi.art_desc, sigaclie.nom_fant, sigaremi.pre_uni, sigaremi.codisco 
    FROM sigaremi 
    INNER JOIN sigaclie ON sigaremi.codprov = sigaclie.codigo AND sigaremi.nro_suc = sigaclie.sucursal 
    WHERE sigaremi.tipodoc = "RC" AND sigaremi.fecha = ? AND sigaclie.nom_fant != "LATIN CHEMICAL SUPPLIERS S.A. "'''

    ## SE EJECUTA LA CONSULTA Y SE CREA EL ARCHOIVO XLS
    df = pd.read_sql(script, cnxn, params=(fecha,))
    writer = pd.ExcelWriter('/media/trabajo/Trabajo/WEME/exportacion/prod.xlsx')
    df.to_excel(writer, sheet_name ='pedidos',index=False)
    writer.save()

    ## SE BORRAN LOS ARCHIVOS DEL DIRECTORIO TEMPORAL
    for file in files:
            if os.path.exists(str(rutatemp + file)): os.remove(str(rutatemp + file))
    if os.path.exists(str(rutatemp + "pedido.db")): os.remove(str(rutatemp + "pedido.db"))

    ## SE EJECUTA LA MACRO DE LIBREOFFICE
    office = shutil.which('soffice')
    if office == None:
         ejecutamacro = 'libreoffice7.1 "/media/trabajo/Trabajo/Administracion/1 Uso Diario/Logistica.ods" "macro:///Logistica.PRODUCCION.Main"'      
    else:
        ejecutamacro = 'soffice "/media/trabajo/Trabajo/Administracion/1 Uso Diario/Logistica.ods" "macro:///Logistica.PRODUCCION.Main"'
    # ejecutamacro = 'soffice "/media/trabajo/Trabajo/Administracion/1 Uso Diario/Logistica.ods" "macro:///Logistica.PRODUCCION.Main"'
    os.system(ejecutamacro)