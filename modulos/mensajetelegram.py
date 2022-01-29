#!/usr/bin/python3
# -*- coding: utf-8 -*-
import os

def enviomensajetelegram(mensaje):
    # curl -s -X POST "https://api.telegram.org/bot802999301:AAFqDz2EMeyO0D8EtAP4AZkhfLuIGiqC3LQ/sendMessage" -d chat_id=11729976 -d text="prueba1"
    TOKEN="1482304462:AAHb90LEHoA5qiD9n0UUA_1s8AtEJTWS7U4"
    ID="11729976" # ezequiel
    URLT="https://api.telegram.org/bot"+TOKEN+"/sendMessage"
    comando = "curl -s -X POST "+URLT+" -d chat_id="+ID+" -d text='"+mensaje+"'"
    os.system(comando)
    
def enviofototelegram(archivo):
    # curl -X  POST "https://api.telegram.org/bot"<TOKEN>"/sendPhoto" -F chat_id="<ID>" -F photo="@<RUTA DE NUESTRA IMAGEN>"
    TOKEN="1482304462:AAHb90LEHoA5qiD9n0UUA_1s8AtEJTWS7U4"
    ID="11729976" # ezequiel
    URLT="https://api.telegram.org/bot"+TOKEN+"/sendPhoto"
    
    comando = "curl -X POST "+URLT+" -F chat_id="+ID+" -F photo=@"+archivo
    
    os.system(comando)
    
def enviofototelegramweme(archivo):
    # curl -X  POST "https://api.telegram.org/bot"<TOKEN>"/sendPhoto" -F chat_id="<ID>" -F photo="@<RUTA DE NUESTRA IMAGEN>"
    TOKEN="802999301:AAFqDz2EMeyO0D8EtAP4AZkhfLuIGiqC3LQ"
    ID=["11729976","853056061","849358586"]
    URLT="https://api.telegram.org/bot"+TOKEN+"/sendPhoto"
    
    for cuenta in ID:
        comando = "curl -X POST "+URLT+" -F chat_id="+cuenta+" -F photo=@"+archivo
        os.system(comando)
    
def enviofotocontextotelegram(archivo,texto):
    # curl -X  POST "https://api.telegram.org/bot"<TOKEN>"/sendPhoto" -F chat_id="<ID>" -F caption="<TEXTO JUNTO IMAGEN>" -F photo="@<RUTA DE NUESTRA IMAGEN>"
    TOKEN="1482304462:AAHb90LEHoA5qiD9n0UUA_1s8AtEJTWS7U4"
    ID="11729976" # ezequiel
    URLT="https://api.telegram.org/bot"+TOKEN+"/sendPhoto"
    
    comando = "curl -X POST "+URLT+" -F chat_id="+ID+" -F caption='"+texto+"' -F photo=@"+archivo
    
    os.system(comando)
    
def envioarchivotelegram(archivo):
    # curl -X  POST "https://api.telegram.org/bot"<TOKEN>"/sendDocument" -F chat_id="<ID>" -F document="@<RUTA DEL ARCHIVO>"
    TOKEN="1482304462:AAHb90LEHoA5qiD9n0UUA_1s8AtEJTWS7U4"
    ID="11729976" # ezequiel
    URLT="https://api.telegram.org/bot"+TOKEN+"/sendDocument"
    
    comando = "curl -X POST "+URLT+" -F chat_id="+ID+" -F document=@"+archivo
    
    os.system(comando)
if __name__ == "__main__":
    pass
    
    # error = "Fallo al obtener el juego. Ya lo tengo."
    # enviomensajetelegram(error)

