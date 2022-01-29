# !/usr/bin/python3
# -*- coding: utf-8 -*-
# python3 -m pip install xlsxwriter, pandas, sqlite3                python3 -m pip install weasyprint
#  sudo apt-get install wkhtmltopdf
import sqlite3
import pandas as pd
from datetime import datetime, date
import locale

locale.setlocale(locale.LC_TIME, '')
# fecha = datetime.now().strftime("%A, %d de %B de %Y, %H:%M:%S")
fecha = datetime.now().strftime("%Y%m")

mes = pd.to_datetime("today").strftime("%Y%m")            #mes actual
# print('primero',mes)
mesanterior = int(pd.to_datetime("today").strftime("%Y%m"))-1          #mes anterior
mes = str(mes)
# print('en string',mes[:2])

if mes[4:] == '01':
    mesanterior = str(int(pd.to_datetime("today").strftime("%Y"))-1)+'12'

mes = mes[:4] + '-' + mes[4:]

# fecha = 202202
# mesanterior = str('202202')

# print('anterior',mesanterior)
# exit()
def obtencion_datos():
    # conexion = sqlite3.connect("/home/ezequiel/Yandex.Disk/Proyectos/wemeback.db")
    conexion = sqlite3.connect("/media/trabajo/Trabajo/wemeback.db")

    facturas_en_recibo = ''' select faccta.fecha, faccta.fcrcrefe, faccta.total, faccta.nro_rem
    from faccta
    where faccta.tipodoc = "**" and faccta.fecha >= "2013-06-05" and faccta.fcrcrefe not like "RT%" and faccta.fcrcrefe not like "CA%" and faccta.fcrcrefe not like "A-%" 
    and faccta.fcrcrefe not like "A+%" and faccta.fcrcrefe not like "      -        " and faccta.fcrcrefe not like "FA0001%" and faccta.fcrcrefe not like "DA"  and cod_clie = "000027"
    order by faccta.fecha '''

    facturas = ''' select faccta.fecha, faccta.cod_clie, faccta.sucursal, faccta.tipodoc, faccta.rsocial,  ( faccta.tipodoc || faccta.sucdocum || "-" || faccta.nro_rem ) as referencia, faccta.sub_tot2, faccta.total
                from faccta
                where ( faccta.tipodoc = "FA" or faccta.tipodoc = "FE" or faccta.tipodoc = "FB" ) and cod_clie = "000027"
                order by faccta.fecha 
    '''

    creditos = '''
    select faccta.fecha as "Fecha Factura", faccta.sucdocum ||"-"|| faccta.nro_rem as Factura, faccta.total
    from faccta
    where ( faccta.tipodoc = "A-" or faccta.tipodoc = "CA" ) and faccta.cod_clie = "000027"
    order by faccta.fecha
    '''

    recibos_cargados = '''
    select faccta.fecha, faccta.fcrcrefe, faccta.total, faccta.nro_rem, faccta.fec_venc
    from faccta
    where faccta.tipodoc = "PC" and faccta.cod_clie = "000027" and faccta.total > "0.02"
    order by faccta.fecha    
    '''
    # ejecuito las 3 consultas
    facturas = pd.read_sql_query(facturas, conexion)
    recibos = pd.read_sql_query(facturas_en_recibo, conexion)
    nc = pd.read_sql_query(creditos, conexion)
    temporal_recibos = pd.read_sql_query(recibos_cargados, conexion)

    # cierro la conexion con la base de datos
    conexion.close()



    # unimos facturas y recibos
    impagas_recibos = pd.merge(facturas, recibos, left_on='referencia', right_on='fcrcrefe', how='outer')
    # unimos al dataframe anterior las notas de credito
    impagas_recibos_nc = pd.merge(impagas_recibos, nc, left_on='referencia', right_on='Factura', how='outer')
    # impagas_recibos_nc = pd.concat([impagas_recibos, nc])
    # llenamos lo que no tiene datos con 0
    impagas_recibos_nc = impagas_recibos_nc.fillna(0)
    #borramos los q tienen 0 por cliente (vacio)
    # df = df.drop(df[df['C']==True].index)     modelo de como eliminar por una condicion en la fila
    ##impagas_recibos_nc = impagas_recibos_nc.drop(impagas_recibos_nc[impagas_recibos_nc['cod_clie']==0].index)
    #hago la resta del total factura menos pago menos nota credito
    impagas_recibos_nc['saldo'] = impagas_recibos_nc['total_x'] - impagas_recibos_nc['total_y'] - impagas_recibos_nc['total']
    # borro las que tienen saldo 0
    # impagas_recibos_nc = impagas_recibos_nc.drop(impagas_recibos_nc[impagas_recibos_nc['saldo']<=1].index)
    # impagas_recibos_nc = impagas_recibos_nc.drop(impagas_recibos_nc[impagas_recibos_nc['fecha']<="2019-05-01"].index)
    # renombro las columnas
    impagas_recibos_nc.rename(columns = {'referencia':'Factura', 'total_x':'Total_Factura','fcrcrefe_x':'Comprobante_en_Pago', 'total_y':'Total_en_Pago', 
                                        'fcrcrefe_y':'Nota_Credito','total':'Total_en_NC','saldo':'Saldo_Factura', 'fecha_x':"Fecha Factura", 
                                        'fecha_y':"Fecha Recibo", 'nro_rem':'Numero Orden Pago', 'fec_venc':'Fecha del Cheque'}, inplace = True)

    impagas_recibos_nc = pd.merge(impagas_recibos_nc, temporal_recibos, left_on='Numero Orden Pago', right_on='nro_rem', how='inner')
    # ordeno
    # impagas_recibos_nc = impagas_recibos_nc.sort_values(['cod_clie', 'fecha'], ascending=[True, True])

    impagas_recibos_nc.drop(['nro_rem','total', 'fcrcrefe_y', 'fecha','Fecha Factura', 'Factura', 'Total_en_NC', 'Saldo_Factura', 'Total_en_Pago'], axis=1, inplace=True)
    impagas_recibos_nc.rename(columns = {'fec_venc':'Fecha del Cheque'}, inplace = True)

    ## a excel
    archivo = f"/media/trabajo/Trabajo/Administracion/Comiciones/{fecha}_DRA_Comisiones.xlsx"
    # archivo = f"{fecha}_DRA_Comisiones.xlsx"
    writer = pd.ExcelWriter(archivo, engine="xlsxwriter")
    impagas_recibos_nc.to_excel(writer,sheet_name="Facturas_DRA", index=False)
    # facturas.to_excel(writer,sheet_name="Facturas_Cencosud", index=False)
    # recibos.to_excel(writer,sheet_name="Recibos_Cencosud", index=False)
    # nc.to_excel(writer,sheet_name="Nc_Cencosud", index=False)
    writer.save()

def calculo_comisiones():
    archivo = f"/media/trabajo/Trabajo/Administracion/Comiciones/{fecha}_DRA_Comisiones.xlsx"
    # archivo = f"{fecha}_DRA_Comisiones.xlsx"
    actual = pd.read_excel(archivo)
    actual.dropna(how='all')
    #  test para comprar con archivo viejo

    actual.rename(columns = {'sub_tot2':'Importe Sin Iva', 'rsocial':'Cliente', 'fcrcrefe_x':'Factura'}, inplace = True)
    # convierto la columna a formato fecha
    actual['Fecha del Cheque'] = pd.to_datetime(actual['Fecha del Cheque'])
    # filtro al mes
    actual = actual[actual['Fecha del Cheque'].dt.month == int(mesanterior[5:])]
    # filtro al año
    actual = actual[actual['Fecha del Cheque'].dt.year == int(mesanterior[0:4])]

    # impagas_recibos_nc = impagas_recibos_nc.drop(impagas_recibos_nc[impagas_recibos_nc['Fecha Factura']<=str(mes)].index)
    # calculo las comiciones
    actual['Comision'] = (actual['Importe Sin Iva'] * 5 / 100).round(2)
    #  totalico las comisiones
    actual.loc['Total'] = actual[['Comision']].sum().reindex(actual.columns, fill_value='')
    # print(actual)
    # print(anterior)
    # print(impagas_recibos_nc)
    writer = pd.ExcelWriter(f"/media/trabajo/Trabajo/Administracion/Comiciones/{fecha}_DRA_Comisiones_Liquidacion.xlsx", engine="xlsxwriter")
    # writer = pd.ExcelWriter(f"{fecha}_DRA_Comisiones_Liquidacion.xlsx", engine="xlsxwriter")
    actual.to_excel(writer,sheet_name="Calculo Comisiones", index=False)
    writer.save()

if __name__ == "__main__":
    obtencion_datos()
    calculo_comisiones()
    
    