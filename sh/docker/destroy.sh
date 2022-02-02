#!/bin/bash
cd `dirname $0`

. $ONEKEY_ENV_PATH/sh/color.sh
. $ONEKEY_ENV_PATH/sh/function.sh

# 检查是否启动
isAllDockerContainerStopped
if [ $? = 0 ]; then
  docker-compose -f $ONEKEY_ENV_PATH/docker-compose.yml stop
fi

echo -e "docker-compose -f $ONEKEY_ENV_PATH/docker-compose.yml rm --force"
docker-compose -f $ONEKEY_ENV_PATH/docker-compose.yml rm

