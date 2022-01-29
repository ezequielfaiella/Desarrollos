#!/usr/bin/python3

from selenium import webdriver
from selenium.webdriver.common.keys import Keys
import time
import os
import inc

os.environ["DISPLAY"] = ':0.0'

def enviofotocontextotelegram(archivo,texto,chat):
    # curl -X  POST "https://api.telegram.org/bot"<TOKEN>"/sendPhoto" -F chat_id="<ID>" -F caption="<TEXTO JUNTO IMAGEN>" -F photo="@<RUTA DE NUESTRA IMAGEN>"
    TOKEN="802999301:AAFqDz2EMeyO0D8EtAP4AZkhfLuIGiqC3LQ"
    # ID="11729976" # ezequiel
    ID=str(chat)
    URLT="https://api.telegram.org/bot"+TOKEN+"/sendPhoto"
    
    comando = "curl -X POST "+URLT+" -F chat_id="+ID+" -F caption="+texto+" -F photo=@"+archivo
    
    os.system(comando)

driver = inc.driver

time.sleep(2)
driver.find_element_by_xpath('//div[@id="17_window_close"]').click()
driver.find_element_by_xpath('//span[contains(text(),"Consultas")]').click()
time.sleep(.05)
driver.find_element_by_xpath('//span[contains(text(),"Ordenes de pago")]').click()
time.sleep(3)
driver.find_element_by_xpath('//span[contains(text(),"Buscar")]').click()
time.sleep(5)
driver.save_screenshot("/tmp/screenshot.png")
driver.close()
enviofotocontextotelegram("/tmp/screenshot.png", 'Ordenes_de_pago_de_Inc', 11729976)
enviofotocontextotelegram("/tmp/screenshot.png", 'Ordenes_de_pago_de_Inc', 853056061)
enviofotocontextotelegram("/tmp/screenshot.png", 'Ordenes_de_pago_de_Inc', 849358586)
os.system('rm /tmp/screenshot.png')