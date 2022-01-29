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
import random
from selenium.webdriver.chrome.options import Options
import sys
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.base import MIMEBase
from email import encoders
import psutil
# sys.path.insert(1,'/media/trabajo/Trabajo/scripts/modulos')
from modulos import mensajetelegram

os.environ["DISPLAY"] = ':0' 


url="https://wallet.gooddollar.org/AppNavigation/Dashboard/Claim?route=Home"




def check_process_status(process_name):
    """
    Return status of process based on process name.
    """
    process_status = [ proc for proc in psutil.process_iter() if proc.name() == process_name ]
    if process_status:
        for current_process in process_status:
            print("Process id is %s, name is %s, staus is %s"%(current_process.pid, current_process.name(), current_process.status()))
            os.system('kill -9 '+str(current_process.pid))
    else:
        pass
        #print("Process name not valid", process_name)


# 
os.system('killall chromedriver')
os.system('killall chromium-browser')
os.system('killall chromium')
# check_process_status("chromedriver")
# check_process_status("chromium-browser")




username = 'xxxxxxxx'
password = 'xxxxxx'



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
driver.get(url)
sleep(5)
#
# HASTA ACA EL SCRIPT ORIGINAL QUE SE LOGUEA A GOOGLE Y TE REDICRECCIONA
#


# self.driver.find_element_by_xpath('/html/body/div/div/div[1]/div/div/div/div/div/div/div[4]/div[2]/div/div/div/div/div/div').click()
# primer next
driver.find_element_by_xpath('//div[@class="css-901oao r-1awozwy r-cddv6f r-vnw8o6 r-1777fci r-njp1lv r-q4m81j r-3twk1y"]').click()

#segundo next
#driver.find_element_by_xpath('//div[@class="css-901oao r-1awozwy r-jwli3a r-vnw8o6 r-ubezar r-majxgm r-1777fci r-oxtfae r-hbpseb r-njp1lv r-q4m81j r-13wfysu r-tsynxw"]').click()

#tercer next
#driver.find_element_by_xpath('//div[@class="css-901oao r-1awozwy r-jwli3a r-vnw8o6 r-ubezar r-majxgm r-1777fci r-oxtfae r-hbpseb r-njp1lv r-q4m81j r-13wfysu r-tsynxw"]').click()




driver.find_element_by_xpath('//div[@class="css-901oao r-1awozwy r-cddv6f r-vnw8o6 r-1777fci r-njp1lv r-q4m81j r-1ddef8g r-3twk1y"]').click()
#driver.find_element_text('Already Have a Wallet? Log In >').click()
# guardo la ventana actual
# principal = driver.window_handles[0]
sleep(12)
# hago click en login con google
glogin = driver.find_element_by_xpath('//div[contains(text(),"Log in with Google")]')
# glogin = self.driver.find_element_by_xpath('/html/body/div/div/div[1]/div/div/div/div/div/div/div[4]/div[2]/div[2]')
# glogin = self.driver.find_element_by_text('Log in with Google')
# print(glogin.text)
glogin.click()
sleep(12)
    # guardo pantalla de login
    # login_google = driver.window_handles[1]
    # me paso a la pantalla de login
    # driver.switch_to.window(login_google)
    # sleep(2)
#selecciono perfil abierto
# self.driver.find_element_by_xpath('//*[@id="view_container"]/div/div/div[2]/div/div[1]/div/form/span/section/div/div/div/div/ul/li[1]/div/div[1]/div/div[2]/div[1]').click()
try:
    driver.find_element_by_xpath('//div[@id="profileIdentifier"]').click()
except:
    driver.find_element_by_xpath('//*[@id="view_container"]/div/div/div[2]/div/div[1]/div/form/span/section/div/div/div/div/ul/li[1]/div/div[1]/div/div[2]/div[2]').click()
sleep(2)
# driver.switch_to.window(principal)
sleep(50)



try:
    # self.driver.find_element_by_xpath('//*[@id="root"]/div/div[1]/div/div/div/div/div[2]/div/div/div[2]/div[3]/div/div[2]/div/div/div/div/div/div/div[1]').click()
    # self.driver.find_element_by_xpath('//div[@class="css-901oao r-1awozwy r-jwli3a r-vnw8o6 r-ubezar r-majxgm r-1777fci r-oxtfae r-hbpseb r-njp1lv r-q4m81j r-13wfysu r-tsynxw" or (normalized-text="Claim")]').click()
    # sleep(5)
    driver.find_element_by_xpath('//div[@class="css-1dbjc4n r-1awozwy r-6koalj r-13awgt0 r-18u37iz"]//div[@class="css-1dbjc4n"]').click()
    sleep(15)
            
except:
    error = "Fallo al obtener las monedas del dia."
    mensajetelegram.enviomensajetelegram(error)
    exit()
    
finally:    
    driver.save_screenshot("/tmp/screenshot.png")
    mensajetelegram.enviofototelegram("/tmp/screenshot.png")
    os.system('rm /tmp/screenshot.png')
    driver.close() 


    # check_process_status("chromedriver")
    os.system('killall chromedriver')
    os.system('killall chromium-browser')
    os.system('killall chromium')

