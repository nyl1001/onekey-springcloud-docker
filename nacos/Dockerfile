FROM  docker.io/nacos/nacos-server
# 解释信息
LABEL maintainer="neil <yinliangnie@icloud.com>"

ENV SRC_DIR=/home/nacos/src

# 文件拷贝
COPY src/ $SRC_DIR

#RUN cd $SRC_DIR \
#    && tar zxvf curl-7.61.0.tar.gz \
#    && cd curl-7.61.0 \
#    && ./configure --prefix=/home/nacos/curl --exec-prefix=/home/nacos/curl \
#    && make \
#    && make install; \
#    \
#    cd /home \
#    && rm -rf /home/nacos/src;

COPY config-for-seata/nacos-config.sh /home/seata/nacos-config.sh
COPY config-for-seata/config.txt /home/seata/config.txt
COPY config-for-seata/pushSeataConfig.sh /home/seata/pushSeataConfig.sh
COPY config-for-seata/entry-point.sh /home/seata/entry-point.sh

RUN yum install -y net-tools && chmod +x /home/seata/nacos-config.sh && chmod +x /home/seata/pushSeataConfig.sh

ENTRYPOINT ["/bin/bash", "/home/seata/entry-point.sh"]