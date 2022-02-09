#!/bin/bash

. $ONEKEY_ENV_PATH/sh/color.sh

$OUTPUT "$RED Caution !!! $TAILS"
$OUTPUT "$RED docker-compose -f $ONEKEY_ENV_PATH/docker-compose.yml down --rmi all $TAILS"
docker-compose -f $ONEKEY_ENV_PATH/docker-compose.yml down --rmi all
