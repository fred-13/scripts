#!/bin/bash

DATE=`date +%d.%m.%Y`
XSNAME=`echo $HOSTNAME`
UUIDFILE=/tmp/xen-uuids.txt
NAMEIDFILE=/tmp/xen-nameids.txt
WEBHOOK='https://hooks.slack.com/services/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'

if [[ $# -gt 0 ]]; then
	echo "parameter for backup: $1"
else
	echo "ERROR: parameter is not specified"
	exit 1
fi

mkdir -p /mnt1
mount -t nfs 192.168.15.201:/volume1/XEN /mnt1

BACKUPPATH=/mnt1/$XSNAME/$DATE
mkdir -p ${BACKUPPATH}

xe vm-list is-control-domain=false is-a-snapshot=false | grep name-label | cut -d":" -f2  > ${UUIDFILE}

cat $UUIDFILE | grep $1 >$NAMEIDFILE

while read NAMEID
do
echo begin=$NAMEID
    SNAPUUID=`xe vm-snapshot vm=$NAMEID new-name-label="SNAPSHOT-$NAMEID-$DATE"`
    xe template-param-set is-a-template=false ha-always-run=false uuid=${SNAPUUID}
    xe vm-export vm=${SNAPUUID} filename="$BACKUPPATH/$NAMEID-$DATE.xva"
    xe vm-uninstall uuid=${SNAPUUID} force=true
echo end=$NAMEID
done < ${NAMEIDFILE}

if [ $(egrep -oi "cancelled|failed|error" /tmp/backup${1}.log | wc -w) == 0 ] ;then 
	echo "BackUp OK"
else 
	echo "BackUp FAILED"
	curl -X POST -H 'Content-type: application/json' --data "{\"channel\": \"#incident_hw_prod\",\"username\": \"Backup_Alert\",\"text\":\"Backup on ${XSNAME} FAILED\"}" ${WEBHOOK}
	zabbix_sender -z 192.168.15.109 -s "${XSNAME}_BackUp" -k XenBackUp -o 0
fi
