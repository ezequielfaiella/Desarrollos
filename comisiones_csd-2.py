# !/usr/bin/python3
# -*- coding: utf-8 -*-
# python3 -m pip install xlsxwriter, pandas, sqlite3, openpyxl                python3 -m pip install weasyprint
#  sudo apt-get install wkhtmltopdf
import sqlite3
import pandas as pd
from datetime import datetime, date
import locale
# import openpyxl

locale.setlocale(locale.LC_TIME, '')
# fecha = datetime.now().strftime("%A, %d de %B de %Y, %H:%M:%S")
fecha = datetime.now().strftime("%Y%m")

mes = pd.to_datetime("today").strftime("%Y%m")            #mes actual
mesanterior = int(pd.to_datetime("today").strftime("%Y%m"))-1          #mes anterior
mes = str(mes)
mes = mes[:4] + '-' + mes[4:]
# print(mes)

def obtencion_datos():
    # conexion = sqlite3.connect("/home/ezequiel/Yandex.Disk/Proyectos/wemeback.db")
    conexion = sqlite3.connect("/media/trabajo/Trabajo/wemeback.db")

    facturas_en_recibo = ''' select faccta.fecha, faccta.fcrcrefe, faccta.total, faccta.nro_rem
    from faccta
    where faccta.tipodoc = "**" and faccta.fecha >= "2013-06-05" and faccta.fcrcrefe not like "RT%" and faccta.fcrcrefe not like "CA%" and faccta.fcrcrefe not like "A-%" 
    and faccta.fcrcrefe not like "A+%" and faccta.fcrcrefe not like "      -        " and faccta.fcrcrefe not like "FA0001%" and faccta.fcrcrefe not like "DA"  and cod_clie = "000036"
    order by faccta.fecha '''

    facturas = ''' 
    select faccta.fecha, faccta.cod_clie, faccta.sucursal, faccta.tipodoc, faccta.rsocial,  ( faccta.tipodoc || faccta.sucdocum || "-" || faccta.nro_rem ) as referencia, faccta.sub_tot2, faccta.total
    from faccta
    where ( faccta.tipodoc = "FA" or faccta.tipodoc = "FE" or faccta.tipodoc = "FB" ) and cod_clie = "000036"
    order by faccta.fecha 
    '''

    creditos = '''
    select faccta.fecha, faccta.cod_clie, faccta.sucursal, faccta.tipodoc, faccta.rsocial, (faccta.tipodoc || faccta.sucdocum ||"-"|| faccta.nro_rem) as referencia, faccta.sub_tot2, faccta.total
    from faccta
    where ( faccta.tipodoc = "A-" or faccta.tipodoc = "CA" ) and faccta.cod_clie = "000036"
    order by faccta.fecha
    '''
    # ejecuito las 3 consultas
    facturas = pd.read_sql_query(facturas, conexion)
    recibos = pd.read_sql_query(facturas_en_recibo, conexion)
    nc = pd.read_sql_query(creditos, conexion)
    # cierro la conexion con la base de datos
    conexion.close()
        
    # unimos facturas y recibos
    # impagas_recibos = pd.merge(facturas, recibos, left_on='referencia', right_on='fcrcrefe', how='outer')
    # unimos al dataframe anterior las notas de credito
    
    #impagas_recibos_nc = pd.merge(impagas_recibos, nc, left_on='referencia', right_on='referencia', how='outer')
    # impagas_recibos_nc = pd.concat([impagas_recibos, nc], ignore_index=True)
    # impagas_recibos_nc = impagas_recibos.append(nc, ignore_index=True)
    
    unionfcync = facturas.append(nc)
    impagas_recibos_nc = pd.merge(unionfcync, recibos, left_on='referencia', right_on='fcrcrefe', how='outer')
    
    # llenamos lo que no tiene datos con 0
    impagas_recibos_nc = impagas_recibos_nc.fillna(0)
    #borramos los q tienen 0 por cliente (vacio)
    # df = df.drop(df[df['C']==True].index)     modelo de como eliminar por una condicion en la fila
    ## impagas_recibos_nc = impagas_recibos_nc.drop(impagas_recibos_nc[impagas_recibos_nc['cod_clie']==0].index)
    
    #hago la resta del total factura menos pago menos nota credito
    impagas_recibos_nc['saldo'] = impagas_recibos_nc['total_x'] - impagas_recibos_nc['total_y'] #- impagas_recibos_nc['total']
    # borro las que tienen saldo 0
    # impagas_recibos_nc = impagas_recibos_nc.drop(impagas_recibos_nc[impagas_recibos_nc['saldo']<=1].index)
    # impagas_recibos_nc = impagas_recibos_nc.drop(impagas_recibos_nc[impagas_recibos_nc['fecha']<="2019-05-01"].index)
    # renombro las columnas
    impagas_recibos_nc.rename(columns = {'referencia':'Factura', 'total_x':'Total_Factura','fcrcrefe_x':'Comprobante_en_Pago', 'total_y':'Total_en_Pago', 
                                        'fcrcrefe_y':'Nota_Credito','total':'Total_en_NC','saldo':'Saldo_Factura', 'fecha_x':"Fecha Factura", 
                                        'fecha_y':"Fecha Recibo", 'nro_rem':'Numero Orden Pago'}, inplace = True)
    # ordeno
    # impagas_recibos_nc = impagas_recibos_nc.sort_values(['cod_clie', 'fecha'], ascending=[True, True])

    # print(impagas_recibos_nc)
    # print(final)	
    
    
    ## a excel
    archivo = f"/media/trabajo/Trabajo/Administracion/Comiciones/{fecha}_CSD_Comisiones.xlsx"
    writer = pd.ExcelWriter(archivo, engine="xlsxwriter")
    impagas_recibos_nc.to_excel(writer,sheet_name="Facturas_CSD", index=False)
    # facturas.to_excel(writer,sheet_name="Facturas_CSD", index=False)
    # recibos.to_excel(writer,sheet_name="Recibos_CSD", index=False)
    # nc.to_excel(writer,sheet_name="Nc_CSD", index=False)
    writer.save()

def calculo_comisiones():
    archivo = f"/media/trabajo/Trabajo/Administracion/Comiciones/{fecha}_CSD_Comisiones.xlsx"
    actual = pd.read_excel(archivo)
    actual.dropna(how='all')
    #  test para comprar con archivo viejo
    archivo_anterior = f"/media/trabajo/Trabajo/Administracion/Comiciones/{mesanterior}_CSD_Comisiones.xlsx"
    anterior = pd.read_excel(archivo_anterior)
    anterior.dropna(how='all')
    #  termino carga archivos para comparar
    impagas_recibos_nc = pd.merge(actual, anterior, left_on='Factura', right_on='Factura', how='outer')
    # borro las boletas en 0
    impagas_recibos_nc = impagas_recibos_nc.drop(impagas_recibos_nc[impagas_recibos_nc['Saldo_Factura_y']==0].index)
    # impagas_recibos_nc = impagas_recibos_nc.drop(impagas_recibos_nc[impagas_recibos_nc['Saldo_Factura_x']!=0].index)
    # borro las columnas que contengan _y
    impagas_recibos_nc.drop(impagas_recibos_nc.filter(regex='_y$').columns.tolist(),axis=1, inplace=True)
    # borro el _x de las comlumnas que quedan
    impagas_recibos_nc.columns = impagas_recibos_nc.columns.str.replace(r'_x$', '', regex=True)
    impagas_recibos_nc.drop(['cod_clie','sucursal', 'Comprobante_en_Pago', 'Total_en_Pago', 'Nota_Credito', 
                             'Total_en_NC', 'Saldo_Factura'], axis=1, inplace=True)
    impagas_recibos_nc.rename(columns = {'sub_tot2':'Importe Sin Iva', 'rsocial':'Cliente'}, inplace = True)
    #  borro las fe que no tengan orden de pago
    impagas_recibos_nc = impagas_recibos_nc.drop(impagas_recibos_nc[(impagas_recibos_nc['tipodoc'] == 'FE') & (impagas_recibos_nc['Numero Orden Pago'] == 0)].index) 
    # filtro al mes anterior
    # impagas_recibos_nc = impagas_recibos_nc.drop(impagas_recibos_nc[impagas_recibos_nc['Fecha Factura']<=str(mes)].index)
    
    #  aca hago las cuentas para pasar las a- y las nc a negativo para que resten. 
    impagas_recibos_nc.loc[impagas_recibos_nc['Importe Sin Iva']==0, 'Importe Sin Iva'] = (impagas_recibos_nc['Total_Factura']/1.105).round(2)
    impagas_recibos_nc.loc[impagas_recibos_nc['tipodoc']=='A-', 'Importe Sin Iva'] = (impagas_recibos_nc['Importe Sin Iva']*-1.)
    impagas_recibos_nc.loc[impagas_recibos_nc['tipodoc']=='CA', 'Importe Sin Iva'] = (impagas_recibos_nc['Importe Sin Iva']*-1.)
    impagas_recibos_nc.loc[impagas_recibos_nc['tipodoc']=='A-', 'Total_Factura'] = impagas_recibos_nc['Total_Factura']*-1
    impagas_recibos_nc.loc[impagas_recibos_nc['tipodoc']=='CA', 'Total_Factura'] = impagas_recibos_nc['Total_Factura']*-1
    # borro las columnas que no borre aun para usarlas en pasar a negativo las facturas de cenco
    impagas_recibos_nc.drop(['tipodoc', 'fcrcrefe'], axis=1, inplace=True)    
    # calculo las comiciones
    impagas_recibos_nc['Comision'] = (impagas_recibos_nc['Importe Sin Iva'] * 3 / 100).round(2)
    #  totalizo las comisiones
    impagas_recibos_nc.loc['Total'] = impagas_recibos_nc[['Comision']].sum().reindex(impagas_recibos_nc.columns, fill_value='')
    # print(actual)
    # print(anterior)
    # print(impagas_recibos_nc)
    writer = pd.ExcelWriter(f"/media/trabajo/Trabajo/Administracion/Comiciones/{fecha}_CSD_Comisiones_Liquidacion.xlsx", engine="xlsxwriter")
    impagas_recibos_nc.to_excel(writer,sheet_name="Calculo Comisiones", index=False)
    writer.save()

def edito_excel():
    comiciones = f'/media/trabajo/Trabajo/Administracion/Comiciones/{fecha}_CSD_Comisiones.xlsx'
    librocomiciones = openpyxl.load_workbook(comiciones)


    librocomiciones.save(comiciones)

if __name__ == "__main__":
    obtencion_datos()
    calculo_comisiones()
    