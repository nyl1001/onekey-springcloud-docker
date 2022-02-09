#! /bin/bash

. $ONEKEY_ENV_PATH/sh/function.sh
. $ONEKEY_ENV_PATH/sh/color.sh

dir=$ONEKEY_ENV_PATH

# 拷贝文件
cp $dir/docker-compose.yml.bak $dir/docker-compose.yml

# 初始化基础配置数据
. $ONEKEY_ENV_PATH/sh/initConfig.sh

docker-compose -f $ONEKEY_ENV_PATH/docker-compose.yml build

$OUTPUT "docker compose file dir:$dir"

$OUTPUT "$GREEN Congratulations! rebuild config success! $TAILS"