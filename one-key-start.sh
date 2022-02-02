#!/bin/bash

ONEKEY_ENV_PATH=`dirname "$0"`

. $ONEKEY_ENV_PATH/sh/function.sh
. $ONEKEY_ENV_PATH/sh/color.sh

# 初始化基础配置数据
. $ONEKEY_ENV_PATH/sh/initConfig.sh

# 检查是否启动
isAllDockerContainerWorking
if [ $? = 1 ]; then
  $OUTPUT "
  $WHITE onekey docker is running $TAILS
  "
  docker ps | grep onekey
else
  docker-compose -f $ONEKEY_ENV_PATH/docker-compose.yml up -d
  $OUTPUT "
  $GREEN onekey tech docker environment start work, enjoy coding...
  "
fi

