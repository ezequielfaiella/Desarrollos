# !/usr/bin/python3
# -*- coding: utf-8 -*-

# requisito
# python3 -m pip install pandas odfpy openpyxl
# python3 -m pip install pandas_ods_reader no!!!!
# libreoffice --headless -convert-to csv:"Text - txt - csv (StarCalc)":59,34,76,,,,true --outdir converted BancoFrances.ods

import pandas as pd
import logger

# logging.basicConfig(filename="banco.log" level=logging.DEBUG format='%(asctime)s - %(levelname)s - %(message)s')
#logging.disable(logging.CRITICAL) """ si se comenta esta linea se activa el debug. se usa con logging.debug(o critical o info o el que sea)("mensaje que puede incluir 
#variables del programa usando %s y despues del texto %ylavariable )


# ubicacion del archivo a examinar
archivo_banco = '/media/trabajo/Trabajo/Administracion/1 Uso Diario/BancoFrances.xlsx'

# apertura del archivo. se omiten las primeras 4 filas que no sirven
df = pd.read_excel(archivo_banco, skiprows = 4, sheet_name="BANCO")

# aseguro que la columna fecha sea fecha
df['Fecha'] = pd.to_datetime(df['Fecha'])

# establezco los limites a filtrar
#FECHAS      MM-DD-AAAA

ano=2021
mes=8
ultimodia=31


start_date = f'{mes}-01-{ano}'
end_date = f'{mes}-{ultimodia}-{ano}'

# se hace la mascara para filtrar
mask = (df['Fecha'] >= start_date) & (df['Fecha'] <= end_date)

# aplico la mascara para filtrar al df abierto
df = df.loc[mask]

# filtro las columnas que necesito
df = df[["Fecha","Concepto","CATEGORIA","SUBCATEGORIA","Detalle","Crédito","Débito","Contabilizado"]]

#crea los grupos por categoria y subcategoria
df_final = pd.DataFrame(df.groupby(["CATEGORIA","SUBCATEGORIA"]).sum())

with pd.ExcelWriter(r'/media/trabajo/Trabajo/Administracion/Varios/DatosBalance/'+str(ano)+'-'+str(mes)+' - BancoFrances-ExtractoMensual.xlsx') as writer: 

# exporto al excel
    df.to_excel(writer, sheet_name=start_date, index = False)

#envia al archivo excel. el reset index agrega las columnas filtradas sino no sale
    df_final.reset_index().to_excel(writer, sheet_name="Analisis", index = False)

