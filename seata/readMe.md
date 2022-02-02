- 参考地址：
https://blog.csdn.net/baidu_38432732/article/details/118672476

- config.txt下载地址
https://github.com/seata/seata/blob/develop/script/config-center/config.txt

- nacos-config.sh下载地址
https://github.com/seata/seata/blob/develop/script/config-center/nacos/nacos-config.sh

- 修改nacos配置参数：seata/conf/registry.conf

- 推送seata配置到nacos

将config.txt文件放到nacos-config.sh文件所在目录的上一级目录（nacos-config.sh不作任何修改）

sh nacos-config.sh -h {nacos服务的ip} -u {nacos用户名} -w {nacos密码}