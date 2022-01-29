#! /usr/bin/python3

import modulos.tiendas_faltantes , os
from time import sleep

# faltantes = []

modulos.tiendas_faltantes.obtenerfaltantes()

# encargados = {"0007":"Matias7","0012":"Matias12","0020":"Matias26","0026":"Matias26","0049":"Matias49","0052":"Matias52","0056":"Matias56","0101":"Matias101","0115":"Matias115","0151":"Matias151","0203":"Matias203","0227":"Matias227","0231":"Matias231","0237":"Matias237","0258":"Matias258"}
# encargados = {"0012":"Matias"}
encargados = {"0012":"Ezequiel","0115":"Ezequiel"}

# print(modulos.tiendas_faltantes.faltantes)


for tienda in modulos.tiendas_faltantes.faltantes: 
        print("------------------"+tienda+"-------------------")
        jefe_area=encargados.get(tienda)
        # print(jefe_area)
        if jefe_area != "None":
                mensaje_a_mandar = f"Buenos dias {jefe_area}, todavia no recibi el pedido de la tienda {tienda}. Necesitas mercaderia?"
                modulos.tiendas_faltantes.enviarmensajefinal(jefe_area,mensaje_a_mandar)
                sleep(2)
        else:
                print("tienda sin telefono de encargado")
        

