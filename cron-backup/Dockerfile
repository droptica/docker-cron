FROM droptica/php-developer:7.0-v1.5

RUN apt-get update && apt-get install --no-install-recommends -y rsyslog cron
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN pip install awscli

COPY start.sh /usr/bin/start.sh

RUN chmod +x /usr/bin/start.sh

COPY crontab /etc/crontab

COPY backup.sh /usr/bin/backup.sh

RUN chmod +x /usr/bin/backup.sh


ENTRYPOINT ["/usr/bin/start.sh"]

CMD []