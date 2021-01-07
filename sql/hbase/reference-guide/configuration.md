<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [3. 配置文件](#3-%E9%85%8D%E7%BD%AE%E6%96%87%E4%BB%B6)
- [4. 基本前提](#4-%E5%9F%BA%E6%9C%AC%E5%89%8D%E6%8F%90)
  - [4.1 Hadoop](#41-hadoop)
    - [`dfs.datanode.max.transfer.threads`](#dfsdatanodemaxtransferthreads)
  - [4.2 ZooKeeper 要求](#42-zookeeper-%E8%A6%81%E6%B1%82)
- [5.HBase 运行模式：单机和分布式](#5hbase-%E8%BF%90%E8%A1%8C%E6%A8%A1%E5%BC%8F%E5%8D%95%E6%9C%BA%E5%92%8C%E5%88%86%E5%B8%83%E5%BC%8F)
  - [5.1 单机 HBase](#51-%E5%8D%95%E6%9C%BA-hbase)
- [5.2 分布式](#52-%E5%88%86%E5%B8%83%E5%BC%8F)
    - [伪分布式](#%E4%BC%AA%E5%88%86%E5%B8%83%E5%BC%8F)
  - [5.3 全分布式](#53-%E5%85%A8%E5%88%86%E5%B8%83%E5%BC%8F)
- [6. 运行 HBase](#6-%E8%BF%90%E8%A1%8C-hbase)
- [7. 默认配置](#7-%E9%BB%98%E8%AE%A4%E9%85%8D%E7%BD%AE)
  - [7.2 HBase 默认配置](#72-hbase-%E9%BB%98%E8%AE%A4%E9%85%8D%E7%BD%AE)
  - [7.3 `hbase-env.sh`](#73-hbase-envsh)
  - [7.4 `log4j.properties`](#74-log4jproperties)
  - [7.5 客户端配置和依赖](#75-%E5%AE%A2%E6%88%B7%E7%AB%AF%E9%85%8D%E7%BD%AE%E5%92%8C%E4%BE%9D%E8%B5%96)
    - [Java 客户端配置](#java-%E5%AE%A2%E6%88%B7%E7%AB%AF%E9%85%8D%E7%BD%AE)
- [8. 配置示例](#8-%E9%85%8D%E7%BD%AE%E7%A4%BA%E4%BE%8B)
    - [`hbase-site.xml`](#hbase-sitexml)
    - [`regionservers`](#regionservers)
    - [`hbase-env.sh`](#hbase-envsh)
- [9. 重要配置](#9-%E9%87%8D%E8%A6%81%E9%85%8D%E7%BD%AE)
- [9.1 必须的配置](#91-%E5%BF%85%E9%A1%BB%E7%9A%84%E9%85%8D%E7%BD%AE)
    - [超大集群的配置](#%E8%B6%85%E5%A4%A7%E9%9B%86%E7%BE%A4%E7%9A%84%E9%85%8D%E7%BD%AE)
- [9.2 推荐配置](#92-%E6%8E%A8%E8%8D%90%E9%85%8D%E7%BD%AE)
    - [ZooKeeper 配置](#zookeeper-%E9%85%8D%E7%BD%AE)
    - [HDFS 配置](#hdfs-%E9%85%8D%E7%BD%AE)
    - [`hbase.regionserver.handler.count`](#hbaseregionserverhandlercount)
    - [大内存机器的配置](#%E5%A4%A7%E5%86%85%E5%AD%98%E6%9C%BA%E5%99%A8%E7%9A%84%E9%85%8D%E7%BD%AE)
    - [压缩](#%E5%8E%8B%E7%BC%A9)
    - [WAL 配置](#wal-%E9%85%8D%E7%BD%AE)
    - [拆分](#%E6%8B%86%E5%88%86)
    - [Compaction](#compaction)
    - [推测执行](#%E6%8E%A8%E6%B5%8B%E6%89%A7%E8%A1%8C)
- [9.3 其他选项](#93-%E5%85%B6%E4%BB%96%E9%80%89%E9%A1%B9)
    - [平衡器](#%E5%B9%B3%E8%A1%A1%E5%99%A8)
    - [关闭 BlockCache](#%E5%85%B3%E9%97%AD-blockcache)
  - [Nagle's 或者小包问题](#nagles-%E6%88%96%E8%80%85%E5%B0%8F%E5%8C%85%E9%97%AE%E9%A2%98)
    - [Better Mean Time to Recover (MTTR)](#better-mean-time-to-recover-mttr)
    - [JMX](#jmx)
- [10. 动态配置](#10-%E5%8A%A8%E6%80%81%E9%85%8D%E7%BD%AE)
- [导航](#%E5%AF%BC%E8%88%AA)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# 3. 配置文件

所有的配置文件都在`conf/`目录下，它需要在所有节点间保持同步。

**backup-masters**

默认没有这个文件，它是一个纯文本，在 Master 上，列出了所有的备用 Master 进程。

一行一个 host。

**hadoop-metrics2-hbase.properties**

用来连接 HBase Hadoop Metrics 2 框架。默认里面都是注释掉的 example。

**hbase-env.sh**

UNIX 环境下设置工作环境的脚本，包括 JAVA 选项和其他环境变量。

**hbase-policy.xml**

RPC 服务器用来鉴权的配置，只有在 HBase security 开启的情况下生效。

**hbase-site.xml**

HBase 的主要配置文件，它会覆盖 HBase 的默认选项 `docs/hbase-default.xml`。从 Web UI 可以查看该配置文件的详情。

**log4j.properties**

`log4j`日志的配置。

**regionservers**

包含 host 列表的纯文本，每一行表示一台 RegionServer，不应该有`localhost`。



# 4. 基本前提

| HBase Version | JDK 7                                    | JDK 8                                    |
| ------------- | ---------------------------------------- | ---------------------------------------- |
| 2.0           | [Not Supported](http://search-hadoop.com/m/YGbbsPxZ723m3as) | yes                                      |
| 1.3           | yes                                      | yes                                      |
| 1.2           | yes                                      | yes                                      |
| 1.1           | yes                                      | Running with JDK 8 will work but is not well tested. |

**操作系统相关**

- ssh。HBase 使用 ssh 进行节点间的通信。每个 Server 上必须运行着 ssh。
- DNS。HBase 使用本地的 hostname 来自报 IP 它的 IP 地址。`hadoop-dns-checker`工具可用来检查集群的 DNS 是否正确。
- 回环 IP。HBase 0.96.0 以前，必须使用 `127.0.0.1` 指向 `localhost`。
- Network Time Protocol。节点的时钟必须同步，少许误差可以接受，但大的偏离会引发不确定的后果。 推荐在集群中运行 NTP 服务。
- ulimit，至少 10, 000 。估算需要打开的文件数：(StoreFiles per ColumnFamily) x (regions per RegionServer)
- Linux Shell，必须是 GNU Bash shell。

## 4.1 Hadoop

HBase 与 Hadoop 的版本对应关系：

|                     | HBase-1.1.x | HBase-1.2.x | HBase-1.3.x | HBase-2.0.x |
| ------------------- | ----------- | ----------- | ----------- | ----------- |
| Hadoop-2.0.x-alpha  | X           | X           | X           | X           |
| Hadoop-2.1.0-beta   | X           | X           | X           | X           |
| Hadoop-2.2.0        | NT          | X           | X           | X           |
| Hadoop-2.3.x        | NT          | X           | X           | X           |
| Hadoop-2.4.x        | S           | S           | S           | X           |
| Hadoop-2.5.x        | S           | S           | S           | X           |
| Hadoop-2.6.0        | X           | X           | X           | X           |
| Hadoop-2.6.1+       | NT          | S           | S           | S           |
| Hadoop-2.7.0        | X           | X           | X           | X           |
| Hadoop-2.7.1+       | NT          | S           | S           | S           |
| Hadoop-2.8.0        | X           | X           | X           | X           |
| Hadoop-3.0.0-alphax | NT          | NT          | NT          | NT          |

- "S" = supported
- "X" = not supported
- "NT" = Not tested

### `dfs.datanode.max.transfer.threads`

HDFS DataNode 对同时可用的文件有个上限，设置`dfs.datanode.max.transfer.threads` 然后重启 HDFS。

## 4.2 ZooKeeper 要求

要求ZooKeeper 3.4.x ，HBase 需要其 `multi` 功能，需要将 `hbase.zookeeper.useMulti`设置为 `true`。



# 5.HBase 运行模式：单机和分布式

## 5.1 单机 HBase

单机模式上，HBase 不使用 HDFS，而是使用本地文件系统。所有的 HBase 后台服务和本地 ZooKeeper 全部在一个 JVM 中。

单机模式的 HBase 也可以使用 HDFS：

```xml
<configuration>
  <property>
    <name>hbase.rootdir</name>
    <value>hdfs://namenode.example.org:8020/hbase</value>
  </property>
  <property>
    <name>hbase.cluster.distributed</name>
    <value>false</value>
  </property>
</configuration>
```

# 5.2 分布式

分布式又分为伪分布式和全分布式，前者所有的后台服务跑在单节点，后者是跑在各个节点。

伪分布式可以使用本地文件系统，也可以使用 HDFS。全分布式只能使 HDFS。

### 伪分布式

 伪分布式最好用来做 HBase 的测试和原型设计，不要用于估计生产环境的 HBase 性能。

 ## 5.3 全分布式

默认情况下，HBase 是单机模式。

在全分布式下，集群的节点被配置为 RegionServer、ZooKeeper QuorumPeers、备用 HMaster。RegionServer 运行在不同的节点上，包括主备 Master。

**HDFS 客户端配置**

如果你修改了 HDFS 的客户端配置，必须通知 HBase，以下方法可选其一：

- `hbase-env.sh` 修改 `HBASE_CLASSPATH`，添加一个指向 `HADOOP_CONF_DIR` 的引用。
- 软连接 `hdfs-site.xml` 到 HBase 的`conf`目录。
- 如果只改了小部分的 HDFS 客户端配置，将它们添加到 `hbase-site.xml`。


# 6. 运行 HBase

首先确保 HDFS 运行正常。启动和终止 HDFS 采用 `bin/start-hdfs.sh`，使用`put`或 `get` 来测试 HDFS

HBase 不需要 MapReduce 和 Yarn，没必要启动它们。

如果有独立的 ZooKeeper，启动它。没有的话，HBase 会代劳。

启动 HBase: `bin/start-hbase.sh`。

默认情况下 Master 的端口 16010 会暴露 Web UI。

终止 HBase：`bin/stop-hbase.sh`。


# 7. 默认配置

HBase 的自定义配置在`conf/hbase-site.xml`文件中，默认配置在`hbase-default.xml`中。配置文件的修改需要重启 HBase 集群。

## 7.2 HBase 默认配置

[HBase 默认配置](default-configuration.md)

## 7.3 `hbase-env.sh`

该文件设置 HBase 的环境变量，包括堆大小、gc 配置、日志目录、nice 值、ssh 选项、pid 存放路径。

修改需要重启才能生效。

## 7.4 `log4j.properties`

日志的相关配置，包括日志的级别、roll 的速度。

修改也需要重启才能生效。

## 7.5 客户端配置和依赖

如果是单机模式的 HBase，那么 client 不需要额外的配置。

Master 可能会转移，client 需要询问 ZooKeeper 来请求它的地址。ZooKeeper 集群的位置保存在 `hbase-site.xml` 中，从 `CLASSPATH` 加载。

HBase 的客户端你最少需要将以下类纳入`CLASSPATH`才能连接集群：

```
commons-configuration (commons-configuration-1.6.jar)
commons-lang (commons-lang-2.5.jar)
commons-logging (commons-logging-1.1.1.jar)
hadoop-core (hadoop-core-1.0.0.jar)
hbase (hbase-0.92.0.jar)
log4j (log4j-1.2.16.jar)
slf4j-api (slf4j-api-1.5.8.jar)
slf4j-log4j (slf4j-log4j12-1.5.8.jar)
zookeeper (zookeeper-3.4.2.jar)
```

`hbase-site.xml` 配置如下：

```xml
<configuration>
  <property>
    <name>hbase.zookeeper.quorum</name>
    <value>example1,example2,example3</value>
    <description>The directory shared by region servers.
    </description>
  </property>
</configuration>
```

### Java 客户端配置

Java 客户端的配置使用 `HBaseConfiguration` 实例。

`HBaseConfiguration.create()`先读取`CLASSPATH`下的`hbase-site.xml`，也可以在代码里配置：

```java
Configuration config = HBaseConfiguration.create();
config.set("hbase.zookeeper.quorum", "localhost");  // Here we are running zookeeper locally
```


# 8. 配置示例

### `hbase-site.xml`

```xml
<?xml version="1.0"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
  <property>
    <name>hbase.zookeeper.quorum</name>
    <value>example1,example2,example3</value>
    <description>The directory shared by RegionServers.
    </description>
  </property>
  <property>
    <name>hbase.zookeeper.property.dataDir</name>
    <value>/export/zookeeper</value>
    <description>Property from ZooKeeper config zoo.cfg.
    The directory where the snapshot is stored.
    </description>
  </property>
  <property>
    <name>hbase.rootdir</name>
    <value>hdfs://example0:8020/hbase</value>
    <description>The directory shared by RegionServers.
    </description>
  </property>
  <property>
    <name>hbase.cluster.distributed</name>
    <value>true</value>
    <description>The mode the cluster will be in. Possible values are
      false: standalone and pseudo-distributed setups with managed ZooKeeper
      true: fully-distributed with unmanaged ZooKeeper Quorum (see hbase-env.sh)
    </description>
  </property>
</configuration>
```

### `regionservers`

```
example1
example2
example3
example4
example5
example6
example7
example8
example9
```

### `hbase-env.sh`

```bash
# The java implementation to use.
export JAVA_HOME=/usr/java/jdk1.8.0/

# The maximum amount of heap to use. Default is left to JVM default.
export HBASE_HEAPSIZE=4G
```


# 9. 重要配置

# 9.1 必须的配置

### 超大集群的配置

有众多 region 的集群，某台 RegionServer 可以在 Master 启动后快速登记，而其他的 RegionServer 可能慢点。这台 RegionServer 会被指派所有的 reigon。这种情况肯定是不是最优的，调大 `hbase.master.wait.on.regionservers.mintostart`，默认是1.

# 9.2 推荐配置

### ZooKeeper 配置

`zookeeper.session.timeout` 默认三分钟。这意味着当某台服务器宕机，在 Master 察觉之前有3分钟的时间差。在调小这个数值之前，确保你的 GC 没有问题。

### HDFS 配置

`dfs.datanode.failed.volumes.tolerated` DataNode 停止服务前运行失败的物理卷的最大个数。默认设置里，任何物理卷的错误都会引发 DataNode 的关闭。

### `hbase.regionserver.handler.count`

RegionServer 打开的最大线程个数，用来相应用户表的请求。如果每次请求的数据再 MB 级别，应该将该值调低，反之就调高。正在执行的查询最大数量受`hbase.ipc.server.max.callqueue.size` 控制。

这个值过高，可能触发 OOM。

### 大内存机器的配置

TODO

### 压缩

打开列族的压缩选项，减少了 StoreFile 的大小，也缓解了 I/O。

### WAL 配置

WAL 文件应该比 HDFS 块小一点点，默认 HDFS 块是 64MB，WAL 文件时 60MB 左右。 

HBase 针对 WAL 文件数量也有个上限，这个值的选定要参考 MemStore。

### 拆分

当一个 region 增长到 `hbase.hregion.max.filesize` 大小，就会被拆分。多数情况下，应该使用自动拆分。

HBase 0.90.0 引入了手动拆分。除非你明确知道自己的 key 空间，否则别选择手动拆分。

欲拆分也是一个办法，拆分后 region 的数量依赖于region 中最大的 StoreFile 大熊啊。

### Compaction

默认情况下，Major Compaction 每个七天执行一次。如果你想更精确得使用 Major Compaction，看看 `hbase.hregion.majorcompaction`。

### 推测执行

MapReduce 的推测执行默认打开。HBase 集群建议关闭：``mapreduce.map.speculative` and `mapreduce.reduce.speculative` 设置为 `false`。

# 9.3 其他选项

### 平衡器

Master 定期运行一个 balancer 来重新分配集群中的 region，执行间隔由 `hbase.balancer.period` 控制。

### 关闭 BlockCache

不要关闭 BlockCache（将`hfile.block.cache.size 设置为 0）。

## Nagle's 或者小包问题

如果偶尔看到 HBase 操作的延迟，试一下 Nagle's 算法。

### Better Mean Time to Recover (MTTR)

MTTR 让服务器更快地从失败后恢复服务。

RegionServer 的配置：

```xml
<property>
  <name>hbase.lease.recovery.dfs.timeout</name>
  <value>23000</value>
  <description>How much time we allow elapse between calls to recover lease.
  Should be larger than the dfs timeout.</description>
</property>
<property>
  <name>dfs.client.socket-timeout</name>
  <value>10000</value>
  <description>Down the DFS timeout from 60 to 10 seconds.</description>
</property>
```

NameNode 和 DataNode 的配置：

```xml
<property>
  <name>dfs.client.socket-timeout</name>
  <value>10000</value>
  <description>Down the DFS timeout from 60 to 10 seconds.</description>
</property>
<property>
  <name>dfs.datanode.socket.write.timeout</name>
  <value>10000</value>
  <description>Down the DFS timeout from 8 * 60 to 10 seconds.</description>
</property>
<property>
  <name>ipc.client.connect.timeout</name>
  <value>3000</value>
  <description>Down from 60 seconds to 3.</description>
</property>
<property>
  <name>ipc.client.connect.max.retries.on.timeouts</name>
  <value>2</value>
  <description>Down from 45 seconds to 3 (2 == 3 retries).</description>
</property>
<property>
  <name>dfs.namenode.avoid.read.stale.datanode</name>
  <value>true</value>
  <description>Enable stale state in hdfs</description>
</property>
<property>
  <name>dfs.namenode.stale.datanode.interval</name>
  <value>20000</value>
  <description>Down from default 30 seconds</description>
</property>
<property>
  <name>dfs.namenode.avoid.write.stale.datanode</name>
  <value>true</value>
  <description>Enable stale state in hdfs</description>
</property>
```

### JMX

JMX 提供了内置的机制服务于 JVM 的监控和管理。要远程监控和管理主机，启动 JVM 的时候打开系统属性`com.sun.management.jmxremote.port`。

另外，你可使用HBase 听的协处理 JMX：

```xml
<property>
  <name>hbase.coprocessor.regionserver.classes</name>
  <value>org.apache.hadoop.hbase.JMXListener</value>
</property>
```



# 10. 动态配置

HBase 1.0.0 之后，server 启动后可以动态修改配置。HBase shell 中，`update_config` 和 `update_all_config`命令能够让一个和全部 server 重新加载配置。

支持动态调整的参数包括：`hbase.regionserver.thread.compaction.large`, `hbase.regionserver.thread.compaction.small`, `hbase.regionserver.thread.split`, `hbase.regionserver.thread.merge`。还有compaction 策略、offpeak hours。

完整列表在：[HBASE-12147 Porting Online Config Change from 89-fb](https://issues.apache.org/jira/browse/HBASE-12147)



# 导航

[目录](README.md)

上一章：[Getting Started](getting-started.md)

下一章：[Upgrading](upgrading.md)
