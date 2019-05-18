#!/usr/bin/python3
# -*- coding: utf-8 -*-

import paramiko
import time

client = paramiko.SSHClient()
client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
client.connect('192.168.101.230', username='root', password='1')
stdin, stdout, stderr = client.exec_command('shutdown -r now')

for line in stdout:
    print(line.strip('\n'))

i = 0
print("Пожалуйста подождите, система выключается")
while i <= 100:
	print(i,"%")
	time.sleep(1)
	i += 10
print("Готово!")
time.sleep(2)

client.close()
