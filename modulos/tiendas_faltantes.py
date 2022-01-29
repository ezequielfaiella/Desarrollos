#!/usr/bin/python3
# -*- coding: utf-8 -*-
import os

# path = "/home/ezequiel/Nextcloud/curso_python/files/"
path = "/media/trabajo/Trabajo/WEME/ASPEDI/PRODUCCION/ENTRADA/"
pathpedido = path + 'pedidos/'

tiendas = ("0007","0010","0012","0020","0026","0049","0052","0056","0101","0115","0151","0203","0227","0231","0237","0258")
global faltantes
listadotiendas = []
faltantes=[]


def crealistapedidos():
                    # path = "/media/trabajo/Trabajo/WEME/ASPEDI/PRODUCCION/ENTRADA/"
                    with os.scandir(pathpedido) as ficheros:
                        for fichero in ficheros:
                            if fichero.name.startswith("0"):
                                if fichero.name.endswith(".txt"):
                                    listadotiendas.append(fichero.name[0:4] )
                    return listadotiendas

def obtenerfaltantes():
                    if os.path.exists('/tmp/tiendas_sin_pedido.txt'):
                        os.remove('/tmp/tiendas_sin_pedido.txt')
                        
                    crealistapedidos()

                    # faltantes=[]

                    for local in tiendas:
                        if local not in listadotiendas:
                            if local == "0927":
                                pass
                            faltantes.append(local)
                    with open('/tmp/tiendas_sin_pedido.txt', 'w') as salida:
                        salida.write("Faltante de Pedido: "+str(faltantes))
                    return faltantes                
                        
def enviarmensaje(destinatario,mensaje):
                    # comando = '~/tg/bin/telegram-cli -W -k ~/tg/server.pub -e "msg "'+str(destinatario)+" '"+str(mensaje)+"'"
                    # base = 
                    comando = f'~/tg/bin/telegram-cli -W -k ~/tg/server.pub "msg {destinatario} {mensaje}"'
                    os.system(comando)
                    
def enviarmensajefinal(destinatario,mensaje):
                    # comando = '~/tg/bin/telegram-cli -W -k ~/tg/server.pub -e "msg "'+str(destinatario)+" '"+str(mensaje)+"'"
                    # base = 
                    comando = f'sleep 1; /media/trabajo/Trabajo/scripts/modulos/tg/bin/telegram-cli -W -k ~/tg/server.pub -e "msg {destinatario} {mensaje}";sleep 1'
                    # comando = f'sleep 1; /usr/local/bin/telegram-cli -W -k ~/tg/server.pub -e "msg {destinatario} {mensaje}";sleep 1'
                    os.system(comando)

if __name__ == "__main__":
    pass
    # obtenerfaltantes()
    # print(faltantes)