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

try:
    # gmail_sendmail.send_message(servicio, "grupoweme@gmail.com","FCE",
    gmail_sendmail.send_message(servicio, "Ar_EDI_CP_MERCADERIA@carrefour.com, tabatha_sarai_spinetta_abrameruk@carrefour.com, ariel_sanchez@carrefour.com", "FCE",
                                f"Se adjunta/n los comprobantes de la/s ultima/s entregas con su correspondiente recepción para su contabilización.\nSaludos",
                                # ["/home/ezequiel/Música/FE000600000169.pdf", "/home/ezequiel/Música/FE000600000170.pdf"])
                                ["/home/ezequiel/Música/FE000600000226.pdf"])
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