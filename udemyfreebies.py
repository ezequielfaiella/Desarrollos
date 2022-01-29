#!/usr/bin/python3
# -*- coding: utf-8 -*-

###### requisitos
# python3 -m pip install praw pandas BeautifulSoul4 


import praw
import pandas as pd
import datetime as dt
import os
from bs4 import BeautifulSoup
import requests, re, time
from selenium import webdriver
from selenium.webdriver.chrome.options import Options



#### DECORADOR QUE LIMITA TIEMPO DE FUNCIONAMIENTO
import signal
link = ''

registros=300

class TimedOutExc(Exception):
    pass

def deadline(timeout, *args):
    def decorate(f):
        def handler(signum, frame):
            # raise break
            raise TimedOutExc()

        def new_f(*args):
            signal.signal(signal.SIGALRM, handler)
            signal.alarm(timeout)
            return f(*args)
            signal.alarm(0)

        new_f.__name__ = f.__name__
        return new_f
    return decorate
#### SE USA= @deadline(15)


def enviomensajetelegram(mensaje):
    # curl -s -X POST "https://api.telegram.org/bot802999301:AAFqDz2EMeyO0D8EtAP4AZkhfLuIGiqC3LQ/sendMessage" -d chat_id=11729976 -d text="prueba1"
    TOKEN="1482304462:AAHb90LEHoA5qiD9n0UUA_1s8AtEJTWS7U4"
    ID="11729976" # ezequiel
    URLT="https://api.telegram.org/bot"+TOKEN+"/sendMessage"
    
    comando = "curl -s -X POST "+URLT+" -d chat_id="+ID+" -d text="+mensaje
    
    os.system(comando)
    
def envioarchivotelegram(archivo):
    # curl -X  POST "https://api.telegram.org/bot"<TOKEN>"/sendDocument" -F chat_id="<ID>" -F document="@<RUTA DEL ARCHIVO>"
    TOKEN="1482304462:AAHb90LEHoA5qiD9n0UUA_1s8AtEJTWS7U4"
    ID="11729976" # ezequiel
    URLT="https://api.telegram.org/bot"+TOKEN+"/sendDocument"
    
    comando = "curl -X POST "+URLT+" -F chat_id="+ID+" -F document=@"+archivo
    
    os.system(comando)

def edutreasure(url):
    try:
        page = requests.get(url, headers).text
        soup = BeautifulSoup(page, 'html.parser')
        link = soup.find('a', class_='enroll').attrs['href']
        lista.insert(n_orden,link)
        lista.pop(n_orden+1)
    except:
        pass
        # link = url
    # return link

def freewebcart(url):
    try:
        chrome_options = Options()
        chrome_options.add_argument("--headless")
        chrome_options.add_argument('--no-sandbox')
        chrome_options.add_argument('--disable-gpu')
        driver = webdriver.Chrome(executable_path='/usr/bin/chromedriver',options=chrome_options)
        driver.get(url)
        link = driver.find_element_by_xpath('//*[@id="main"]/div/div[3]/div/div[2]/div[1]/div/div[3]/div/a').get_attribute('href')
        # print(link)
        driver.close()
        lista.insert(n_orden,link)
        lista.pop(n_orden+1)
    except:
        pass
    #     link = url
    # return link

# @deadline(25)
def idownloadcoupon(url):
    try:
        chrome_options = Options()
        chrome_options.add_argument("--headless")
        chrome_options.add_argument('--no-sandbox')
        chrome_options.add_argument('--disable-gpu')
        driver = webdriver.Chrome(executable_path='/usr/bin/chromedriver',options=chrome_options)
        driver.get(url)
        time.sleep(3)
        try: 
            link = driver.find_element_by_link_text('Enroll Now').get_attribute('href')
            link = link.split("murl=")[1]
            link = link.replace("%3A%2F%2F", "://")
            link = link.replace("%2F", "/")
            link = link.replace("%3F", "?")
            link = link.replace("%3", "=")
            # print(link)
            lista.insert(n_orden,link)
            lista.pop(n_orden+1)
            driver.close()
        except:
            try: 
                link = driver.find_element_by_link_text('Take Course').get_attribute('href')
                link = link.split("murl=")[1]
                link = link.replace("%3A%2F%2F", "://")
                link = link.replace("%2F", "/")
                link = link.replace("%3F", "?")
                link = link.replace("%3", "=")
                # print(link)
                lista.insert(n_orden, link)
                lista.pop(n_orden + 1)
                driver.close()
            except:
                try: 
                    page = requests.get(url, headers).text
                    soup = BeautifulSoup(page, 'html.parser')
                    link = soup.find('a', class_='re_track_btn btn_offer_block').attrs['href']
                    lista.insert(n_orden, link)
                    lista.pop(n_orden + 1)
                except:
                    pass
                    # link = url
        ##
            # print(link)
            # lista.insert(n_orden,link)
            # lista.pop(n_orden+1)
    except:
        pass
    # print(link)
    # return link

def couponbro(url):
    try:
        page = requests.get(url, headers).text
        soup = BeautifulSoup(page, 'html.parser')
        link = soup.find('a', class_='btn btn-success').attrs['href']
        lista.insert(n_orden,link)
        lista.pop(n_orden+1)
    except:
        pass
        # link = url
    # return link

# @deadline(25)
def real(url):
    try:
        chrome_options = Options()
        chrome_options.add_argument("--headless")
        chrome_options.add_argument('--no-sandbox')
        chrome_options.add_argument('--disable-gpu')
        driver = webdriver.Chrome(executable_path='/usr/bin/chromedriver',options=chrome_options)
        driver.get(url)
        time.sleep(3)
        # link = driver.find_element_by_xpath('//*[@id="product-49693"]/div/div[2]/div[2]/div/div[3]/div[1]/div/a').get_attribute('href')
        # link = driver.find_element_by_xpath('//a[contains(@href, "couponCode")]').get_attribute('href')
        link = driver.find_element_by_partial_link_text('couponCode').get_attribute('href')
        lista.insert(n_orden,link)
        lista.pop(n_orden+1)
        # print(link)
        driver.close()
    except:
        try:
            link = driver.find_element_by_xpath('/html/body/div[2]/div[3]/div/div/div/div/main/div[2]/div/div[2]/div[2]/div/div[3]/div[1]/div/a').get_attribute('href')
            driver.close()
            lista.insert(n_orden,link)
            lista.pop(n_orden+1)
            # print(link)
        except:
            try:
                link = driver.find_element_by_link_text('Take Course').get_attribute('href')
                driver.close()
                # print(link)
                lista.insert(n_orden,link)
                lista.pop(n_orden+1)
            except:
                # link = url
                pass
    # print(link)
    # return link
# @deadline(15)  
def offdeal(url):
    try:
        # chrome_options = Options()
        # chrome_options.add_argument("--headless")
        # chrome_options.add_argument('--no-sandbox')
        # chrome_options.add_argument('--disable-gpu')
        # # self.driver = webdriver.Chrome(executable_path=os.path.join(sys._MEIPASS+'/chromedriver'),options=chrome_options)
        # driver = webdriver.Chrome(executable_path='/usr/bin/chromedriver',options=chrome_options)
        # driver.get(url)
        # time.sleep(3)
        # link = driver.find_element_by_xpath('/html/body/div[1]/div[1]/div/div/div/main/div[2]/div[2]/div[4]/div/div/div/div/div[3]/span/span/a').get_attribute('href')
        # # print(link)
        # driver.close()
        page = requests.get(url, headers).text
        soup = BeautifulSoup(page, 'html.parser')
        link = soup.find('a', class_='maxbutton-1 maxbutton maxbutton-get-this-free-course').attrs['href']
        lista.insert(n_orden,link)
        lista.pop(n_orden+1)
    except:
        pass
        # link = url
    # return link

def myfreeonlinecourses(url):
    try:
        page = requests.get(url).text
        soup = BeautifulSoup(page, 'html.parser')
        previo = soup.find('span', {'style':'font-size: x-large;'})
        link = previo.find('a').attrs['href']
        lista.insert(n_orden,link)
        lista.pop(n_orden+1)
    except:
        pass
        # link = url
    # return link

def training(url):
    try:
        page = requests.get(url, headers).text
        soup = BeautifulSoup(page, 'html.parser')
        link = soup.find("a", href=re.compile("https:\/\/www.udemy.com\/course")).attrs['href']
        lista.insert(n_orden,link)
        lista.pop(n_orden+1)
    except:
        pass
        # link = url
    # return link 
# @deadline(25)   
def realfreecoupons(url):
    try:
        page = requests.get(url, headers).text
        soup = BeautifulSoup(page, 'html.parser')
        link = soup.find('a', class_='btn_offer_block re_track_btn').attrs['href']
        lista.insert(n_orden,link)
        lista.pop(n_orden+1)
    except:
        pass
    #     link = url
    # print(link)
    # return link


headers = {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'GET',
    'Access-Control-Allow-Headers': 'Content-Type',
    'Access-Control-Max-Age': '3600',
    'User-Agent': 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:52.0) Gecko/20100101 Firefox/52.0'
    }

reddit = praw.Reddit(client_id='AhVl8R8LK3PEEg', \
                     client_secret='T7OFMVoqcu9h1_P82fx6VQxGbAKWkQ', \
                     user_agent='scrap', \
                     username='fayu666', \
                     password='celu40876748')

subreddit = reddit.subreddit('udemyfreebies')

new_subreddit = subreddit.new(limit=int(registros))

# for submission in subreddit.new(limit=1):
#     print(submission.title, submission.id)
    
# topics_dict = { "title":[], \
#                 "score":[], \
#                 "id":[], "url":[], \
#                 "comms_num": [], \
#                 "created": [], \
#                 "body":[]}

topics_dict = { "title":[], \
                "created": [], \
                "url":[]}

for submission in new_subreddit:
    topics_dict["title"].append(submission.title)
    # topics_dict["score"].append(submission.score)
    # topics_dict["id"].append(submission.id)
    topics_dict["url"].append(submission.url)
    # topics_dict["comms_num"].append(submission.num_comments)
    topics_dict["created"].append(submission.created)
    # topics_dict["body"].append(submission.selftext)

## creo el dataframe y saco los "viejos" o ya leidos
topics_data = pd.DataFrame(topics_dict)

def get_date(created):
    return dt.datetime.fromtimestamp(created)

_timestamp = topics_data["created"].apply(get_date)

topics_data = topics_data.assign(timestamp = _timestamp)

try:
    with open('last.txt', 'r') as outfile:
        # ultimo = '2020-12-15 18:00:00'
        ultimo = outfile.read()
        fin_proximo = topics_data['timestamp'].max()
        topics_data = topics_data[topics_data['timestamp'] >= ultimo ]
except:
    pass

del topics_data['created']
del topics_data['timestamp']

# ### Elimino duplicados
# topics_data = []
# for item in topics_data2:
#     if item not in topics_data:
#         topics_data.append(item)
# ###

lista_titulos = topics_data['title'].values.tolist()
lista = topics_data['url'].values.tolist()

# print(lista)

for url in lista:
    n_orden = lista.index(url)
    print(str(n_orden)+"/"+str(len(lista)) + " - " + url)
    if 'edutreasure.in' in url:
        # if os.system("ping -c 1 'edutreasure.in' > /dev/null 2>&1") != 0:
        #     print('url no encontrada')
        #     continue
        # else:
        edutreasure(url)
    if 'freewebcart.com' in url:
        # if os.system("ping -c 1 'www.freewebcart.com' > /dev/null 2>&1") != 0:
        #     print('url no encontrada')
        #     continue
        # else:
        freewebcart(url)
    if 'idownloadcoupon.com' in url:
        # if os.system("ping -c 1 'idownloadcoupon.com' > /dev/null 2>&1") != 0:
        #     print('url no encontrada')
        #     continue
        # else:
        idownloadcoupon(url)
    if 'couponbro.eu' in url:
        # if os.system("ping -c 1 'couponbro.eu' > /dev/null 2>&1") != 0:
        #     print('url no encontrada')
        #     continue
        # else:
        couponbro(url)
    if 'real.discount' in url:
        # if os.system("ping -c 1 'www.real.discount' > /dev/null 2>&1") != 0:
        #     print('url no encontrada')
        #     continue
        # else:
        real(url)
    if '100offdeal.online' in url:
        # if os.system("ping -c 1 '100offdeal.online' > /dev/null 2>&1") != 0:
        #     print('url no encontrada')
        #     continue
        # else:
        offdeal(url)
    if 'myfreeonlinecourses' in url:
        # if os.system("ping -c 1 'myfreeonlinecourses.com' > /dev/null 2>&1") != 0:
        #     print('url no encontrada')
        #     continue
        # else:
        myfreeonlinecourses(url)
    if 'training-coursez' in url:
    # if os.system("ping -c 1 " + url + " > /dev/null 2>&1") != 0:
    #     print('url no encontrada')
    #     continue
    # else:
        training(url)
    if 'realfreecoupons.com' in url:
        # if os.system("ping -c 1 'realfreecoupons.com' > /dev/null 2>&1") != 0:
        #     print('url no encontrada')
        #     continue
        # else:
        realfreecoupons(url)
## agregar esta web https://fresherscareer.online/
        # print(str(n_orden)+"/"+str(len(lista)) + " - " + link)
#     # print(lista)
# 
# print('***************************************************************************')
# print(lista)


topics_data = {'Titulo del Curso':lista_titulos,'Url Curso Gratis':lista}
topics_data = pd.DataFrame(topics_data) 

print(topics_data)

topics_data = topics_data.drop_duplicates('Url Curso Gratis', keep="last")

print(topics_data)

       
# topics_data['url'] = '<a href=' + topics_data['url'] + '</div></a>'
topics_data['Url Curso Gratis'] = '<a target="_blank" href=' + topics_data['Url Curso Gratis'] + '><div>' + topics_data['Titulo del Curso'] + '</div></a>'
# topics_data = topics_data[['url']].to_html('r_udemyfreebies.html', index=False, escape=False)
# topics_data = topics_data[['url','timestamp']].rename({'url': 'Url Curso Gratis', 'timestamp': 'Fecha Creación'}, axis='columns')

del topics_data['Titulo del Curso']

# ESCRIBO LA FECHA DEL MAS RECIENTE Y EXPORTE EL HTML Y LO MANDO X TELEGRAM
topics_data.to_html('r_udemyfreebies.html', index=False, escape=False)
# topics_data.to_excel('r_udemyfreebies.xlsx', index=False)
envioarchivotelegram('r_udemyfreebies.html')

with open('last.txt', 'w') as outfile:
    # ultimo = '2020-12-15 18:00:00'
    outfile.write(str(fin_proximo))
