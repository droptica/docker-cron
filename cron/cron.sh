#!/usr/bin/env bash

RUN_TIME=$((60*$RUN_TIME))

IFS=',' read -r -a days <<< "$DAYS"

#if [[ " ${days[@]} " =~ " ${day} " ]]; then
#    echo "ok"
#fi

function run_cron() {
    DIFF=0
    DAY=$(date +%u)
    day=$(date +%u)
    curTime=$(date  +"%H%M%S")
    if [[ " ${days[@]} " =~ " ${day} " ]]; then
        if [ $END_TIME -gt $START_TIME ]; then
            ######### DEBUG ##########
            if [ $DEBUG -ne 0 ]; then
                prnt "END_TIME: $END_TIME > START_TIME: $START_TIME"
                prnt "curTime: $curTime"
            fi
            ######### DEBUG ##########
            if [ $END_TIME -gt $curTime ] && [ $curTime -gt $START_TIME ]; then
                ######### DEBUG ##########
                if [ $DEBUG -ne 0 ]; then
                    prnt "END_TIME: $END_TIME > curTime: $curTime  &&  curTime: $curTime > START_TIME: $START_TIME"
                fi
                ######### DEBUG ##########
                run_cron_job
            else
                ######### DEBUG ##########
                if [ $DEBUG -ne 0 ]; then
                    prnt "END_TIME: $END_TIME < curTime: $curTime  ||  curTime: $curTime < START_TIME: $START_TIME"
                fi
                ######### DEBUG ##########
                prnt "Nothing to do"
            fi
        else
            ######### DEBUG ##########
            if [ $DEBUG -ne 0 ]; then
                prnt "END_TIME: $END_TIME <= START_TIME: $START_TIME"
                prnt "curTime: $curTime"
            fi
            ######### DEBUG ##########
            if [ $curTime -lt $END_TIME ] || [ $START_TIME -lt $curTime ]; then
                ######### DEBUG ##########
                if [ $DEBUG -ne 0 ]; then
                    prnt "curTime: $curTime < END_TIME: $END_TIME  ||  START_TIME: $START_TIME < curTime: $curTime"
                fi
                ######### DEBUG ##########
                run_cron_job
            else
                ######### DEBUG ##########
                if [ $DEBUG -ne 0 ]; then
                    prnt "curTime: $curTime > END_TIME: $END_TIME  &&  START_TIME: $START_TIME > curTime: $curTime"
                fi
                ######### DEBUG ##########
                prnt "Nothing to do"
            fi
        fi
    else
        prnt "Wrong day of the week"
    fi

    if [ $DIFF -gt $RUN_TIME ]; then
        run_cron
    else
        prnt "Sleeping $(($RUN_TIME - $DIFF)) sec."
        sleep $(($RUN_TIME - $DIFF))
        run_cron
    fi
}

function run_cron_job() {
    prnt "#######  RUN CRON  #######"
    START=$(date +%s)
    prnt "Run: \"drush -r /var/www/html --uri=$URI $CRON_COMMAND $CRON_JOB\""
    prnt    `drush -r /var/www/html --uri=$URI $CRON_COMMAND $CRON_JOB`
    END=$(date +%s)
    DIFF=$(( $END - $START ))
    prnt "###### It took $DIFF seconds #######"
}

function prnt() {
    echo "- `date +\"%Y-%m-%d %H:%M:%S\"` - $1"
}
run_cron
