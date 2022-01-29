#!/usr/bin/python3

"""
Basic example for a bot that uses inline keyboards.
requiere:
python3 -m pip install python-telegram-bot
python3 -m pip install pytz==2020.1

"""
from telegram.ext import Updater, CommandHandler
import os

TOKEN = "1294492723:AAF8GldAIw7zc-W0KSG3Xucz_qYhM4_RH74"



def start(update, context):
    user_dic = {
        'id': update.message.from_user.id,
        'first_name': update.message.from_user.first_name,
        'is_bot': update.message.from_user.is_bot,
        'last_name': update.message.from_user.last_name,
        'username': update.message.from_user.username,
        'language_code': update.message.from_user.language_code
    }

    saludos = f"""
        Hola, {user_dic["username"]}! Este es el Bot de Weme !
        Un Panel de Comandos Remoto que te permite hacer cosas
        de forma remota.
    """
    update.message.reply_text(saludos)


def ayuda(update, context):
    update.message.reply_text("""Comandos: 
                                        "start",
                                        "prende_eze"
                                        "prende_admin"
                                        "backupbsd"
                                        "backupnas"
                                        "ingresapedidos"
                                        "mitaddemes"
                                        "findemes"
                                        "gooddolar"
                                        "udemy"  
                                        "banco"
                                        "epic"
                                        "etiquetas"               
                              """)
    
def prende_eze(update, context):
    os.system('wakeonlan 2c:f0:5d:35:ff:75')
    update.message.reply_text("Mensaje Recibido")

def prende_admin(update, context):
    os.system('wakeonlan 20:cf:30:ad:9c:88')
    update.message.reply_text("Mensaje Recibido")

def backupbsd(update, context):
    os.system('bash /media/trabajo/Trabajo/scripts/backupbsd.sh')
    update.message.reply_text("Mensaje Recibido")
    
def backupnas(update, context):
    os.system('bash /media/trabajo/Trabajo/scripts/backupnas.sh')
    update.message.reply_text("Mensaje Recibido")
    
def ingresa_pedidos(update, context):
    os.system('export DISPLAY=:0.0 && bash /media/trabajo/Trabajo/scripts/ingreso_pedidos.sh')
    update.message.reply_text("Mensaje Recibido")
    
def mitaddemes(update, context):
    os.system('export DISPLAY=:0.0 && bash /media/trabajo/Trabajo/scripts/mitaddemes.sh')
    update.message.reply_text("Mensaje Recibido")
    
def findemes(update, context):
    os.system('export DISPLAY=:0.0 && bash /media/trabajo/Trabajo/scripts/findemes.sh')
    update.message.reply_text("Mensaje Recibido")
    
def good_dolar(update, context):
    os.system('export DISPLAY=:0.0 && python3 /home/ezequiel/trabajo/gooddolar.py')
    update.message.reply_text("Mensaje Recibido")
    
def udemy(update, context):
    os.system('/home/ezequiel/.pyenv/shims/python3 /media/trabajo/Trabajo/scripts/udemyfreebies.py')
    update.message.reply_text("Mensaje Recibido")
    
def banco(update, context):
    os.system('export DISPLAY=:0.0 && /home/ezequiel/.pyenv/shims/python3 /media/trabajo/Trabajo/scripts/frances.py')
    update.message.reply_text("Mensaje Recibido")
    
def epic(update, context):
    os.system('export DISPLAY=:0.0 && /home/ezequiel/.pyenv/shims/python3 /media/trabajo/Trabajo/scripts/epic.py')
    update.message.reply_text("Mensaje Recibido")

def etiquetas(update, context):
    os.system('export DISPLAY=:0.0 && VBoxManage startvm "Servicios"')
    update.message.reply_text("Mensaje Recibido")

def main():
    updater = Updater(TOKEN, use_context=True)

    updater.dispatcher.add_handler(CommandHandler("start", start))
    updater.dispatcher.add_handler(CommandHandler("prende_eze", prende_eze))
    updater.dispatcher.add_handler(CommandHandler("prende_admin", prende_admin))
    updater.dispatcher.add_handler(CommandHandler("backupbsd", backupbsd))
    updater.dispatcher.add_handler(CommandHandler("backupnas", backupnas))
    updater.dispatcher.add_handler(CommandHandler("ingresapedidos", ingresa_pedidos))
    updater.dispatcher.add_handler(CommandHandler("mitaddemes", mitaddemes))
    updater.dispatcher.add_handler(CommandHandler("findemes", findemes))
    updater.dispatcher.add_handler(CommandHandler("gooddolar", good_dolar))
    updater.dispatcher.add_handler(CommandHandler("udemy", udemy))
    updater.dispatcher.add_handler(CommandHandler("banco", banco))
    updater.dispatcher.add_handler(CommandHandler("epic", epic))
    updater.dispatcher.add_handler(CommandHandler("etiquetas", etiquetas))
    updater.dispatcher.add_handler(CommandHandler("ayuda", ayuda))

    # Start
    updater.start_polling()
    print("Estoy vivo")

    # Me quedo esperando
    updater.idle()


if __name__ == "__main__":
    main()


'''
start - inicia el bot
prende_eze - prende pc de ezequiel
prende_admin - prende pc de administracion
backupbsd - hace backup de las bases de datos
backupnas - hace el backup en el nas
ingresapedidos - ingresa los pedidos en el sistema
mitaddemes - envia los reportes al estudio de mitad de mes
findemes - envia los reportes al estudio de fin de mes
gooddolar - recibe los coins diarios
udemy - baja la lista de cursos gratis
banco - actualiza el libro banco
epic - compra los juegos gratis de epic
etiquetas - arranca la maquina virtual que controla impresora datamax
'''
