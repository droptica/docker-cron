#!/usr/bin/env bash

DATE=`date +%Y-%m-%d`

export HOME=/root

#WRITE YOUR OWN BACKUP CODE
tar zcf /app/files/EXAMPLE-files-${DATE}.tar.gz -C /app/site/default/files/ site/default/files/

sleep 10

#SEND TO AWS
/usr/local/bin/aws s3 cp /app/files/EXAMPLE-files-${DATE}.tar.gz s3://BUCCKET_URL/BACKUP_DIR/EXAMPLE-files-${DATE}.tar.gz

sleep 10

#REMOVE LOCAL FILES
rm /app/files/EXAMPLE-files-${DATE}.tar.gz