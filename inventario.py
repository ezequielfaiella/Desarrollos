#! /usr/bin/python3
#! -*- coding: utf-8 -*-

# python3 -m pip install dataframe_image

import sqlite3
from modulos.mensajetelegram import enviofototelegramweme
import dataframe_image as dfi
import pandas as pd
import os

# conexion = sqlite3.connect('/home/ezequiel/Stock.db', check_same_thread=False)
conexion = sqlite3.connect('/home/ezequiel/trabajo/Trabajo/Administracion/Stock.db', check_same_thread=False)
cursor = conexion.cursor()

listar_stock = '''select articulos.codigo, articulos.nombre, sum(movimientos.cantidad)
                    from articulos
                    INNER JOIN movimientos  on articulos.codigo = movimientos.codigo and articulos.unidad_medida = movimientos.unidad_medida
                    group by articulos.codigo
                    '''
# cursor.execute(listar_stock)
# stock_actual = cursor.fetchall()
df_mercaderia = pd.read_sql_query(listar_stock, conexion)


listar_stock2 = '''select articulos.codigo, articulos.nombre, materiaprima.cantidad, max(materiaprima.fecha_movimientos)
                    from articulos
                    INNER JOIN materiaprima  on articulos.codigo = materiaprima.codigo and articulos.unidad_medida = materiaprima.unidad_medida
                    group by articulos.codigo
                    '''
# cursor.execute(listar_stock2)
# mp_actual = cursor.fetchall()
df_mp = pd.read_sql_query(listar_stock2, conexion)

conexion.close()


dfi.export(df_mercaderia,"/tmp/mercaderia.png")
enviofototelegramweme("/tmp/mercaderia.png")
# print(df_mercaderia)
dfi.export(df_mp,"/tmp/materiaprima.png")
enviofototelegramweme("/tmp/materiaprima.png")
# print(df_mp)
os.remove("/tmp/mercaderia.png")
os.remove("/tmp/materiaprima.png")