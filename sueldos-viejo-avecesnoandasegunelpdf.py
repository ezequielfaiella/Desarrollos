# !/usr/bin/python3

# python3 -m pip install PyPDF2 reportlab
# pyinstaller --onefile --add-data 'recibo_firma.jpg:.' sueldos.py                 # crea el ejecutable con la imagen incorporada
# sys._MEIPASS    es la referencia al temporal donde se descomprime

import PyPDF2
from PyPDF2 import PdfFileReader, PdfFileWriter
import os
from reportlab.pdfgen import canvas
from tkinter import Tk     # from tkinter import Tk for Python 3.x
from tkinter.filedialog import askopenfilename
from tkinter import simpledialog
from tkinter import messagebox
import pkgutil
import sys

# if getattr(sys, 'frozen', False):
#     self.dir = os.path.dirname(sys.executable)
# else:
#     self.dir = os.path.dirname(__file__)


Tk().withdraw() # we don't want a full GUI, so keep the root window from appearing
# show an "Open" dialog box and return the path to the selected file

filename = askopenfilename(title='Seleccione El Archivo', filetypes=[('pdf file', '*.pdf')])
# faltaimagen = messagebox.showerror(message="No Se Ha Encontrado La Imagen de Firma Para Incrustar.", title="Falta Imagen")

# print(filename)
if not filename:
    exit()

folder_path = os.path.split(filename)[0]
archivo = os.path.split(filename)[1][:-4]
# print(folder_path + " | " + archivo)


# periodo = simpledialog.askstring(title="Ingreso de Datos", prompt="Ingrese El Mes De los Recibos:")
# if not periodo:
#     exit()

os.chdir(folder_path)
# archivo = "Recibos_de_GRUPO WEME S.R.L_Agosto - 2020 Vacaciones"

"""
Refer to an image if you want to add an image to a watermark.
Fill in text if you want to watermark with text.
Alternatively, following settings will skip this.picture_path = None
text = None
"""

picture_path = (sys._MEIPASS+"/recibo_firma.jpg")
# picture_path = pkgutil.get_data("images",'/media/trabajo/Trabajo/scripts/recibo_firma.jpg')
print(picture_path)
text = None
# Folder in which PDF files will be watermarked. (Could be shared folder)
# folder_path = '/home/ezequiel/Nextcloud/Trabajo/Programacion/'
# folder_path = os.getcwd()
c = canvas.Canvas('watermark.pdf')
if picture_path:
    # if os.path.isfile(picture_path):
    c.drawImage(picture_path, 100, 455)    # primer valor horizontal, segundo valor vertical
    # else:
        # exit()
        # faltaimagen

if text:
    c.setFontSize(22)
    c.setFont('Helvetica-Bold', 36)
    c.drawString(15, 15,text)
c.save()

watermark = PdfFileReader(open("watermark.pdf", "rb"))
for file in os.listdir(folder_path):
    if file.endswith(archivo + ".pdf"):
        output_file = PdfFileWriter()
        input_file = PdfFileReader(open(folder_path + '/'+ file, "rb"))
        page_count = input_file.getNumPages()
        for page_number in range(page_count):
            input_page = input_file.getPage(page_number)
            input_page.mergePage(watermark.getPage(0))
            output_file.addPage(input_page)
            output_path = folder_path + '/'+ file.split('.pdf')[0] + '_1' + '.pdf'
            with open(output_path, "wb") as outputStream:
                output_file.write(outputStream)

################################################################################
with open(archivo+ "_1.pdf", "rb") as pdfFile:
    reader = PyPDF2.PdfFileReader(pdfFile)
    # print(reader.numPages)

    nombres = []

    for hoja in range(reader.numPages):
        page = reader.getPage(hoja)
        content = page.extractText().split()
        # print(content)
        if "AVELLANEDA" in content:
            posicion = content.index('AVELLANEDA')
        else:
            print("no se encontro el parametro para el periodo")
            exit()
        nombre = "_".join(content[33:35])
        periodo = "_".join(content[posicion - 2:posicion])
        # nombres.append(nombre)
        
        writer = PdfFileWriter()
        writer.addPage(reader.getPage(hoja))

        with open( nombre + "_" + periodo +'.pdf', 'wb') as outfile:
            writer.write(outfile)

#################################################################################
os.remove(output_path)
os.remove('watermark.pdf')


