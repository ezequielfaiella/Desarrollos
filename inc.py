#!/usr/bin/python3

from selenium import webdriver
from selenium.webdriver.common.keys import Keys
# from selenium.webdriver.support.ui import Select
# from selenium.webdriver.support.select import Select
# from selenium.webdriver.common.desired_capabilities import DesiredCapabilities
import time
import os
import psutil

# REQUISITO
# sudo apt-get install chromium-chromedriver

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



check_process_status("chromedriver")
check_process_status("chromium-browser")

url = "https://prov.carrefour.com.ar/interaction/"

options = webdriver.ChromeOptions()
# options.add_argument("--headless")
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
driver = webdriver.Chrome(executable_path='/usr/bin/chromedriver', options=options)
script = '''
Object.defineProperty(navigator, 'webdriver', {
    get: () => undefined
})
'''
driver.execute_script(script)

driver.get(url)

driver.maximize_window()
# ~ driver.manage().window().fullscreen();

time.sleep(3)
driver.find_element_by_name("j_username").send_keys("30363864")
driver.find_element_by_name("j_password").send_keys("_20220103_Ezequiel")
time.sleep(2)
driver.find_element_by_name("j_password").send_keys(Keys.ENTER)

# driver.find_element_by_xpath('/html/body/div[1]/div[1]/div/div[3]/div/div[1]/form/div[6]/button').click()
