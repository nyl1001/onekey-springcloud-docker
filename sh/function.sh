#! /bin/bash

. $ONEKEY_ENV_PATH/sh/commonShellConfig.sh
# 检查容器是否已经开始工作
function isAllDockerContainerWorking() {
  allWorkingOnekeyContainerList=$(docker ps | grep onekey | awk '{print $2}')
  if [ -z "$allWorkingOnekeyContainerList" ]; then
    return 0
  fi

  for curContainer in ${allOnekeyDockerArray[@]}; do
    if [[ ! "${allWorkingOnekeyContainerList[@]}" =~ "${curContainer}" ]]; then
      return 0
    fi
  done

  return 1
}

function isAllDockerContainerStopped() {
  allWorkingOnekeyContainerList=$(docker ps | grep onekey | awk '{print $2}')
  if [ -z "$allWorkingOnekeyContainerList" ]; then
    return 1
  fi

  for curContainer in ${allOnekeyDockerArray[@]}; do
    if [[ "${allWorkingOnekeyContainerList[@]}" =~ "${curContainer}" ]]; then
      return 0
    fi
  done

  return 1
}
