FROM droptica/php-developer:7.0-v1.5


#ADD jobber /var/spool/cron/crontabs/www-data

ADD cron.sh /bin/cron.sh
RUN chmod +x /bin/cron.sh

#run cron every x min
ENV RUN_TIME 5

ENV START_TIME  000000

ENV END_TIME    235959

ENV DEBUG 0

ENV DAYS "1,2,3,4,5,6,7"

ENV CRON_COMMAND "cron"
#For elysia cron
#ENV CRON_COMMAND "elysia-cron run"
#Additional arg for cron
ENV CRON_JOB ""

RUN echo "memory_limit = 1024M" > /usr/local/etc/php/conf.d/memory_limit.ini

CMD /bin/cron.sh