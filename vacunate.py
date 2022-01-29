#!/usr/bin/phyton3
# coding: utf-8

#!/usr/env/phyton3
# -*- coding: utf
# 
# crea el ejecutable
# pyinstaller --onefile --add-binary '/usr/bin/chromedriver:./' gooddolar.py
# requisitos
# python3 -m pip install selenium
# sudo apt install chromium-chromedriver




from selenium import webdriver
from time import sleep
import os
from selenium.webdriver.chrome.options import Options
# import sys
from modulos import mensajetelegram

# os.environ["DISPLAY"] = ':0' 


url="https://sso.gba.gob.ar/web/login/SALUD"



# 
# os.system('killall chromedriver')
# os.system('killall chromium-browser')
# os.system('killall chromium')
# check_process_status("chromedriver")
# check_process_status("chromium-browser")


with open('/media/trabajo/Trabajo/scripts/Ezequiel', 'r') as datos:
    username = datos.readline().strip()
    password = datos.readline().strip()

# print(username, 'separador' ,password)

chrome_options = Options()
# chrome_options.add_argument("--headless")
# chrome_options.add_argument("--maximize-window")
chrome_options.add_argument('--no-sandbox')
chrome_options.add_argument('--disable-gpu')
driver = webdriver.Chrome(executable_path='/usr/bin/chromedriver',options=chrome_options)
driver.maximize_window()
driver.get(url)
sleep(3)
driver.find_element_by_xpath("//a[@id='btn_renaper']").click()
driver.find_element_by_xpath("//input[@id='dni']").send_keys(username)
sleep(3)
driver.find_element_by_xpath("//input[@id='nroTramite']").send_keys(password)
sleep(3)
driver.find_element_by_xpath("//button[normalize-space()='Masculino']").click()
sleep(5)
driver.find_element_by_xpath("//button[normalize-space()='Iniciá sesión']").click()
sleep(3)
driver.find_element_by_xpath("//button[normalize-space()='Aceptar']").click()
# driver.find_element_by_xpath("/html/body/div[2]/div/div[3]/button[3]").click()
sleep(3)

driver.find_element_by_xpath('//*[@id="slide-out"]/li[3]/a/span').click()
sleep(3)

driver.find_element_by_xpath('//*[@id="slide-out"]/li[3]/div/ul/li[2]/a').click()
sleep(2)
driver.save_screenshot("/tmp/screenshot.png")
mensajetelegram.enviofototelegram("/tmp/screenshot.png")
os.system('rm /tmp/screenshot.png')
driver.close() 

# check_process_status("chromedriver")
os.system('killall chromedriver')
os.system('killall chromium-browser')
os.system('killall chromium')
