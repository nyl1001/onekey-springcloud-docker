#!/bin/bash

ONEKEY_ENV_PATH=`(pwd)`

sysType=$(uname -s)
case $sysType in
    "Linux")
        echo export ONEKEY_ENV_PATH="$ONEKEY_ENV_PATH" >> ~/.profile && echo 'export PATH="$PATH:$ONEKEY_ENV_PATH/bin"' >> ~/.profile
        ;;
    *)
        $OUTPUT "system $sysType not supported!"
        exit -1
        ;;
esac

cp $ONEKEY_ENV_PATH/docker-compose.yml.bak $ONEKEY_ENV_PATH/docker-compose.yml

$OUTPUT "Seting Env ONEKEY_ENV_PATH $ONEKEY_ENV_PATH successfully..."