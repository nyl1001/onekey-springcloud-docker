#! /bin/bash
cd `dirname $0`

. $ONEKEY_ENV_PATH/sh/function.sh
. $ONEKEY_ENV_PATH/sh/color.sh

# 检查是否启动
isAllDockerContainerStopped
if [ $? = 0 ]; then
  $OUTPUT "
  $WHITE docker container will stop running $TAILS
  "
  docker-compose -f $ONEKEY_ENV_PATH/docker-compose.yml stop
else
  $OUTPUT "
  $WHITE docker container was stopped $TAILS
  "
fi
