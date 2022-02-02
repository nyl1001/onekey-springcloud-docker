#!/bin/bash
cd `dirname $0`

. $ONEKEY_ENV_PATH/sh/color.sh

if [ $1 ]; then
  $OUTPUT "
  $WHITE into the $1 container $TAILS
  "
  docker exec -it $1 /bin/bash
fi