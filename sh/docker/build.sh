#! /bin/bash
cd `dirname $0`
. $ONEKEY_ENV_PATH/sh/function.sh
. $ONEKEY_ENV_PATH/sh/color.sh

dir=$ONEKEY_ENV_PATH

# 拷贝文件
cp $dir/docker-compose.yml.bak $dir/docker-compose.yml

# 初始化基础配置数据
. $ONEKEY_ENV_PATH/sh/initConfig.sh

$OUTPUT "docker compose file dir:$dir"

$OUTPUT "$GREEN Congratulations! rebuild config success! $TAILS"