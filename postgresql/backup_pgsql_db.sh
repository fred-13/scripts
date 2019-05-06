#!/bin/bash

HOST="PG-Slave"                         # Имя хоста на котором будем выполнять скрипт, можно и не использовать
DUMPER="/usr/bin/pg_dump"               # Указываем утилиту резервного копирования (дампа).
DATE=`date +%F_%H.%M`                   # Задаем дату и время бекапа
FIND="/usr/bin/find"                    # Указываем утилиту для поиска

sudo mount.cifs -v -o username=pgbackup,domain=cloud.platius.ru,pass=MyVeryHardPass,iocharset=utf8,file_mode=0777,dir_mode=0777 //backup/SqlBackups/DBCLUSTER\$MainDB/postgresql/ /mnt/backup/
sleep 3

BACKUPDIR="/mnt/backup/"
mkdir $BACKUPDIR$DATE

for DBNAME in Test_db1 Test_db2 Test_db3;
  do

    $DUMPER $DBNAME | gzip > $BACKUPDIR$DATE/$DBNAME.$HOST-$DATE.sql.gz

  done

sleep 3

# Удаляем старые архивы, а точней файлы старше 7 дней, так же удаляем  пустые каталоги.
$FIND $BACKUPDIR* -mtime +7 -exec rm -rf {} \;
sleep 3

sudo umount $BACKUPDIR

#  Этой командой БД восстаналивается. Выполнять команду только на мастере, т.к. слэйв для чтения.
#  gunzip < $BACKUPDIR$DBNAME.$HOST-$DATE.sql.gz | psql $DBNAME

exit 0
