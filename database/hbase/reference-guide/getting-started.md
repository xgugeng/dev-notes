<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [2. 快速开始 - Standalone HBase](#2-%E5%BF%AB%E9%80%9F%E5%BC%80%E5%A7%8B---standalone-hbase)
  - [2.1 JDK 版本](#21-jdk-%E7%89%88%E6%9C%AC)
  - [2.2 开始](#22-%E5%BC%80%E5%A7%8B)
  - [2.3  伪分布模式](#23--%E4%BC%AA%E5%88%86%E5%B8%83%E6%A8%A1%E5%BC%8F)
- [2.4 进阶 - 全分布式](#24-%E8%BF%9B%E9%98%B6---%E5%85%A8%E5%88%86%E5%B8%83%E5%BC%8F)
  - [2.5 Next](#25-next)
- [导航](#%E5%AF%BC%E8%88%AA)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# 2. 快速开始 - Standalone HBase

Standalone 实例包含所有的 HBase 守护进程：

- Master
- RegionServer
- ZooKeeper

## 2.1 JDK 版本

HBase 需要安装 JDK。

| HBase Version | JDK 7                                    | JDK 8                                    |
| ------------- | ---------------------------------------- | ---------------------------------------- |
| 2.0           | [Not Supported](http://search-hadoop.com/m/YGbbsPxZ723m3as) | yes                                      |
| 1.3           | yes                                      | yes                                      |
| 1.2           | yes                                      | yes                                      |
| 1.1           | yes                                      | Running with JDK 8 will work but is not well tested. |

## 2.2 开始

1. 前往[Apache Download Mirrors](http://www.apache.org/dyn/closer.cgi/hbase/)下载 HBase，选择 `stable`目录下带`.bin.tar.gz`后缀的二进制文件。

2. 解压文件

3. 设置 `JAVA_HOME` 环境变量。HBase 提用了一个配置中心：`conf/hbase-env.sh`，在这里设置环境变量。

4. 更改 `conf/hbase.site.xml` 配置，如数据存放路径等。

```xml
<configuration>
  <property>
    <name>hbase.rootdir</name>
    <value>file:///home/testuser/hbase</value>
  </property>
  <property>
    <name>hbase.zookeeper.property.dataDir</name>
    <value>/home/testuser/zookeeper</value>
  </property>
</configuration>
```

5. 启动 HBase `bin/start-hbase.sh`。使用`jps`命令可以查看`HMaster`进程。

**首次使用 HBase**

1. 连接到 HBase：`hbase shell`。

2. 查看 `help` 选项。

3. 创建表：`create 'test', 'cf'`。

4. 查看表的信息：`list 'test'`。

5. `Put` 数据到表中：`put 'test', 'row1', 'cf:a', 'value1'`。

6. 扫描表中的所有数据：`scan 'test'`。

7. 取单行数据：`get 'test', 'row1'`。

8. Disable 一个表：`disable 'test'`。

9. Drop 表：`drop 'test'`。

10. 退出 HBase Shell：`quit`。

**关闭 HBase**

```shell
bin/stop-hbase.sh
```

脚本执行需要几分钟时间，在此之后使用 `jps` 命令确认进程是否终止。


## 2.3  伪分布模式

伪分布模式意味着 HBase 在一台机器上运行`HMaster`、`HRegionServer`、`ZooKeeper`等独立的进程，而 Standalone 模式下所有的后台服务都是运行在一个 JVM 进程中。默认的 `hbase.rootdir` 为 `/tmp/`。

1. 确保关闭了 HBase。

2. 配置 HBase，修改`hbase-site.xml`中的配置 `hbase.cluster.distributed` 为 `true`。

3. 启动 HBase，`bin/start-hbase.sh`。

4. 检查 HDFS 中 HBase 的目录。`hdfs dfs -ls /hbase`。

5. 创建表，填充数据。

6. 启动和终止一个备用 HMaster 服务器，`local-master-back.sh`，终止一一个备用 HMaster，只能 `kill -9`。HMaster 控制着整个 HBase 集群。

7. 启动和终止额外的 RegionServer，`local-regionservers.sh start 2 3 4 5` 和 `local-regionservers.sh stop 3`。 RegionServer 使用 StoreFile 管理数据，直接受 HMaster 领导。通常来说，一台 HRegionServer 运行在一个节点上。一个机器上运行多个 HRegionServer 是伪分布模式。

8. 关闭 HBase，`bin/stop-hbase.sh`。

# 2.4 进阶 - 全分布式

一个全分布式的 HBase 集群包括多个节点，每个节点运行一个或多个 HBase 后台服务，包括 primary 和 backup Master、多个 ZooKeeper 节点、多个 RegionServer 节点。

假设有三个节点 node-a、node-b、node-c：

| Node Name          | Master | ZooKeeper | RegionServer |
| ------------------ | ------ | --------- | ------------ |
| node-a.example.com | yes    | yes       | no           |
| node-b.example.com | backup | yes       | yes          |
| node-c.example.com | no     | yes       | yes          |

**配置 ssh 连接**

1. node-a 上，生成 ssh key：以 `hbase` 用户登录，`ssh-keygen -t rsa`。
2. 在 node-b 和 node-c 上，创建 `~/.ssh`目录。
3. 将 node-a 的公钥拷贝到 node-b 和 node-c的 `.ssh/authorized_keys`。
4. 测试 ssh 登录。从 node-a 登录其他节点试试。
5. 因为 node-b 是备用 Master，将 HBase 的公钥也部署到其他节点。

**准备 node-a**

1. 修改`conf/regionservers`，移除`localhost`，添加 node-b 和 node-c。

2. 配置 HBase 使用 node-b 作为备用 master。创建新文件 `conf/backup-masters`，添加 node-b 的地址。

3. 配置 ZooKeeper，参考[zookeeper](http://hbase.apache.org/book.html#zookeeper)，在 node-a 上，修改`conf/hbase-site.xml`：

   ```xml
   <property>
     <name>hbase.zookeeper.quorum</name>
     <value>node-a.example.com,node-b.example.com,node-c.example.com</value>
   </property>
   <property>
     <name>hbase.zookeeper.property.dataDir</name>
     <value>/usr/local/zookeeper</value>
   </property>
   ```

4. 将所有配置中的`localhost`替换为 node-a。

**准备 node-b 和 node-c**

1. 下载、解压 HBase。
2. 复制 node-a 的配置文件到 node-b 和 node-c。

**启动、测试集群**

1. 确保 HBase 没有在任何节点上运行。
2. 启动集群：在 node-a 上，`start-hbase.sh`，ZooKeeper 会先启动，接着是 Master，然后是 RegionServer，最后是备用 Master。
3. 检查进程是否运行正常：`jps`。
4. 查看 Web UI。
5. 测试节点下线后集群的状态。

## 2.5 Next

更多配置查看 [configuration]([configuration](http://hbase.apache.org/book.html#configuration))


# 导航

[目录](README.md)

下一章：[Apache HBase Configuration](configuration.md)
