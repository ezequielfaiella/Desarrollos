#!/usr/bin/python3

from modulos import gmail_sendmail
# from modulos import mail



'''     con modulo gmail '''
# # get the Gmail API service
# service = gmail_authenticate()
# # test send email
# send_message(service, "destination@domain.com", "This is a subject", 
#             "This is the body of the email", ["test.txt", "credentials.json"])

servicio = gmail_sendmail.gmail_authenticate()

# gmail_sendmail.send_message(servicio, "Ar_EDI_CP_MERCADERIA@carrefour.com", "FCE", f"Se adjunta/n los comprobantes de la/s ultima/s entregas con su correspondiente recepción para su contabilización.\nSaludos",
#                            ["/home/ezequiel/Música/FE000600000092.pdf"])

archivos = ["/home/ezequiel/Música/FE000600000233-027-003-O.pdf", "/home/ezequiel/Música/FA000300031927-027-003.pdf"]

try:
    # gmail_sendmail.send_message(servicio, "grupoweme@gmail.com","FCE Grupo Weme SRL",
    gmail_sendmail.send_message(servicio, "dia.ar.fcelectronica@diagroup.com", "FCE Grupo Weme SRL",
                                f"Buenos dias, adjuntamos facturas correspondientes a los remitos 0002-00041253 y 0002-00041254 correspondientes a las entregas del día 24/01/2022.\nSaludos",
                                archivos)
except Exception as e:
    print(e)
    print('fallo el envio del correo')
    
'''

try:
    mail.mailconadjunto("grupoweme@gmail.com","administracion@panificadoradelsur.com.ar", "FCE",
                                f"Se adjunta/n los comprobantes de la/s ultima/s entregas con su correspondiente recepción para su contabilización.\nSaludos",
                                "/home/ezequiel/Música/FE000600000226.pdf","FE000600000226.pdf")
except Exception as e:
    print(e)
    print('fallo el envio del correo')
    
'''