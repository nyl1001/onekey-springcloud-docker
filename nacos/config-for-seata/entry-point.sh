#!/bin/sh

sleep $NACOS_WAITING_TIME_FOR_MYSQL_STARTING
sh /home/seata/pushSeataConfig.sh &
sh /home/nacos/bin/docker-startup.sh