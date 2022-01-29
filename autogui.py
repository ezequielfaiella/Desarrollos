#!/usr/bin/python3
# -*- coding: utf-8 -*-

""" requisitos
python3 -m pip install pyautogui
python3 -m pip install python3-xlib
sudo apt-get install scrot
sudo apt-get install python3-tk
sudo apt-get install python3-dev
"""

import pyautogui
import os
import time

# abre el sistema
# os.system('xed')
os.system('/usr/local/bin/weme &')
while True:
    window = pyautogui.getWindowsWithTitle("Ingreso Al Sistema")
    if window:
        window.set_foreground()
        break
pyautogui.hotkey('alt', 'F4')

'''
# time.sleep(5)
# Login
# Numero usuario login Point(x=779, y=539)
# Clave usuario login Point(x=778, y=568)
pyautogui.click()
pyautogui.moveTo(779, 539)
# pyautogui.click(779, 539)
pyautogui.click()
pyautogui.typewrite("02")
pyautogui.press("enter")
pyautogui.moveTo(779, 568)
pyautogui.click()
pyautogui.typewrite("eze")
pyautogui.press("enter")
'''