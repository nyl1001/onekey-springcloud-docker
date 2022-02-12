#!/bin/sh

echo ">>>>  Right before synchronizing seata config to nacos <<<<"
echo "###########################################################"
echo "###########################################################"
echo "###########################################################"
echo "###########################################################"
# use while loop to check if nacos is running
while true
do
    netstat -uplnt | grep :8848 | grep LISTEN > /dev/null
    verifier=$?
    if [ 0 = $verifier ]
        then
            echo "synchronizing seata config to nacos"
            if [ "$COMMON_NACOS_NAMESPACE_FOR_SEATA" =  "" ]
                then
                    sh /home/seata/nacos-config.sh -h 127.0.0.1 -p 8848 -u nacos -w nacos -g ${COMMON_NACOS_GROUP_FOR_SEATA}
                else
                    sh /home/seata/nacos-config.sh -h 127.0.0.1 -p 8848 -u nacos -w nacos -g ${COMMON_NACOS_GROUP_FOR_SEATA} -t ${COMMON_NACOS_NAMESPACE_FOR_SEATA}
            fi
            break
        else
            echo "nacos is not running yet"
            sleep 5
    fi
done
echo "###########################################################"
echo "###########################################################"
echo "###########################################################"
echo "###########################################################"
echo ">>>>  synchronizing seata config to nacos successfully <<<<"
