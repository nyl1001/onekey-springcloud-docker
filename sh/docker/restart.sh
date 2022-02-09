#! /bin/bash

. $ONEKEY_ENV_PATH/sh/color.sh

# 如果未启动，会直接启动
$OUTPUT "
$WHITE all docker containers will restart $TAILS
"
docker-compose -f $ONEKEY_ENV_PATH/docker-compose.yml restart
