FROM openjdk:8
LABEL maintainer="neil <yinliangnie@icloud.com>"

# 参考 https://blog.csdn.net/a745233700/article/details/122402825

# set environment
ENV SEATA_USER="seata" \
    BASE_DIR="/home/seata" \
    JVM_XMS="512m" \
    JVM_XMX="512m" \
    JVM_XMN="256m" \
    JVM_MS="64m" \
    JVM_MMS="160m" \
    TIME_ZONE="Asia/Shanghai"

ARG SEATA_VERSION=1.4.2

# 设置工作目录
WORKDIR $BASE_DIR

#调试问题时查看系统信息用
#RUN uname -a
#RUN cat /etc/issue

RUN apt-get update && apt-get install net-tools

COPY seata-server-${SEATA_VERSION}.tar.gz /

# 设置时间，东八区
RUN set -x \
    && rm -f /etc/localtime \
    && ln -snf /usr/share/zoneinfo/$TIME_ZONE /etc/localtime \
    && echo '$TIME_ZONE' > /etc/timezone \
    && tar -xzvf /seata-server-${SEATA_VERSION}.tar.gz -C / \
    && mv /seata/seata-server-${SEATA_VERSION} /seata-server \
    && rm -rf /seata-server-${SEATA_VERSION}.tar.gz \
    && rm -rf /seata

ADD conf/registry.conf /seata-server/conf/registry.conf
ADD conf/file.conf /seata-server/conf/file.conf

COPY entry-point.sh /seata-server/bin/entry-point.sh

#端口
EXPOSE 8091
RUN chmod +x /seata-server/bin/entry-point.sh && chmod +x /seata-server/bin/seata-server.sh
ENTRYPOINT ["/seata-server/bin/entry-point.sh" ]
