#!/bin/sh

sleep $NACOS_WAITING_TIME_BEFORE_MYSQL_STARTED
sh /home/seata/pushSeataConfig.sh &
sh /home/nacos/bin/docker-startup.sh