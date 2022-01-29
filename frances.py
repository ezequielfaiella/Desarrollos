#!/usr/bin/phyton3
# coding: utf-8

# python3 -m pip install webdriver-manager

from selenium import webdriver
from webdriver_manager.firefox import GeckoDriverManager
# from selenium.webdriver.firefox.options import Options
# from selenium.webdriver import Firefox
from time import sleep
import os
from shutil import which
from modulos.mensajetelegram import enviomensajetelegram
# from modulos.logger_base import logger
import logging as logger
import platform


logger.basicConfig(level=logger.INFO,
                format='%(asctime)s: %(levelname)s [%(filename)s:%(lineno)s] %(message)s',
                datefmt='%Y%m%d-%I%M%S-%p',
                handlers=[
                    #    log en archivo
                    #    log en la terminal
                    logger.StreamHandler(),
                    #    logging.FileHandler(__file__+'.log'),
                    logger.FileHandler(__file__+'.log')
                ])

    
def bajadadedatos():
    # To prevent download dialog
    try:
        logger.info('Inicia el proceso')
        profile = webdriver.FirefoxProfile()
        # profile=Options()
        profile.set_preference('browser.download.folderList', 2) # custom location
        profile.set_preference('browser.download.manager.showWhenStarting', False)
        profile.set_preference('browser.download.dir', '/tmp')
        profile.set_preference('browser.helperApps.neverAsk.saveToDisk', "application/pdf, application/octet-stream, application/x-winzip, application/x-pdf, application/x-gzip, application/xls, text/csv, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/xhtml+xml, application/vnd.ms-excel, text/xml,application/x-excel, application/x-msexcel")

        if os.path.exists(str("/tmp/Movimientos.xls")): os.remove(str("/tmp/Movimientos.xls"))
        # browser = Firefox(options=profile)
        browser = webdriver.Firefox(profile,executable_path=GeckoDriverManager().install())
    except Exception as e:
        logger.info('NO Se creo el browser')
        print(e)
        
    try:
        logger.info('abre en navegador, para loguearse')
        #with webdriver.Firefox(profile) as browser:
        browser.get("https://www.bbva.com.ar/empresas.html")
        sleep(10)

        browser.find_element_by_xpath("//li[@class='header__actions__list header__actions--tablet-left']//span[@class='header__actions__item__link__text header__access__text--desktop'][normalize-space()='Net Cash']").click()
        sleep(10)

        cod_empresa = "xxxxxx"
        cod_usuario = "xxxxxxxx"
        password = "xxxxxxxx"
        #pasamos al frame de introduccion de datos
        marco = browser.find_element_by_xpath('//*[@id="iFrameResizer0"]')
        browser.switch_to.frame(marco)
        logger.info('cambio el frame')
        sleep(15)
    except: 
        enviomensajetelegram("1--Fallo actualizacion del libro de Banco")
        logger.error('no pudo abrir el navegador o cambiar al frame para tipear datos')
        browser.quit()
        quit()
    try:
        logger.info('tipea datos e inicia sesion')
        #hacemos el login
        browser.find_element_by_id("cod_emp").click()
        browser.find_element_by_id("cod_emp").send_keys(cod_empresa)
        browser.find_element_by_id("cod_usu").click()
        browser.find_element_by_id("cod_usu").send_keys(cod_usuario)
        browser.find_element_by_id("eai_password").click()
        browser.find_element_by_id("eai_password").send_keys(password)
        browser.find_element_by_id("btn_submit").click()
        sleep(20)

        # pasa a la principal y entra en cuentas, saldos
        logger.info('pasa a principal y entra en saldos y cuentas')
        browser.switch_to.default_content()
        browser.find_element_by_xpath('//*[@id="kyop-menuOption-1000003215-menuLeft"]').click()
        browser.find_element_by_xpath('//*[@id="kyop-opcionMenuHija_m_000000305H-menuLeft"]').click()
        sleep(10)

        # cambia al iframe del boton y lo descarga
        #//iframe[@id='kyop-central-load-area']
        try:
            logger.info('baja el archivo de movimientos')
            descarga = browser.find_element_by_xpath("//iframe[@id='kyop-central-load-area']") 
            browser.switch_to.frame(descarga)
            browser.find_element_by_xpath("//button[normalize-space()='Descargar']").click()

        #browser.switch_to.default_content()
        except:
        #opcion2
            logger.error('no pudo bajar el archivo de movimientos')
            browser.find_element_by_xpath("/html[1]/body[1]/div[1]/div[4]/div[1]/div[1]/button[1]").click()
        sleep(5)


        # pasa a la principal y entra en echeq
        logger.info('va por los echeq')
        browser.switch_to.default_content()
        browser.find_element_by_xpath('//*[@id="kyop-menuOption-1000003232-menuLeft"]').click()
        browser.find_element_by_xpath('//*[@id="kyop-opcionMenuHija_m_1000003233-menuLeft"]').click()
        sleep(10)

        try:
            logger.info('entra en seccion echeq')
            echeq_menu = browser.find_element_by_xpath("//iframe[@id='kyop-central-load-area']")
            browser.switch_to.frame(echeq_menu)
            # aceptados
            browser.find_element_by_xpath('//*[@class="redirect redirect-to-aceptados"]').click()
            try:
                logger.info('baja el archivo de echeq aceptados')
                browser.find_element_by_xpath("//a[normalize-space()='Aceptados']").click()
                sleep(5)
                browser.find_element_by_xpath("//span[normalize-space()='Descargar']").click()
            except:
                logger.error('no se bajo el archivo de aceptados')
                enviomensajetelegram("No hay cheques en 'ACEPTADOS'")
            # depositados
            try:
                logger.info('baja el archivo de echeq depositados')
                sleep(5)
                browser.find_element_by_xpath("//a[normalize-space()='Depositados']").click()
                sleep(5)
                browser.find_element_by_xpath("//span[normalize-space()='Descargar']").click()
            except:
                enviomensajetelegram("No hay cheques en 'DEPOSITADOS'")
                logger.error('no se bajo el archivo de depositados')
            
            browser.switch_to.default_content()
            sleep(5)
            browser.find_element_by_xpath('//*[@id="kyop-menuOption-1000003232-menuLeft"]').click()
            browser.find_element_by_xpath('//*[@id="kyop-opcionMenuHija_m_1000003234-menuLeft"]').click()
            sleep(5)

            #emitidos
            logger.info('baja el archivo de echeq emitidos')
            echeq_menu = browser.find_element_by_xpath("//iframe[@id='kyop-central-load-area']")
            sleep(5)
            browser.switch_to.frame(echeq_menu)
            browser.find_element_by_xpath("//a[normalize-space()='Emitidos']").click()
            sleep(5)
            browser.find_element_by_xpath("//span[normalize-space()='Descargar']").click()
            sleep(5)
            browser.find_element_by_xpath("//a[normalize-space()='Endosados']").click()
            sleep(5)
            browser.find_element_by_xpath("//span[normalize-space()='Descargar']").click()
            sleep(5)
            browser.find_element_by_xpath("//a[normalize-space()='Cesiones']").click()
            sleep(5)
            browser.find_element_by_xpath("//button[normalize-space()='Cedidos']").click()
            sleep(5)
            browser.find_element_by_xpath("//span[normalize-space()='Descargar']").click()

        except Exception as e:
            print(e)
            logger.error(f'no pudo entrar en seccion echeq - {e}')
            browser.find_element_by_xpath("/html[1]/body[1]/div[1]/div[4]/div[1]/div[1]/button[1]").click()

        browser.switch_to.default_content()
        logger.info("paso al frame principal y va a hacer click en salir")
        sleep(2)
        browser.find_element_by_xpath("//span[@id='kyop.ntcsh.header.exitNew']").click()
        sleep(5)
        browser.quit()
        sleep(15)
    except Exception as e:
        print(e) 
        e = ''.join(e)
        logger.error('no se pudo acceder a todos los comprobantes necesarios para actualizar el banco')
        mensaje2 = "2--Fallo actualizacion del libro de Banco - " + e
        enviomensajetelegram(mensaje2)
        browser.quit()
        quit()
        sleep(15)
    finally:
        browser.quit()


def linux():
    from modulos import extracto
    # os.system('DISPLAY=:0 gdialog --msgbox "Se inicia La actualizacion del libro de banco"')
    try:
        bajadadedatos()
    except:
        logger.error("fallo en la bajada de datos de la web del frances")
        exit()
    # ACTUALIZACION DE DATOS DEL EXCEL
    
    try:
        logger.info('empieza el proceso de actualizacion en el excel')

        ## SE EJECUTA LA MACRO DE LIBREOFFICE
        # office = which('soffice')
        # if office == None:
        #     ejecutamacro = 'libreoffice7.1 "/tmp/Movimientos.xls" "macro:///Ezequiel.Banco.Main"'      
        # else:
        #     ejecutamacro = 'soffice "/tmp/Movimientos.xls" "macro:///Ezequiel.Banco.Main"'
        # # ejecutamacro = 'soffice "/tmp/Movimientos.xls" "macro:///Ezequiel.Banco.Main"'
        # # ejecutamacro = 'libreoffice7.1 "/tmp/Movimientos.xls" "macro:///Ezequiel.Banco.Main"'
        # os.system(ejecutamacro)

        extracto.proceso()
        # enviomensajetelegram("Se actualizo el libro de Banco")

    except Exception as e:
        # print(e) 
        #'/tmp/banco.log'
        # with open("/tmp/banco.log", 'r') as file:
        #     log = file.readlines() 
        #     log = ''.join(log)
        logger.info('no se pudo actualizar el libro banco (fallo archivo extracto)')
        # enviomensajetelegram(log)
        mensajefinal = "Final--Fallo actualizacion del libro de Banco - " + str(e)
        # enviomensajetelegram(mensajefinal)
        
        # enviomensajetelegram(log)
        # for file in '/tmp/banco.log':
        #     if file:
        #         os.remove(file)
        quit()
    
def windows():
    logfile = os.path.join("C:", "Users", "Ezequiel", "AppData", "Local", "Temp", "banco.log")
    print(logfile)
    #exit()
    logger = logging
    logger.basicConfig(level=logging.INFO,
                    format='%(asctime)s: %(levelname)s [%(filename)s:%(lineno)s] %(message)s',
                    datefmt='%Y%m%d-%I%M%S-%p',
                    handlers=[
                        #    log en archivo
                        #    logging.FileHandler(__file__+'.log'),
                        logging.FileHandler(logfile),
                        #    log en la terminal
                        logging.StreamHandler()
                    ])
    # os.system('DISPLAY=:0 gdialog --msgbox "Se inicia La actualizacion del libro de banco"')


    # To prevent download dialog
    logger.info('Inicia el proceso')
    profile = webdriver.FirefoxProfile()
    profile.set_preference('browser.download.folderList', 2) # custom location
    profile.set_preference('browser.download.manager.showWhenStarting', False)
    profile.set_preference('browser.download.dir', '/tmp')
    profile.set_preference('browser.helperApps.neverAsk.saveToDisk', "application/pdf, application/octet-stream, application/x-winzip, application/x-pdf, application/x-gzip, application/xls, text/csv, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/xhtml+xml, application/vnd.ms-excel, text/xml,application/x-excel, application/x-msexcel")

    #if os.path.exists(str("/tmp/Movimientos.xls")): os.remove(str("/tmp/Movimientos.xls"))
    browser = webdriver.Firefox(profile)

    try:
        logger.info('abre en navegados, para loguearse')
        #with webdriver.Firefox(profile) as browser:
        browser.get("https://www.bbva.com.ar/empresas.html")
        sleep(10)

        browser.find_element_by_xpath("//li[@class='header__actions__list header__actions--tablet-left']//span[@class='header__actions__item__link__text header__access__text--desktop'][normalize-space()='Net Cash']").click()
        sleep(10)



        cod_empresa = "63854"
        cod_usuario = "efaiella"
        password = "auri1950"
        #pasamos al frame de introduccion de datos
        marco = browser.find_element_by_xpath('//*[@id="iFrameResizer0"]')
        browser.switch_to.frame(marco)
        logger.info('cambio el frame')
        sleep(15)
    except:
        enviomensajetelegram("1--Fallo actualizacion del libro de Banco")
        logger.error('no pudo abrir el navegador o cambiar al frame para tipear datos')
        quit()
    try:
        logger.info('tipea datos e inicia sesion')
        #hacemos el login
        browser.find_element_by_id("cod_emp").click()
        browser.find_element_by_id("cod_emp").send_keys(cod_empresa)
        browser.find_element_by_id("cod_usu").click()
        browser.find_element_by_id("cod_usu").send_keys(cod_usuario)
        browser.find_element_by_id("eai_password").click()
        browser.find_element_by_id("eai_password").send_keys(password)
        browser.find_element_by_id("btn_submit").click()
        sleep(20)

        # pasa a la principal y entra en cuentas, saldos
        logger.info('pasa a principal y entra en saldos y cuentas')
        browser.switch_to.default_content()
        browser.find_element_by_xpath('//*[@id="kyop-menuOption-1000003215-menuLeft"]').click()
        browser.find_element_by_xpath('//*[@id="kyop-opcionMenuHija_m_000000305H-menuLeft"]').click()
        sleep(10)

        # cambia al iframe del boton y lo descarga
        #//iframe[@id='kyop-central-load-area']
        try:
            logger.info('baja el archivo de movimientos')
            descarga = browser.find_element_by_xpath("//iframe[@id='kyop-central-load-area']")
            browser.switch_to.frame(descarga)
            browser.find_element_by_xpath("//button[normalize-space()='Descargar']").click()

        #browser.switch_to.default_content()
        except:
        #opcion2
            logger.error('no pudo bajar el archivo de movimientos')
            browser.find_element_by_xpath("/html[1]/body[1]/div[1]/div[4]/div[1]/div[1]/button[1]").click()
        sleep(5)


        # pasa a la principal y entra en echeq
        logger.info('va por los echeq')
        browser.switch_to.default_content()
        browser.find_element_by_xpath('//*[@id="kyop-menuOption-1000003232-menuLeft"]').click()
        browser.find_element_by_xpath('//*[@id="kyop-opcionMenuHija_m_1000003233-menuLeft"]').click()
        sleep(10)

        try:
            logger.info('entra en seccion echeq')
            echeq_menu = browser.find_element_by_xpath("//iframe[@id='kyop-central-load-area']")
            browser.switch_to.frame(echeq_menu)
            # aceptados
            browser.find_element_by_xpath('//*[@class="redirect redirect-to-aceptados"]').click()
            try:
                logger.info('baja el archivo de echeq aceptados')
                browser.find_element_by_xpath("//a[normalize-space()='Aceptados']").click()
                sleep(3)
                browser.find_element_by_xpath("//span[normalize-space()='Descargar']").click()
            except:
                logger.error('no se bajo el archivo de aceptados')
                enviomensajetelegram("No hay cheques en 'ACEPTADOS'")
            # depositados
            try:
                logger.info('baja el archivo de echeq depositados')
                sleep(3)
                browser.find_element_by_xpath("//a[normalize-space()='Depositados']").click()
                sleep(3)
                browser.find_element_by_xpath("//span[normalize-space()='Descargar']").click()
            except:
                enviomensajetelegram("No hay cheques en 'DEPOSITADOS'")
                logger.error('no se bajo el archivo de depositados')
            browser.switch_to.default_content()
            sleep(2)
            browser.find_element_by_xpath('//*[@id="kyop-menuOption-1000003232-menuLeft"]').click()
            browser.find_element_by_xpath('//*[@id="kyop-opcionMenuHija_m_1000003234-menuLeft"]').click()
            sleep(5)

            #emitidos
            logger.info('baja el archivo de echeq emitidos')
            echeq_menu = browser.find_element_by_xpath("//iframe[@id='kyop-central-load-area']")
            sleep(3)
            browser.switch_to.frame(echeq_menu)
            browser.find_element_by_xpath("//a[normalize-space()='Emitidos']").click()
            sleep(3)
            browser.find_element_by_xpath("//span[normalize-space()='Descargar']").click()

            # browser.find_element_by_xpath("//a[normalize-space()='Endosados']").click()
            # sleep(3)
            # browser.find_element_by_xpath("//span[normalize-space()='Descargar']").click()

        except Exception as e:
            print(e)
        #opcion2
            logger.error('no pudo entrar en seccion echeq')
            browser.find_element_by_xpath("/html[1]/body[1]/div[1]/div[4]/div[1]/div[1]/button[1]").click()

        browser.switch_to.default_content()
        logger.info("paso al frame principal y va a hacer click en salir")
        sleep(2)
        browser.find_element_by_xpath("//span[@id='kyop.ntcsh.header.exitNew']").click()
        sleep(5)
        browser.quit()
    except Exception as e:
        print(e)
        e = ''.join(e)
        logger.error('no se pudo acceder a todos los comprobantes necesarios para actualizar el banco')
        mensaje2 = "2--Fallo actualizacion del libro de Banco - " + e
        enviomensajetelegram(mensaje2)
        browser.quit()
        quit()
        sleep(2)

    # ACTUALIZACION DE DATOS DEL EXCEL

    try:
        logger.info('empieza el proceso de actualizacion en el excel')

        ## SE EJECUTA LA MACRO DE LIBREOFFICE
        # office = which('soffice')
        # if office == None:
        #     ejecutamacro = 'libreoffice7.1 "/tmp/Movimientos.xls" "macro:///Ezequiel.Banco.Main"'
        # else:
        #     ejecutamacro = 'soffice "/tmp/Movimientos.xls" "macro:///Ezequiel.Banco.Main"'
        # # ejecutamacro = 'soffice "/tmp/Movimientos.xls" "macro:///Ezequiel.Banco.Main"'
        # # ejecutamacro = 'libreoffice7.1 "/tmp/Movimientos.xls" "macro:///Ezequiel.Banco.Main"'
        # os.system(ejecutamacro)

        extracto.proceso()
        enviomensajetelegram("Se actualizo el libro de Banco")

    except Exception as e:
        # print(e)
        # '/tmp/banco.log'
        with open(logfile, 'r') as file:
            log = file.readlines()
            log = ''.join(log)
        logger.info('no se pudo actualizar el libro banco (fallo archivo extracto)')
        enviomensajetelegram(log)
        mensajefinal = "Final--Fallo actualizacion del libro de Banco - " + e
        enviomensajetelegram(mensajefinal)
        # enviomensajetelegram(log)
        for file in logfile:
            if file:
                os.remove(file)
        browser.quit()
        quit()


if __name__ == "__main__":
    sistema = platform.system()
    print(sistema)
    if sistema == "Linux":
        # print("usando linux")
        linux()
    if sistema == "Windows":
        windows()
