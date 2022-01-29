#!/usr/bin/python3

from selenium import webdriver
# from selenium.webdriver.common.keys import Keys
# from selenium.webdriver.support.ui import Select
# from selenium.webdriver.support.select import Select
# ~ from selenium.webdriver.support.ui import WebDriverWait
# ~ from selenium.webdriver.support import expected_conditions as EC
# ~ from selenium.webdriver.common.by import By
import time
import os

url = "https://www.noip.com/login?ref_url=console#!/dynamic-dns"
####################################################################################
# start FIREFOX
# profile = webdriver.FirefoxProfile()
# driver = webdriver.Firefox(profile, service_log_path=os.devnull)
# driver.get(url)
# END FIREFOX
####################################################################################

options = webdriver.ChromeOptions()
options.add_argument("--headless")
options.add_argument('--disable-gpu')
options.add_argument('--no-sandbox')
options.add_argument("--disable-blink-features")
options.add_argument("--disable-blink-features=AutomationControlled")
options.add_experimental_option("excludeSwitches", ["enable-automation"])
options.add_experimental_option('useAutomationExtension', False)
options.add_experimental_option('prefs', {
    'credentials_enable_service': False,
    'profile': {
        'password_manager_enabled': False
    }
})
driver = webdriver.Chrome(executable_path='/media/trabajo/Trabajo/scripts/chromedriver', options=options)
script = '''
Object.defineProperty(navigator, 'webdriver', {
    get: () => undefined
})
'''
driver.execute_script(script)

driver.get(url)

# ~ driver.maximize_window()

u = driver.find_element_by_name("username")
u.send_keys("fayu666")
p = driver.find_element_by_name("password")
p.send_keys("30363864")
driver.find_element_by_name("Login").click()

time.sleep(5)

buttons = driver.find_elements_by_xpath('//button[normalize-space()="Confirm"]')

for btn in buttons:
    btn.click()
    time.sleep(1)

time.sleep(5)
driver.close()

#################################
# ACA EMPIEZA LA SEGUNDA CUENTA
#################################
time.sleep(10)


options = webdriver.ChromeOptions()
options.add_argument("--headless")
options.add_argument('--disable-gpu')
options.add_argument('--no-sandbox')
options.add_argument("--disable-blink-features")
options.add_argument("--disable-blink-features=AutomationControlled")
options.add_experimental_option("excludeSwitches", ["enable-automation"])
options.add_experimental_option('useAutomationExtension', False)
options.add_experimental_option('prefs', {
    'credentials_enable_service': False,
    'profile': {
        'password_manager_enabled': False
    }
})
driver = webdriver.Chrome(executable_path='/media/trabajo/Trabajo/scripts/chromedriver', options=options)
script = '''
Object.defineProperty(navigator, 'webdriver', {
    get: () => undefined
})
'''
driver.execute_script(script)

url = "https://www.noip.com/login?ref_url=console#!/dynamic-dns"
driver.get(url)

driver.execute_script(script)

#################################################################
# start FIREFOX
# profile = webdriver.FirefoxProfile()
# driver = webdriver.Firefox(profile, service_log_path=os.devnull)

# url = "https://www.noip.com/login?ref_url=console#!/dynamic-dns"
# driver.get(url)
# END FIREFOX
#################################################################

u = driver.find_element_by_name("username")
u.send_keys("ezequiel@panificadoradelsur.com.ar")
p = driver.find_element_by_name("password")
p.send_keys("30363864")
driver.find_element_by_name("Login").click()

time.sleep(5)

buttons = driver.find_elements_by_xpath('//button[normalize-space()="Confirm"]')

for btn in buttons:
    btn.click()
    time.sleep(1)

time.sleep(5)
driver.close()
driver.quit()