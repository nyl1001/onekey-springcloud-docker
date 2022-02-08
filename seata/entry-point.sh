#!/bin/sh
echo ">>>>  Right before checking nacos status for seata starting <<<<"
echo "###########################################################"
echo "###########################################################"
echo "###########################################################"
echo "###########################################################"
nacosStatuCheckUrl="http://${HOST_IP}:${COMMON_NACOS_PORT}/nacos/v1/cs/configs?dataId=${NACOS_STATUS_CHECK_KEY_FOR_SEATA}&tenant=${COMMON_NACOS_NAMESPACE}&group=${COMMON_NACOS_GROUP}"
echo "nacosStatuCheckUrl : ${nacosStatuCheckUrl}"
while true
    do
        echo "checking nacos staus for seata starting HOST_IP: ${HOST_IP} ${nacosStatuCheckUrl}"
        response=$(curl -sb -H "Accept: application/x-www-form-urlencoded" "${nacosStatuCheckUrl}")
        echo "【checking for seata】 response : ${response}"
        if [ "db" = "${response}" ]
            then
              echo ">>>> 【checking for seata】 nacos started <<<<"
              break
            else
              echo ">>>> 【checking for seata】nacos is starting. continue checking. <<<<"
              sleep 5
        fi
    done
sleep 45
echo ">>>>  Right before starting seata server <<<<"
echo "###########################################################"
echo "###########################################################"
echo "###########################################################"
echo "###########################################################"
sh /seata-server/bin/seata-server.sh -h $SEATA_IP