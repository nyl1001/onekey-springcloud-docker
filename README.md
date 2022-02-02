# 一键部署spring cloud基础开发环境（无缝整合nacos、seata、zookeeper、kalfka、minio）
**注意:** 目前仅支持 Mac 与 Linux两种系统

由于spring cloud基础开发环境的搭建和配置较为繁琐，依赖项众多，而目前市面上相关的指导文档层次不齐，
给开发人员带来极大不便，从而导致较高的学习成本和开发成本，本人因工作和个人兴趣原因，近期对spring cloud开发环境进行了docker容器编排的整合，
支持一键式配置和启动spring cloud的docker开发环境，希望能给有需要的同学带来帮助。

## 1 安装与启动

### 1.1 首次安装

首次安装需要配置环境变量ONEKEY_ENV_PATH

对于linux系统可以在本项目根目录下执行下列脚本:
```
cd到当前项目根目录下执行如下脚本
./init.sh
```

用户也可通过如下方式手动设置该环境变量
```
linux环境配置方法如下：
cd onekey-springcloud-docker项目根目录
echo export ONEKEY_ENV_PATH=$(pwd) >> ~/.profile && echo 'export PATH="$PATH:$ONEKEY_ENV_PATH/bin"' >> ~/.profile && source ~/.profile

mac os环境配置方法如下：
cd onekey-springcloud-docker项目根目录
echo export ONEKEY_ENV_PATH=$(pwd) >> ~/.zshrc && echo 'export PATH="$PATH:$ONEKEY_ENV_PATH/bin"' >> ~/.zshrc && source ~/.zshrc
或者
cd onekey-springcloud-docker项目根目录
echo export ONEKEY_ENV_PATH=$(pwd) >> ~/.bashrc && echo 'export PATH="$PATH:$ONEKEY_ENV_PATH/bin"' >> ~/.bashrc && source ~/.bashrc
或者
cd onekey-springcloud-docker项目根目录
echo export ONEKEY_ENV_PATH=$(pwd) >> ~/.zshrc.pre-oh-my-zsh && echo 'export PATH="$PATH:$ONEKEY_ENV_PATH/bin"' >> ~/.zshrc.pre-oh-my-zsh && source ~/.zshrc.pre-oh-my-zsh

```

### 1.2 依赖环境准备
- docker

docker的安装指南请移步官网：
https://www.docker.com/get-started

- docker compose

docker-compose的安装指南请移步官网：
https://docs.docker.com/compose/install/

### 1.3 启动
当环境变量设置和docker-compose执行环境安装完毕后，可以通过如下方式启动容器：
- 方式1：任意目录下执行 onekey start 命令
- 方式2：直接执行当前项目目录下的 one-key-start.sh 脚本


### 1.4 onekey 命令行参数说明

```
// docker简单命令列表
onekey build       重置配置信息，文件.env、seata/conf/registry.conf、docker-compose.yml均会被重置
onekey list        显示当前onekey的容器列表
onekey start       启动容器，启动后即可正常使用该容器进行coding
onekey restart     重新启动容器；如果没有启动，会直接启动容器，此时与 onekey start 效果相同
onekey stop        停止容器的运行
onekey login       进入容器内部，需要指定容器名称
onekey destroy     删除容器及镜像
onekey help        显示所有的命令列表

```

## 2 配置注意事项

- 原则上配置文件.env-default和seata/conf/registry-default.conf不要做任何修改。

- 如果在本docker启动时，发生端口冲突，请尽量修改原冲突服务的端口。

- 当执行onekey build命令时，文件.env、seata/conf/registry.conf、docker-compose.yml均会被重置。

- .env文件会在每次执行onekey start时被重置，主要是为了及时刷新HOST_IP配置，防止因主机换一个环境后ip地址发生变更导致容器启动失败。

- 不要修改被大括号{}标记的变量。

## 端口占用情况
运行命令 docker ps | grep onekey 即可查看
- seata-server         0.0.0.0:8091->8091/tcp
- kafka                0.0.0.0:9082->9092/tcp
- nacos                0.0.0.0:8848->8848/tcp, 0.0.0.0:9555->9555/tcp, 0.0.0.0:9848->9848/tcp
- redis                0.0.0.0:6380->6379/tcp 
- zookeeper            0.0.0.0:2181->2181/tcp
- mysql-for-seata      0.0.0.0:3308->3306/tcp
- mysql-for-nacos      0.0.0.0:3307->3306/tcp
- minio                0.0.0.0:9000-9001->9000-9001/tcp     

如果特殊情况下确实不可避免需要修改上述端口信息，请同步修改下列配置文件的如下位置:
- seata/conf/registry-default.conf
- nacos/config-for-seata/pushSeataConfig.sh:14
- nacos/config-for-seata/pushSeataConfig.sh:19
- nacos/config-for-seata/nacos-config.sh:48
- .env-default:4
- registry-default.conf:7
- seata/conf/registry-default.conf:21
- seata/conf/registry.conf:7:
- seata/conf/registry.conf:21:
- docker-compose.yml:25

## 3 部分重点细节说明
1. nacos和seata容器镜像均进行了一定程度的自定义改造。其进行自定义的主要原因是：
    - seata采用了nacos方式进行服务注册和服务发现，并且seata的配置参数也是通过nacos进行配置和获取，这样在nacos启动之后需要立即导入seata的配置信息。
    - nacos的启动过程较长，而seata的启动依赖nacos，因此需要在检查确认nacos启动成功并且seata的配置信息全部同步到nacos后才能启动。

2. seata 镜像基于seata-server 1.4.2构建。

3. kafka采用了zookeeper进行服务注册和发现。

4. nacos使用mysql5.7作数据持久化，这里用户可以根据情况改成mysql8。

5. mysql-for-seata容器为seata提供数据持久化，mysql-for-seata容器在启动时会初始化seata所依赖的数据表结构并生成默认的seata访问账号。


