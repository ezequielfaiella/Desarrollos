#!/usr/bin/phyton3
# coding: utf-8

from selenium import webdriver
from time import sleep
import os
from shutil import which
from modulos.mensajetelegram import enviomensajetelegram
import logging
import zipfile
from datetime import datetime, date
import locale

logger = logging
logger.basicConfig(level=logging.INFO,
                   format='%(asctime)s: %(levelname)s [%(filename)s:%(lineno)s] %(message)s',
                   datefmt='%Y%m%d-%I%M%S-%p',
                   handlers=[
                    #    log en archivo
                       logging.FileHandler(__file__+'.log'),
                    #    logging.FileHandler('/tmp/banco.log'),
                    #    log en la terminal
                       logging.StreamHandler()
                   ])
# os.system('DISPLAY=:0 gdialog --msgbox "Se inicia La actualizacion del libro de banco"')

locale.setlocale(locale.LC_TIME, '')
# fecha = datetime.now().strftime("%A, %d de %B de %Y, %H:%M:%S")
anio = datetime.now().strftime("%Y")
mes = datetime.now().strftime("%m")

# mes = "0"+mes           #mes actual

# To prevent download dialog
logger.info('Inicia el proceso')
profile = webdriver.FirefoxProfile()
profile.set_preference('browser.download.folderList', 2) # custom location
profile.set_preference('browser.download.manager.showWhenStarting', False)
profile.set_preference('browser.download.dir', '/home/ezequiel')
profile.set_preference('browser.helperApps.neverAsk.saveToDisk', "application/pdf, application/octet-stream, application/x-winzip, application/x-pdf, \
                        application/x-gzip, application/xls, text/csv, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, \
                        application/xhtml+xml, application/vnd.ms-excel, text/xml,application/x-excel, application/x-msexcel, application/zip, \
                        application/download, application/octet-stream, application/x-zip, application/x-zip-compressed, application/text, application/x-www-form-urlencoded")


def descarga():
    try:
        browser = webdriver.Firefox(profile)
        logger.info('abre en navegador, para loguearse')
        #with webdriver.Firefox(profile) as browser:
        browser.get("https://sso.arba.gov.ar/Login/login?service=http%3A%2F%2Fdfe.arba.gov.ar%2FDomicilioElectronico%2FdfeDescargarPadron.do%3Fdispatch%3DpreDescargar%26grupo%3D1")
        sleep(10)

        cuit = "xxxxxxxxx"
        password = "xxxxxx"
        #pasamos al frame de introduccion de datos
        # marco = browser.find_element_by_xpath('//*[@id="iFrameResizer0"]')
        # browser.switch_to.frame(marco)
        logger.info('tipeo los datos')
        browser.find_element_by_name("CUIT").click()
        browser.find_element_by_id("CUIT").send_keys(cuit)
        browser.find_element_by_name("clave_Cuit").click()
        browser.find_element_by_id("clave_Cuit").send_keys(password)
        sleep(2)
        logger.info('click en ingresar')
        browser.find_element_by_xpath("//button[@value='Ingresar']").click()
        logger.info('ingreso')
        sleep(3)
        logger.info('click en continuar')
        browser.find_element_by_xpath("//button[normalize-space()='Continuar']").click()
        logger.info('listado de archivos para descargar')
        sleep(3)
        logger.info('selecciono el primero')
        browser.find_element_by_xpath("/html/body/div/form/table/tbody/tr/td/table/tbody/tr[2]/td/table/tbody/tr[2]/td[5]/a").click()
        sleep(300)
        logger.info('cierro la sesion')
        # browser.find_element_by_xpath("//button[normalize-space()='Cerrar Sesión']").click()
        # sleep(3)
        browser.quit()
        logger.info('Descargado Padrón de ARBA')
        sleep(30)
        
    except: 
        enviomensajetelegram("Fallo actualizacion del padrón de ARBA")
        logger.error('Fallo Descarga Padrón de ARBA')
        exit()
        # browser.quit()

if __name__ == '__main__':
    if not os.path.exists(f'/home/ezequiel/PadronRGS{mes}{anio}.zip'):
        descarga()
    for root, dirs, files in os.walk("/home/ezequiel"):
        logger.info('recorro los que terminan en .zip, y de ahi los que cumplen con el nombre')
        for file in files:
            if file.endswith(".zip"):
                if file.startswith("PadronRGS"+mes+anio):
                    padron = os.path.join(root, file)
                    print(os.path.join(root, file))
                    logger.info('se encontro un archivo. se descomprime')
                    with zipfile.ZipFile(padron, 'r') as zip_ref:
                        zip_ref.extractall("/media/trabajo/Trabajo/WEME")
                    logger.info('se manda la orden al sistema para que los meta')
                    os.system("sh /media/trabajo/Trabajo/scripts/padron_arba.sh")
                    enviomensajetelegram('Se actualizo el padron de ARBA')

    quit()