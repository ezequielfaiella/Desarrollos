# !/usr/bin/python3
# -*- coding: utf-8 -*-

import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.base import MIMEBase
# from email.MIMEBase import MIMEBase
from email import encoders

def load_file(file, file_name):
    read_file = open(file,'rb')
    attach = MIMEBase('multipart', 'encrypted')
    attach.set_payload(read_file.read())
    read_file.close()
    encoders.encode_base64(attach)
    attach.add_header('Content-Disposition', 'attachment', filename=file_name)
    return attach

def mailconadjunto(aquien, micorreo, asunto, mensaje, ubicaciondeladjunto, nombredeladjunto):
    smtp_server = 'smtp.gmail.com:587'
    smtp_user = 'administracion@panificadoradelsur.com.ar'
    smtp_pass = 'gratis123'
    email = MIMEMultipart()
    email['To'] = aquien
    email['From'] = micorreo
    email['Subject'] = asunto
    #email.attach(MIMEText('<p style="color:red;" >Envio Archivo adjunto desde python</p>','html'))
    email.attach(MIMEText(mensaje))
    #email.attach(load_file('/home/ezequiel/Nextcloud/Trabajo/google.jpeg','google.jpeg'))
    email.attach(load_file(ubicaciondeladjunto,nombredeladjunto))
    smtp = smtplib.SMTP(smtp_server)
    smtp.starttls()
    smtp.login(smtp_user,smtp_pass)
    smtp.sendmail(micorreo, aquien, email.as_string())
    smtp.quit()
    #print("E-mail enviado!")

# USO
#mailconadjunto('grupoweme@gmail.com','administracion@panificadoradelsur.com.ar', 'Imagen adjunta', 'este es un mensaje enviado desde una linea de texto', '/home/ezequiel/Nextcloud/Trabajo/google.jpeg', 'google.jpeg')
