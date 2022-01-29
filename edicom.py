#!/usr/bin/python3

from selenium import webdriver
from selenium.webdriver.common.keys import Keys
# from selenium.webdriver.support.ui import Select
# from selenium.webdriver.support.select import Select
import os
import time

url = "https://clients.edicomgroup.com/ediwin-asp-access.htm"

profile = webdriver.FirefoxProfile()
# ~ profile.set_preference("browser.download.folderList", 2)
# ~ profile.set_preference("browser.download.manager.showWhenStarting", False)
# ~ profile.set_preference("browser.download.dir", '/home/ezequiel/Escritorio/')
# ~ profile.set_preference("browser.helperApps.neverAsk.saveToDisk", "application/x-gzip")
# ~ profile.set_preference("browser.search.widget.inNavBar", False)
# ~ profile.set_preference("dom.webnotifications.enabled", False)

driver = webdriver.Firefox(profile, service_log_path=os.devnull)

driver.get(url)
# ~ driver.maximize_window()
# ~ driver.manage().window().fullscreen();


driver.find_element_by_name("usuario").send_keys("30711378355")
driver.find_element_by_name("password").send_keys("qvfdexldm")
driver.find_element_by_name("dominio").send_keys("30711378355")

driver.find_element_by_xpath('/html/body/div[2]/div/main/div/div/div[1]/form/div[2]/button').click()

