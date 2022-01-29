#!/usr/bin/python3

"""
Basic example for a bot that uses inline keyboards.
requiere:
python3 -m pip install python-telegram-bot
python3 -m pip install pytz==2020.1

"""

from telegram.ext import Updater
from telegram.ext import CommandHandler
import os

TOKEN = "802999301:AAFqDz2EMeyO0D8EtAP4AZkhfLuIGiqC3LQ"



def start(update, context):
    user_dic = {
        'id': update.message.from_user.id,
        'first_name': update.message.from_user.first_name,
        'is_bot': update.message.from_user.is_bot,
        'last_name': update.message.from_user.last_name,
        'username': update.message.from_user.username,
        'language_code': update.message.from_user.language_code
    }

    saludos = ''' Hola, %s ! Este es el Bot de Weme! 
    Un Panel de Comandos Remoto que te permite obtener 
    info de forma remota.''' %user_dic["username"]
    update.message.reply_text(saludos)


# def prende_eze(update, context):
#     os.system('wakeonlan 2c:f0:5d:35:ff:75')
#     update.message.reply_text("Mensaje Recibido")

# def prende_admin(update, context):
#     os.system('wakeonlan 20:cf:30:ad:9c:88')
#     update.message.reply_text("Mensaje Recibido")

def backupbsd(update, context):
    os.system('bash /media/trabajo/Trabajo/scripts/backupbsd.sh')
    update.message.reply_text("Mensaje Recibido")
    
def backupnas(update, context):
    os.system('bash /media/trabajo/Trabajo/scripts/backupnas.sh')
    update.message.reply_text("Mensaje Recibido")
    
def pedidos(update, context):
    update.message.reply_text("Mensaje Recibido")
    with open('/media/trabajo/Trabajo/scripts/informe.log','r') as informe:
        contenido = informe.read()
    update.message.reply_text(contenido)
             
def contenidopedidos(update, context):
    update.message.reply_text("Mensaje Recibido")
    # os.system('bash /media/trabajo/Trabajo/scripts/contenidopedidos.sh')
    with open('/media/trabajo/Trabajo/WEME/ASPEDI/PRODUCCION/ENTRADA/pedidos/resumen.txt','r') as informe:
        contenido = informe.read()
        update.message.reply_text(contenido)

def recibir(update, context):
    update.message.reply_text("Mensaje Recibido")
    os.system('bash /media/trabajo/Trabajo/scripts/recibir_de_ediwin_asp.sh')
    
def pagos(update, context):
    update.message.reply_text("Mensaje Recibido - Pagos")
    os.system('export DISPLAY=:0.0 && python3 /media/trabajo/Trabajo/scripts/pagos.py')

# NO IMPLEMENTADO
def paquetes(update, context):
    update.message.reply_text("Mensaje Recibido")
    #~ sh /media/trabajo/Trabajo/scripts/paquetes.sh "$(cat "$MESSAGE" | awk -F ' ' '{print $2 print $3}')"


def main():
    updater = Updater(TOKEN, use_context=True)

    updater.dispatcher.add_handler(CommandHandler("start", start))
    # updater.dispatcher.add_handler(CommandHandler("prende_eze", prende_eze))
    # updater.dispatcher.add_handler(CommandHandler("prende_admin", prende_admin))
    updater.dispatcher.add_handler(CommandHandler("backupbsd", backupbsd))
    updater.dispatcher.add_handler(CommandHandler("backupnas", backupnas))
    updater.dispatcher.add_handler(CommandHandler("pedidos", pedidos))
    updater.dispatcher.add_handler(CommandHandler("contenidopedidos", contenidopedidos))
    updater.dispatcher.add_handler(CommandHandler("recibir", recibir))
    updater.dispatcher.add_handler(CommandHandler("pago", pagos))

    # Start
    updater.start_polling()
    print("Estoy vivo")

    # Me quedo esperando
    updater.idle()


if __name__ == "__main__":
    main()
