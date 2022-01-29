#!/usr/bin/python3
# -*- coding: utf-8 -*-

# python3 -m pip install pyodbc openpyxl pandas dbf-to-sqlite

# sudo apt-get install unixodbc-dev libsqliteodbc unixodbc python3 build-essential


import pyodbc
import pandas as pd
import os
import datetime
import shutil
import dbf_to_sqlite
from datetime import date
from datetime import timedelta

global df

def calculopromedio():
    # SE COPIAN LOS DBF AL DIRECTORIO TEMPORAL Y SE CONVIERTE A SQLITE CON DBF-TO-SQLITE
    # ruta='/media/trabajo/Trabajo/WEME/'
    # rutatemp='/tmp/'
    # files=('sigaclie.fpt', 'sigaremi.cdx' , 'sigaclie.cdx' , 'sigaclie.dbf' , 'sigaremi.dbf')
    # for file in files:
    #     shutil.copy(str(ruta + file),'/tmp/')
    # creabasedato = 'for i in /tmp/*.dbf;do dbf-to-sqlite $i /tmp/pedido.db;done'
    # os.system(creabasedato)

    # SE ABRE LA BASE DE DATO, SE VERIFICA LA FECHA
    cnxn = pyodbc.connect("Driver={libsqlite3odbc.so};"
                            "Server=localhost;"
                            "Database=/media/trabajo/Trabajo/wemeback.db;"
                            "trusted_connection=yes;")

    # LA LINEA DE CONSULTA SE SQLITE

    script = '''SELECT sigaremi.codprov, sigaremi.nro_suc, sigaremi.tipodoc, sigaremi.suc_ent, sigaremi.nro_rem, sigaremi.fecha, sigaremi.art_cod, sigaremi.art_um, sigaremi.art_cant, sigaremi.art_desc, sigaclie.nom_fant, sigaremi.pre_uni, sigaremi.codisco 
    FROM sigaremi 
    INNER JOIN sigaclie ON sigaremi.codprov = sigaclie.codigo AND sigaremi.nro_suc = sigaclie.sucursal 
    WHERE sigaremi.tipodoc = "RC" AND sigaremi.fecha = ? AND sigaclie.nom_fant != "LATIN CHEMICAL SUPPLIERS S.A. " AND sigaremi.nro_suc != "927"'''

    # SE EJECUTA LA CONSULTA Y SE CREA EL ARCHIVO XLS

    # BUSCO LOS ULTIMOS SABADOS
    today = date.today()
    # 5 es en numero de dia que necesito
    offset = (today.weekday() - 5) % 7
    last_saturday = today - timedelta(days=offset)
    fecha1 = last_saturday
    fecha2 = last_saturday - timedelta(days=7)
    fecha3 = last_saturday - timedelta(days=14)
    fecha4 = last_saturday - timedelta(days=21)
    fecha5 = last_saturday - timedelta(days=28)
    # OBTENGO LOS DATOS DE CADA SEMANA
    df1 = pd.read_sql(script, cnxn, params=(fecha1,))
    print(df1)
    df2 = pd.read_sql(script, cnxn, params=(fecha2,))
    print(df2)
    df3 = pd.read_sql(script, cnxn, params=(fecha3,))
    print(df3)
    df4 = pd.read_sql(script, cnxn, params=(fecha4,))
    print(df4)
    df5 = pd.read_sql(script, cnxn, params=(fecha5,))
    print(df5)
    # SE UNEN LOS DATOS EN UNA SOLA TABLA
    df_pre = pd.concat([df1, df2, df3, df4, df5], axis=0)
    # SACO LAS COLUMNAS QUE NECESITO Y SUMO LA DE CANTIDADES
    df_sinpromedio = df_pre.groupby("art_cod", as_index=False).agg({'art_cod': 'first', 'art_desc': 'first', 'art_cant': 'sum'})
    # SACO EL PROMEDIO EN LAS 5 SEMANAS QUE TOMO EN REFERENCIA
    df = df_sinpromedio.apply(lambda x: (x/5) if x.name == 'art_cant' else x)

    # return print(df)
    # return df
    # print(df)

    # SE GUARDAN LOS DATOS EN UN EXCEL
    
    df.to_csv(r'/tmp/promedio.csv',index=False)
    

    # SE BORRAN LOS ARCHIVOS DEL DIRECTORIO TEMPORAL
    # for file in files:
    #         if os.path.exists(str(rutatemp + file)): os.remove(str(rutatemp + file))
    # if os.path.exists(str(rutatemp + "pedido.db")): os.remove(str(rutatemp + "pedido.db"))



if __name__ == '__main__':
    calculopromedio()

