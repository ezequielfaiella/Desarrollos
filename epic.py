#!/usr/bin/env python
# coding: utf-8

# In[1]:


# #!/usr/bin/phyton3
# -*- coding: utf
# 
# crea el ejecutable
# pyinstaller --onefile --add-binary '/usr/bin/chromedriver:./' gooddolar.py
# requisitos
# python3 -m pip install selenium
# sudo apt install chromium-chromedriver


# In[2]:


from selenium import webdriver
from time import sleep
import os
import random
from selenium.webdriver.chrome.options import Options
import sys
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.base import MIMEBase
from email import encoders
from modulos.logger_base import logger
# import logging
from selenium.webdriver.common.keys import Keys

from bs4 import BeautifulSoup
import requests
headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101 Firefox/68.0'}

# logger = logging
# logger.basicConfig(level=logging.INFO,
#                    format='%(asctime)s: %(levelname)s [%(filename)s:%(lineno)s] %(message)s',
#                    datefmt='%Y%m%d-%I%M%S-%p',
#                    handlers=[
#                        logging.FileHandler(__file__+'.log'),
#                        logging.StreamHandler()
#                    ])


# sudo apt-get install firefox-geckodriver<br>
# 

# In[3]:


os.system('killall chromium-browser')
os.system('killall chromium')
os.system('killall chromedriver')

username = 'xxxxxxxxxxx'
password = 'fxxxxx'


# In[4]:


url="https://www.epicgames.com/store/es-ES/free-games"


# In[5]:


def enviomensajetelegram(mensaje):
    # curl -s -X POST "https://api.telegram.org/bot802999301:AAFqDz2EMeyO0D8EtAP4AZkhfLuIGiqC3LQ/sendMessage" -d chat_id=11729976 -d text="prueba1"
    TOKEN="1482304462:AAHb90LEHoA5qiD9n0UUA_1s8AtEJTWS7U4"
    ID="11729976" # ezequiel
    URLT="https://api.telegram.org/bot"+TOKEN+"/sendMessage"
    
    comando = "curl -s -X POST "+URLT+" -d chat_id="+ID+" -d text="+mensaje
    
    os.system(comando)


# In[6]:


def enviofototelegram(archivo):
    # curl -X  POST "https://api.telegram.org/bot"<TOKEN>"/sendPhoto" -F chat_id="<ID>" -F photo="@<RUTA DE NUESTRA IMAGEN>"
    TOKEN="1482304462:AAHb90LEHoA5qiD9n0UUA_1s8AtEJTWS7U4"
    ID="11729976" # ezequiel
    URLT="https://api.telegram.org/bot"+TOKEN+"/sendPhoto"
    
    comando = "curl -X POST "+URLT+" -F chat_id="+ID+" -F photo=@"+archivo
    
    os.system(comando)


# In[7]:


# ejecutable=os.path.join(sys._MEIPASS+'/chromedriver')
# ejecutable=resource_path(os.path.dirname(os.path.abspath(__file__))) + '/chromedriver')
chrome_options = Options()
# chrome_options.add_argument("--headless")
chrome_options.add_argument('--no-sandbox')
chrome_options.add_argument('--disable-gpu')
# self.driver = webdriver.Chrome(executable_path=os.path.join(sys._MEIPASS+'/chromedriver'),options=chrome_options)
driver = webdriver.Chrome(executable_path='/usr/bin/chromedriver',options=chrome_options)
driver.get('https://stackoverflow.com/users/signup?ssrc=head&returnurl=%2fusers%2fstory%2fcurrent%27')
sleep(3)
driver.find_element_by_xpath('//*[@id="openid-buttons"]/button[1]').click()
driver.find_element_by_xpath('//input[@type="email"]').send_keys(username)
driver.find_element_by_xpath('//*[@id="identifierNext"]').click()
sleep(3)
driver.find_element_by_xpath('//input[@type="password"]').send_keys(password)
driver.find_element_by_xpath('//*[@id="passwordNext"]').click()
sleep(2)
page = driver.get(url)
logger.info('se va a la pagina de epicgames')


# In[8]:

logger.info('busca el boton para loguerse')
driver.find_element_by_xpath("//span[@class='sign-text item-label display-name text-color']").click()
sleep(5)


# In[9]:

logger.info('va a iniciar sesion con google')
driver.find_element_by_xpath('//span[normalize-space()="Iniciar sesión con Google"]').click()
sleep(15)


# In[10]:

logger.info('te dice cuantos juegos gratis hay')
encontrados = driver.find_elements_by_partial_link_text('Gratis ahora')#.click()
sleep(2)
print("Se encontraron",str(len(encontrados)),"juegos")
#print(links)
#print("link1",encontrados[0].text)
#print("link2",encontrados[1].text)


# In[20]:





# In[21]:





# In[11]:


for i in range(0,len(encontrados)):
    page = driver.get(url)
    sleep(5)
    logger.info('busca nuevamente cuantos juegos gratis hay para entrar en cada uno')
    encontrados = driver.find_elements_by_partial_link_text('Gratis ahora')#.click()
    logger.info('va haciendo click en el elemento i de los encontrados')
    encontrados[i].click()
    sleep(3)
    try:
        logger.info('si aparece algun mensaje de mayor de edad, creo')
        driver.find_element_by_xpath("//span[normalize-space()='Continuar']/ancestor::button").click()
    except:
        pass
    sleep(3)
    driver.find_element_by_xpath("//span[normalize-space()='Obtener']/ancestor::button").click()
    sleep(10)

    try:
        logger.info('si aparece algun mensaje de incompatible')
        driver.find_element_by_xpath("/html/body/div[5]/div/div/div/div/div[3]/div/button").click()
    except:
        pass
    try:
        logger.info('cambia al iframe de la compra')
        driver.switch_to.frame(driver.find_element_by_xpath("//div[@id='webPurchaseContainer']//iframe"))
        logger.info('empieza el proceso de compra')
        driver.find_element_by_xpath("//span[normalize-space()='Realizar pedido']").click()
    except:
        try:
            driver.find_element_by_xpath("//span[normalize-space()='Realizar compra']").click()
        except:
            logger.info('cambia al iframe de la compra')
            driver.switch_to.frame(driver.find_element_by_xpath("//div[@id='webPurchaseContainer']//iframe"))
            driver.find_element_by_xpath("//span[normalize-space()='Payment']").click()
            # driver.switch_to.default_content()

    finally:                
        sleep(15)
        driver.save_screenshot("/tmp/screenshot.png")
        enviofototelegram("/tmp/screenshot.png")
        os.system('rm /tmp/screenshot.png')


driver.close() 
driver.quit()
                
#    except:
        # print("ya lo tengo")
#        error = "Fallo al obtener el juego. Ya lo tengo."
#        enviomensajetelegram(error)
        #driver.close() 
        #exit()
#        sleep(15)


# In[ ]:


os.system('killall chromium-browser')
os.system('killall chromium')
os.system('killall chromedriver')

