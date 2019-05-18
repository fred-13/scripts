#!/usr/bin/python3
# -*- coding: utf-8 -*-

import shutil
import os
import time

path = 'Z:\Kassa'

dir_list = [os.path.join(path, x) for x in os.listdir(path)]

if dir_list:
    date_list = [[x, os.path.getctime(x)] for x in dir_list]
    sort_date_list = sorted(date_list, key=lambda x: x[1], reverse=True)

ssylka = sort_date_list[0][0]

RW_File = open(ssylka,'a', encoding='utf-8')
RW_File.write('''--------------------------------------- ''')
RW_File.write('''Дата создания отчета: ''' +ssylka[9: 19])
RW_File.write(''' ---------------------------------------''')
RW_File.close()

shutil.copyfile(ssylka, r'C:\mailsend\rabota_kassira.txt')

time.sleep(5)

os.system(r'C:\mailsend\send_mail.bat')

