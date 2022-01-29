# !/usr/bin/python3

# python3 -m pip install PyPDF2 reportlab
# pyinstaller --onefile --add-data 'recibo_firma.jpg:.' --hiddenimport="textract.parsers.pdf_parser" sueldos.py      # crea el ejecutable con la imagen incorporada
# "textract.parsers.pdf_parser" agregar a hiddens en las spect de la compilacion de pyinstaller para que ande
# sys._MEIPASS    es la referencia al temporal donde se descomprime

import PyPDF2
from PyPDF2 import PdfFileReader, PdfFileWriter
import os
from reportlab.pdfgen import canvas
import reportlab.rl_settings
import textract.parsers.pdf_parser
from tkinter import Tk     # from tkinter import Tk for Python 3.x
from tkinter.filedialog import askopenfilename
from tkinter import simpledialog
from tkinter import messagebox
import sys
import textract
from itertools import islice
from time import sleep


def nth_index(iterable, value, n):
    matches = (idx for idx, val in enumerate(iterable) if val == value)
    return next(islice(matches, n-1, n), None)

# if getattr(sys, 'frozen', False):
#     self.dir = os.path.dirname(sys.executable)
# else:
#     self.dir = os.path.dirname(__file__)


###############################################################################


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

"""
Refer to an image if you want to add an image to a watermark.
Fill in text if you want to watermark with text.
Alternatively, following settings will skip this.picture_path = None
text = None
"""

picture_path = (sys._MEIPASS+"/recibo_firma.jpg")
# picture_path = "/media/trabajo/Trabajo/scripts/recibo_firma.jpg"

c = canvas.Canvas('watermark.pdf')
c.drawImage(picture_path, 100, 455, mask='auto')
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

#################################################################################
# with open(archivo+ "_1.pdf", "rb") as pdfFile:
#     reader = PyPDF2.PdfFileReader(pdfFile, strict=False)
#     # print(reader.numPages)

#     nombres = []

#     for hoja in range(reader.numPages):
#         page = reader.getPage(hoja)
#         content = page.extractText().split()
#         # print(content)
#         if "AVELLANEDA" in content:
#             posicion = content.index('AVELLANEDA')
#         else:
#             print("no se encontro el parametro para el periodo")
#             exit()
#         nombre = "_".join(content[33:35])
#         periodo = "_".join(content[posicion - 2:posicion])
#         # nombres.append(nombre)
        
#         writer = PdfFileWriter()
#         writer.addPage(reader.getPage(hoja))

#         with open( nombre + "_" + periodo +'.pdf', 'wb') as outfile:
#             writer.write(outfile)
#################################################################################
# sleep(5)
inputpdf = PdfFileReader(open(archivo+ "_1.pdf", "rb"), strict=False)
os.mkdir("temp")
for i in range(inputpdf.numPages):
    output = PdfFileWriter()
    output.addPage(inputpdf.getPage(i))
    with open('temp/'+"recibo%s.pdf" % i, "wb") as outputStream:
        output.write(outputStream)
for file in os.listdir('temp/'):
    if file.endswith(".pdf"):
        content = textract.process('temp/'+file)
        content = content.decode('UTF-8')
        # print('*'*50)
        content = list(content.split("\n"))
        if "Período" in content:
            posicion_mes = nth_index(content, 'Período', 2)
            periodo = content[posicion_mes+1]
        if "Documento" in content:
            posicion = nth_index(content, 'Documento', 2)
            nombre = content[posicion+2]
        if "acuerdo no rem" in content:
            # posicion = nth_index(content, 'Documento', 2)
            acuerdo = "_Acuerdo"
        else:
            acuerdo = ''
        
        os.renames('temp/'+file, nombre + "_" + periodo + acuerdo + '.pdf')        


#################################################################################
os.remove(output_path)
os.remove('watermark.pdf')


