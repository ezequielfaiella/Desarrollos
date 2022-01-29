#!/usr/bin/python3

from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import Select
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

class Navegador():
    def __init__(self):
        check_process_status("chromedriver")
        check_process_status("chromium-browser")

        options = webdriver.ChromeOptions()
        # options.add_experimental_option("detach", True)   # para que no se cierre
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
        self.driver = webdriver.Chrome(executable_path='/usr/bin/chromedriver', options=options)
        script = '''
        Object.defineProperty(navigator, 'webdriver', {
            get: () => undefined
        })
        '''
        self.driver.execute_script(script)
        # return driver

    def login(self):

        url = "https://proveedores.cencosud.com/pcfr_web/index/"

        self.driver.get(url)

        self.driver.maximize_window()

        time.sleep(3)
        self.driver.find_element_by_name("formIndexPcfr:idRuc").send_keys("30711378355")
        self.driver.find_element_by_name("formIndexPcfr:idClave").send_keys("grup2021")
        time.sleep(2)
        self.driver.find_element_by_id("formIndexPcfr:btnEntrar").click()
        # return driver

    def reportes(self):
        # self.driver.find_element_by_class_name("fas fa-chart-pie btnHome").click()
        self.driver.get("https://proveedores.cencosud.com/pcfr_web/reportes/")

    def ingresados(self):
        # self.driver.find_element_by_class_name("fas fa-chart-pie btnHome").click()
        self.driver.get("https://proveedores.cencosud.com/pcfr_web/reporte-comprobantes-ingresados/")

    def recepciones(self):
        # self.driver.find_element_by_class_name("fas fa-chart-pie btnHome").click()
        self.driver.get("https://proveedores.cencosud.com/pcfr_web/reporte-recepciones-generales/")

    def ctacte(self):
        # self.driver.find_element_by_class_name("fas fa-chart-pie btnHome").click()
        self.driver.get("https://proveedores.cencosud.com/pcfr_web/reporte-cuenta-corriente/")

    def ingresofacturas(self):
        # self.driver.find_element_by_class_name("fas fa-chart-pie btnHome").click()
        self.driver.get("https://proveedores.cencosud.com/pcfr_web/ingreso-individual-arg/")
        # self.driver.find_element_by_id("formIngresoPcfr:selectRecep").click()
        select = Select(self.driver.find_element_by_id('formIngresoPcfr:selectRecep'))
        # select by visible text
        select.select_by_visible_text('Mercaderías Super')
        # select by value
        # select.select_by_value('f2c1da81-b100-49c4-820c-d3b7dd4e67f2')
        self.driver.find_element_by_class_name("fas fa-search icoInput").click()

    def listado_rece(self):
        select = Select(self.driver.find_element_by_id('formReporteFacturas:idSelectEstadoDocumentoR2'))
        select.select_by_visible_text('TODOS')
        self.driver.find_element_by_id('formReporteFacturas:j_idt42').click()
        time.sleep(10)
        self.driver.find_element_by_xpath('//*[@id="formReporteFacturas:tblFacturasBuscadasR2_paginator_bottom"]/a[5]').click()

if __name__ == '__main__':
    cenco = Navegador()
    cenco.login()
    time.sleep(5)
    cenco.ingresofacturas()
    # cenco.ctacte()
    # cenco.recepciones()
    # cenco.listado_rece()