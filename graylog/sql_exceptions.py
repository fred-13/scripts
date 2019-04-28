#!/usr/bin/python3

# https://curl.trillworks.com/ на этом сайте можно сформировать CURL запрос для Python

import json, requests, datetime

max_exc = []
max_exc_index = 0
time_now = datetime.datetime.now()

# Это список сервисов. Сюда нужно будет дописывать новый 'process-name' сервиса и он автоматом подхватится на мониторинг.
name_services = [
    "iikoNet.Host.WinService",
    "Service.Api.Front.v2",
    "Service.FrontPlugin.Api.Host",
    "Plazius.PosApiV1.Host",
    "Service.Notification.Host",
    "Service.Delivery.Host",
    "Service.Offliner.Host",
    "Service.Payment.Host",
    "Service.DigitalLoyaltyCards.Host",
    "w3wp",
    "Service.Reservations",
    "Service.MobileAppRatings.Host",
    "Service.Menu.Host",
    "Service.Preorder.Host",
    "Service.Onboarding.Host",
    "Service.Scheduler.Host",
    "Service.TemplatedMarketingCampaign.Host",
    "Service.ReportsDataReplication",
    "Service.AntiFraud.Host",
    "Service.MobileApi.Organizations.Host",
    "Service.ClientEvents"]

# Тут дописываем команду по соответсвию к тому сервису что добавили.
name_team = [
    "@POS-PLATFORM",
    "@POS-PLATFORM",
    "@INDOOR",
    "@POS-PLATFORM",
    "@LOYALTY_SQUAD",
    "@OUTDOOR",
    "@POS",
    "@INDOOR",
    "@INDOOR",
    "@LOYALTY_SQUAD",
    "@INDOOR",
    "@INDOOR",
    "@OUTDOOR",
    "@INDOOR",
    "@LOYALTY_SQUAD",
    "@PLATFORM",
    "@LOYALTY_SQUAD",
    "@REPORTING_SQUAD",
    "@INDOOR",
    "@INDOOR",
    "@PLATFORM"]

# Здесь стандартный мониторинг общего SQL Exception.
headers = {
        'Accept': 'application/json',
    }

params = (
        ('query', 'LogLevel:Error AND "SqlException"'),
        ('range', '3600'),
        ('decorate', 'true'),
    )

response_json1 = requests.get('http://192.168.1.20:12900/search/universal/relative', headers=headers, params=params, auth=('1srufl1ibrpuuihjgd2vm89fblp3qac3btkfutlqgtp509d1mvl0', 'token'))
print(json.loads(response_json1.text)['total_results'])

# Это условие начинает отрабатывать в случае если ошибки перевалили за 200. Тут два цикла и работа их заключается в том чтобы найти сервис с максимальным числом ошибок.
if json.loads(response_json1.text)['total_results'] > 200:

    for i in range(len(name_services)):

        headers = {
            'Accept': 'application/json',
        }

        params = (
            ('query', 'LogLevel:Error AND "SqlException" AND process-name:' + name_services[i]),
            ('range', '3600'),
            ('decorate', 'true'),
        )

        response_json2 = requests.get('http://192.168.1.20:12900/search/universal/relative', headers=headers, params=params, auth=('1srufl1ibrpuuihjgd2vm89fblp3qac3btkfutlqgtp509d1mvl0', 'token'))
        max_exc.insert(i, json.loads(response_json2.text)['total_results'])
        # print(max_exc[i]) # - если расскомментировать эту строку то можно увидеть вывод ошибок всех сервисов

    for i in range(len(max_exc) - 1):
        if max_exc[i] > max_exc[i + 1]:
            max_exc_index = i

    # Если раскомментировать эти строки то можно увидеть какой сервис мы нашли
    # print("\n---------------------------------------------------\n")
    # print(max_exc_index)
    # print(name_services[max_exc_index] + ": " + str(max_exc[max_exc_index]))
    # print("\n---------------------------------------------------")

    # Как только нашли сервис с максимальным числом ошибок сразу летит вэб-хук
    webhook_url = 'https://hooks.slack.com/services/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'
    slack_data = {'text': "<!here> Problem!\n Started at " + time_now.strftime("%H:%M on %d-%m-%Y") + " \nSQL Exception more 200 from *" + name_services[max_exc_index] + "*! Responsible Team - *" + name_team[max_exc_index] + "*\n Host: Graylog-Prod"}

    response = requests.post(
        webhook_url, data=json.dumps(slack_data),
        headers={'Content-Type': 'application/json'}
    )

