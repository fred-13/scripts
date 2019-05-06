w32tm /config /manualpeerlist:ntp4.stratum1.ru /syncfromflags:manual /reliable:yes /update
net stop w32time && net start w32time
w32tm /config /update
w32tm /resync
W32tm /stripchart /computer:ntp4.stratum1.ru
