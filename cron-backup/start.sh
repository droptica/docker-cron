#!/usr/bin/env bash

rsyslogd
echo -e "MAILTO=\"\"\n$(cat /etc/crontab)" > /etc/crontab
chmod 400 /etc/crontab
cron
touch /var/log/cron.log
tail -F /var/log/syslog /var/log/cron.log
