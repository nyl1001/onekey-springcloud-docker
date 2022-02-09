#!/bin/bash

rootDir=$ONEKEY_ENV_PATH

. ${rootDir}/sh/color.sh

cp ${rootDir}/.env-default ${rootDir}/.env
cp ${rootDir}/seata/conf/registry-default.conf ${rootDir}/seata/conf/registry.conf

hostIp=$(/sbin/ifconfig -a | grep inet | grep -v 127.0.0.1 | grep -v inet6 | awk '{print $2}' | tr -d "addr:" | sed 1q)
echo "HOST_IP: $hostIp"

sysType=$(uname -s)
case $sysType in
    "Linux")
        sed -i "s/{hostIpVariable}/${hostIp}/g" ${rootDir}/.env
        ;;
    "Darwin")
        sed -i '' "s/{hostIpVariable}/${hostIp}/g" ${rootDir}/.env
        ;;
    *)
        $OUTPUT "system $sysType not supported!"
        exit -1
        ;;
esac
while read line; do
    key=${line%=*}
    value=${line#*=}
    case $key in
        "COMMON_NACOS_NAMESPACE_FOR_SEATA")
            case $sysType in
                "Linux")
                    sed -i "s/{nacosNamespaceVariale}/${value}/g" ${rootDir}/seata/conf/registry.conf
                    ;;
                "Darwin")
                    sed -i '' "s/{nacosNamespaceVariale}/${value}/g" ${rootDir}/seata/conf/registry.conf
                    ;;
                *)
                    $OUTPUT "system $sysType not supported!"
                    exit -1
                    ;;
            esac
            ;;
        "COMMON_NACOS_GROUP_FOR_SEATA")
            case $sysType in
                "Linux")
                    sed -i "s/{nacosGroupVariale}/${value}/g" ${rootDir}/seata/conf/registry.conf
                    ;;
                "Darwin")
                    sed -i '' "s/{nacosGroupVariale}/${value}/g" ${rootDir}/seata/conf/registry.conf
                    ;;
                *)
                    $OUTPUT "system $sysType not supported!"
                    exit -1
                    ;;
            esac
            ;;
        *) ;;
    esac
done < ${rootDir}/.env

$OUTPUT "$GREEN init docker config successfully"
