<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [107. 一般准则](#107-%E4%B8%80%E8%88%AC%E5%87%86%E5%88%99)
- [108. 日志](#108-%E6%97%A5%E5%BF%97)
  - [108.1 日志位置](#1081-%E6%97%A5%E5%BF%97%E4%BD%8D%E7%BD%AE)
    - [NameNode](#namenode)
    - [DataNode](#datanode)
  - [108.2 日志级别](#1082-%E6%97%A5%E5%BF%97%E7%BA%A7%E5%88%AB)
    - [开启 RPC 级别日志](#%E5%BC%80%E5%90%AF-rpc-%E7%BA%A7%E5%88%AB%E6%97%A5%E5%BF%97)
  - [108.3 GC 日志](#1083-gc-%E6%97%A5%E5%BF%97)
- [109. 资源](#109-%E8%B5%84%E6%BA%90)
  - [109.1. search-hadoop.com](#1091-search-hadoopcom)
  - [109.2.  邮件列表](#1092--%E9%82%AE%E4%BB%B6%E5%88%97%E8%A1%A8)
  - [109.3. Slack](#1093-slack)
  - [109.4. IRC](#1094-irc)
  - [109.5. JIRA](#1095-jira)
- [110. 工具](#110-%E5%B7%A5%E5%85%B7)
  - [110.1 内置工具](#1101-%E5%86%85%E7%BD%AE%E5%B7%A5%E5%85%B7)
    - [Master Web 界面](#master-web-%E7%95%8C%E9%9D%A2)
    - [RegionServer Web 界面](#regionserver-web-%E7%95%8C%E9%9D%A2)
    - [zkcli](#zkcli)
  - [110.2 外部工具](#1102-%E5%A4%96%E9%83%A8%E5%B7%A5%E5%85%B7)
    - [tail](#tail)
    - [top](#top)
    - [jps](#jps)
    - [jstack](#jstack)
    - [OpenTSDB](#opentsdb)
    - [clusterssh+top](#clustersshtop)
- [111. Client](#111-client)
    - [111.1 hbase.client.scanner.max.result.size在客户端和服务器之间的不匹配导致错误的扫描结果](#1111-hbaseclientscannermaxresultsize%E5%9C%A8%E5%AE%A2%E6%88%B7%E7%AB%AF%E5%92%8C%E6%9C%8D%E5%8A%A1%E5%99%A8%E4%B9%8B%E9%97%B4%E7%9A%84%E4%B8%8D%E5%8C%B9%E9%85%8D%E5%AF%BC%E8%87%B4%E9%94%99%E8%AF%AF%E7%9A%84%E6%89%AB%E6%8F%8F%E7%BB%93%E6%9E%9C)
    - [111.2 ScannerTimeoutException 或 UnknownScannerException](#1112-scannertimeoutexception-%E6%88%96-unknownscannerexception)
    - [111.3 Thrift 和 Java API 的性能差异](#1113-thrift-%E5%92%8C-java-api-%E7%9A%84%E6%80%A7%E8%83%BD%E5%B7%AE%E5%BC%82)
  - [111.4 `Scanner.next`引发的`LeaseException`](#1114-scannernext%E5%BC%95%E5%8F%91%E7%9A%84leaseexception)
  - [111.5 正常操作触发的异常](#1115-%E6%AD%A3%E5%B8%B8%E6%93%8D%E4%BD%9C%E8%A7%A6%E5%8F%91%E7%9A%84%E5%BC%82%E5%B8%B8)
    - [111.6 压缩伴随的客户端停顿](#1116-%E5%8E%8B%E7%BC%A9%E4%BC%B4%E9%9A%8F%E7%9A%84%E5%AE%A2%E6%88%B7%E7%AB%AF%E5%81%9C%E9%A1%BF)
  - [111.7 安全的客户端连接](#1117-%E5%AE%89%E5%85%A8%E7%9A%84%E5%AE%A2%E6%88%B7%E7%AB%AF%E8%BF%9E%E6%8E%A5)
  - [111.8 ZooKeeper 客户端连接错误](#1118-zookeeper-%E5%AE%A2%E6%88%B7%E7%AB%AF%E8%BF%9E%E6%8E%A5%E9%94%99%E8%AF%AF)
  - [111.9 客户端超内存，尽管堆大小很稳定](#1119-%E5%AE%A2%E6%88%B7%E7%AB%AF%E8%B6%85%E5%86%85%E5%AD%98%E5%B0%BD%E7%AE%A1%E5%A0%86%E5%A4%A7%E5%B0%8F%E5%BE%88%E7%A8%B3%E5%AE%9A)
  - [111.10 调用 Admin 方法时的 Client slowdown](#11110-%E8%B0%83%E7%94%A8-admin-%E6%96%B9%E6%B3%95%E6%97%B6%E7%9A%84-client-slowdown)
  - [111.11 安全客户端无法连接](#11111-%E5%AE%89%E5%85%A8%E5%AE%A2%E6%88%B7%E7%AB%AF%E6%97%A0%E6%B3%95%E8%BF%9E%E6%8E%A5)
- [112. MapReduce](#112-mapreduce)
    - [112.1 你以为你在集群，其实你在本地](#1121-%E4%BD%A0%E4%BB%A5%E4%B8%BA%E4%BD%A0%E5%9C%A8%E9%9B%86%E7%BE%A4%E5%85%B6%E5%AE%9E%E4%BD%A0%E5%9C%A8%E6%9C%AC%E5%9C%B0)
  - [112.2 启动作业时的`IllegalAccessError`。](#1122-%E5%90%AF%E5%8A%A8%E4%BD%9C%E4%B8%9A%E6%97%B6%E7%9A%84illegalaccesserror)
- [113. NameNode](#113-namenode)
  - [113.1 表和 region](#1131-%E8%A1%A8%E5%92%8C-region)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# 107. 一般准则

始终从 Master 的日志开始查看。通常它总会反复地打印同一行，Google 它总会获得一些提示。

如果 HBase 里面有成百个异常和堆栈信息，通常都会有个开始的位置。仔细查阅它！

Region 自杀是很正常的，如果 `ulimit` 和 线程数没有设置好，HBase 就不能访问文件系统的文件了。另一种情况，多长的 GC 触发了 ZooKeeper session 的超时。

# 108. 日志

NameNode: `$HADOOP_HOME/logs/hadoop-<user>-namenode-<hostname>.log`

DataNode: `$HADOOP_HOME/logs/hadoop-<user>-datanode-<hostname>.log`

JobTracker: `$HADOOP_HOME/logs/hadoop-<user>-jobtracker-<hostname>.log`

TaskTracker: `$HADOOP_HOME/logs/hadoop-<user>-tasktracker-<hostname>.log`

HMaster: `$HBASE_HOME/logs/hbase-<user>-master-<hostname>.log`

RegionServer: `$HBASE_HOME/logs/hbase-<user>-regionserver-<hostname>.log`

ZooKeeper: *TODO*

## 108.1 日志位置

单机模式的 HBase，日志都在同一个机器上。但在生产模式，HBase 必须是运行在集群上的。

### NameNode

NameNode 日志在 NameNode 服务器上。HBase Master 通常在 NameNode 服务器 和 ZooKeeper 上运行。

对于较小的集群，JobTracker/ResourceManager 通常也在 NameNode 服务器上运行。

### DataNode

每个 DataNode 服务器，都有一个相对 HDFS 的 DataNode 日志、一个相对于 HBase 的 RegionServer 日志。

此外，每个 DataNode 服务器还有一个TaskTracker / NodeManager日志，用于MapReduce任务执行

## 108.2 日志级别

### 开启 RPC 级别日志

在RegionServer上启用RPC级日志记录可以了解服务器上的时序。一旦启用，日志数量会剧增，故不建议开启太长时间。

要启用RPC级日志记录，请浏览到 RegionServer UI，然后单击日志级别。将日志级别设置为包`org.apache.hadoop.ipc`（不是`hbase.ipc`）的`DEBUG`。然后tail RegionServers日志。分析。

要禁用，请将日志记录级别设置回`INFO`级别。

## 108.3 GC 日志

HBase 对内存很敏感，使用默认的 GC 会造成长时间的暂停。

打开 GC 日志：

```shell
# This enables basic gc logging to the .out file.
# export SERVER_GC_OPTS="-verbose:gc -XX:+PrintGCDetails -XX:+PrintGCDateStamps"

# This enables basic gc logging to its own file.
# export SERVER_GC_OPTS="-verbose:gc -XX:+PrintGCDetails -XX:+PrintGCDateStamps -Xloggc:<FILE-PATH>"

# This enables basic GC logging to its own file with automatic log rolling. Only applies to jdk 1.6.0_34+ and 1.7.0_2+.
# export SERVER_GC_OPTS="-verbose:gc -XX:+PrintGCDetails -XX:+PrintGCDateStamps -Xloggc:<FILE-PATH> -XX:+UseGCLogFileRotation -XX:NumberOfGCLogFiles=1 -XX:GCLogFileSize=512M"

# If <FILE-PATH> is not replaced, the log file(.gc) would be generated in the HBASE_LOG_DIR.
```

接着你应该能看到如下的 GC 日志：

```
64898.952: [GC [1 CMS-initial-mark: 2811538K(3055704K)] 2812179K(3061272K), 0.0007360 secs] [Times: user=0.00 sys=0.00, real=0.00 secs]
64898.953: [CMS-concurrent-mark-start]
64898.971: [GC 64898.971: [ParNew: 5567K->576K(5568K), 0.0101110 secs] 2817105K->2812715K(3061272K), 0.0102200 secs] [Times: user=0.07 sys=0.00, real=0.01 secs]
```

第一行看出 CMS 的标记造成了0.0007360秒的暂停。第三行，一次`minor GC`造成了 0.0101110 的暂停。

同样，开启客户端的 GC 日志（`hbase-env.sh`）：

```shell
# This enables basic gc logging to the .out file.
# export CLIENT_GC_OPTS="-verbose:gc -XX:+PrintGCDetails -XX:+PrintGCDateStamps"

# This enables basic gc logging to its own file.
# export CLIENT_GC_OPTS="-verbose:gc -XX:+PrintGCDetails -XX:+PrintGCDateStamps -Xloggc:<FILE-PATH>"

# This enables basic GC logging to its own file with automatic log rolling. Only applies to jdk 1.6.0_34+ and 1.7.0_2+.
# export CLIENT_GC_OPTS="-verbose:gc -XX:+PrintGCDetails -XX:+PrintGCDateStamps -Xloggc:<FILE-PATH> -XX:+UseGCLogFileRotation -XX:NumberOfGCLogFiles=1 -XX:GCLogFileSize=512M"

# If <FILE-PATH> is not replaced, the log file(.gc) would be generated in the HBASE_LOG_DIR .
```

# 109. 资源

## 109.1. search-hadoop.com

search-hadoop.com 索引了所有的邮件列表，可用于历史搜索。遇到 HBase 相关的问题，应该首先求助这里。

## 109.2.  邮件列表

在 [Apache HBase mailing lists](http://hbase.apache.org/mail-lists.html) 提问。`dev` 邮件列表，旨在构建 HBase 的新 feature。`user`列表用于发布 HBase 版本的问题。

使用邮件列表前，在 search-hadoop.com 上确认先前没有类似问题。花些时间想好问题，一个高质量的问题，应该包括上下文、尝试寻求答案的证据等等。

## 109.3. Slack

[http://apache-hbase.slack.com](http://apache-hbase.slack.com/) 上看看 Slack 的 channel。

## 109.4. IRC
(You will probably get a more prompt response on the Slack channel)

hbase on irc.freenode.net

## 109.5. JIRA

从 [JIRA](https://issues.apache.org/jira/browse/HBASE) 找 Hadoop/HBase 相关的 issue。


# 110. 工具

## 110.1 内置工具

### Master Web 界面

Master 默认以 16010 为 Web 接口。

Master 的 Web 界面列出了表及其定义（列族、blocksize等）、RegionServer。

从 Master 的 Web UI 可以跳转到每个 RegionServer 的 UI。

### RegionServer Web 界面

RegionServer 默认以 16030 为 Web 接口。

RegionServer Web UI 列出了在线的 region 及其起止key、RegionServer 的指标（请求、region、compactionQueueSize等）

### zkcli

`zkcli`用来定位 ZooKeeper 相关的 issue: 

```shell
./hbase zkcli -server host:port <cmd> <args>
```

## 110.2 外部工具

### tail

```shell
tail -f xxx.log
```

`-f` 自动刷新打开的文件。

### top

top 用来查看机器的资源占用情况。

SWAP 意味着频繁的交换活动，这是 Java 性能恶化的标识。

top 只能看出来 Java 程序的资源占用，要想知道是哪一个进程，按`c`。

### jps

jps 显示当前用户的每个 Java 进程的 ID。

### jstack

jstack 能够看出一个 Java 进程在看什么。它必须与 jps 命令结合使用，以获取进程 ID。它会显示一个线程列表。

### OpenTSDB

OpenTSDB 是 Ganglia 的绝佳替补，它使用 HBase 来存储所有的时间序列，而不必下调采样率。

### clusterssh+top

穷人的监控系统，容易设置，对于几台机器来说足够了。

# 111. Client

More information：[client](https://hbase.apache.org/book.html#architecture.client)

### 111.1 hbase.client.scanner.max.result.size在客户端和服务器之间的不匹配导致错误的扫描结果

如果客户端或服务器版本低于0.98.11/1.0.0，并且服务器的 `hbase.client.scanner.max.result.size` 的值比客户端要小，则到达服务器且超过`hbase.client.scanner.max.result.size` 请求可能会丢失数据。

特殊地，0.98.11 的 `hbase.client.scanner.max.result.size` 默认是2MB，其他版本的默认值更大点。

### 111.2 ScannerTimeoutException 或 UnknownScannerException 

如果从客户端到RegionServer的RPC调用之间的时间超过扫描超时，则抛出此异常。例如，如果`Scan.setCaching`设置为500，那么`next()`调用都会产生一个 RPC 请求，获取下一批500行数据。

减少setCaching值是一个选择，但是将该值设置得太低可能更加低效。

### 111.3 Thrift 和 Java API 的性能差异 

如前所述，`Scan.setCaching` 设置过大会产生性能问题。Thrift 客户端也是一样。

Thrift 客户端使用`scannerGetList(scannerId, numRows)`来设置缓存。

## 111.4 `Scanner.next`引发的`LeaseException` 

`LeaseException` 经常发生在一个缓慢/冻结的`RegionServer#next`调用中。通过 `hbase.rpc.timeout` > `hbase.regionserver.lease.period` 可以防止它。 

See more：[HBase, mail # user - Lease does not exist exceptions](http://mail-archives.apache.org/mod_mbox/hbase-user/201209.mbox/%3CCAOcnVr3R-LqtKhFsk8Bhrm-YW2i9O6J6Fhjz2h7q6_sxvwd2yw%40mail.gmail.com%3E)

## 111.5 正常操作触发的异常

0.20.0 之后，默认的`org.apache.hadoop.hbase.*`日志级别为 `DEBUG`。

你可以在客户端，打开`$HBASE_HOME/conf/log4j.properties`更改它。

### 111.6 压缩伴随的客户端停顿

客户端将大量数据插入到未优化的HBase集群中。压缩可能加剧停顿，虽然它不是问题的根源。

- 首先确保， 所有数据不是打向单个 region。
- 检查配置 `hbase.hstore.blockingStoreFiles`, `hbase.hregion.memstore.block.multiplier`, `MAX_FILESIZE` (region size), 和 `MEMSTORE_FLUSHSIZE`。

根本原因是小文件太多，等待 compact。

See more：[Long client pauses with compression](http://search-hadoop.com/m/WUnLM6ojHm1/Long+client+pauses+with+compression&subj=Long+client+pauses+with+compression)

## 111.7 安全的客户端连接

```
Secure Client Connect ([Caused by GSSException: No valid credentials provided
        (Mechanism level: Request is a replay (34) V PROCESS_TGS)])
```

上述异常是 MIT Kerberos 的`replay_cache`组件的 bug。你可以忽略这个异常，因为客户端会重试 34 次，直到 `IOException`。

## 111.8 ZooKeeper 客户端连接错误

```
11/07/05 11:26:41 WARN zookeeper.ClientCnxn: Session 0x0 for server null,
 unexpected error, closing socket connection and attempting reconnect
 java.net.ConnectException: Connection refused: no further information
        at sun.nio.ch.SocketChannelImpl.checkConnect(Native Method)
        at sun.nio.ch.SocketChannelImpl.finishConnect(Unknown Source)
        at org.apache.zookeeper.ClientCnxn$SendThread.run(ClientCnxn.java:1078)
 11/07/05 11:26:43 INFO zookeeper.ClientCnxn: Opening socket connection to
 server localhost/127.0.0.1:2181
 11/07/05 11:26:44 WARN zookeeper.ClientCnxn: Session 0x0 for server null,
 unexpected error, closing socket connection and attempting reconnect
 java.net.ConnectException: Connection refused: no further information
        at sun.nio.ch.SocketChannelImpl.checkConnect(Native Method)
        at sun.nio.ch.SocketChannelImpl.finishConnect(Unknown Source)
        at org.apache.zookeeper.ClientCnxn$SendThread.run(ClientCnxn.java:1078)
 11/07/05 11:26:45 INFO zookeeper.ClientCnxn: Opening socket connection to
 server localhost/127.0.0.1:2181
```

上述异常，要么是 ZooKeeper 挂了，要么是因为网络原因不可用了。

使用 `zkcli` 可以定位 ZooKeeper 的问题。

## 111.9 客户端超内存，尽管堆大小很稳定

[HBase, mail # user - Suspected memory leak](http://search-hadoop.com/m/ubhrX8KvcH/Suspected+memory+leak&subj=Re+Suspected+memory+leak)

[HBase, mail # dev - FeedbackRe: Suspected memory leak](http://search-hadoop.com/m/p2Agc1Zy7Va/MaxDirectMemorySize+Was%253A+Suspected+memory+leak&subj=Re+FeedbackRe+Suspected+memory+leak)

workaround 是使用`-XX:MaxDirectMemorySize`传给客户端 JVM 一个合理的值。默认情况下，`MaxDirectMemorySize`等于`-Xmx`。把它设置小一点，但过小会触发 `FullGC`。

## 111.10 调用 Admin 方法时的 Client slowdown

[HBASE-5073](https://issues.apache.org/jira/browse/HBASE-5073) fix 了这个 bug。

起因，客户端有一个ZooKeeper漏洞，客户端调用 Admin API 的时候会被ZooKeeper事件淹没。

## 111.11 安全客户端无法连接

Caused by GSSException: No valid credentials provided(Mechanism level: Failed to find any Kerberos tgt)

1. 检查 Kerberos ticket 是否有效。
2. 查看 [Java Security Guide troubleshooting section](http://docs.oracle.com/javase/1.5.0/docs/guide/security/jgss/tutorials/Troubleshooting.html)
3. 根据 Kerberos 配置，安装 [Java Cryptography Extension](http://docs.oracle.com/javase/1.4.2/docs/guide/security/jce/JCERefGuide.html)。


# 112. MapReduce

### 112.1 你以为你在集群，其实你在本地

使用 `ImportTsv` 时，可能会出现以下问题：

```
    WARN mapred.LocalJobRunner: job_local_0001
java.lang.IllegalArgumentException: Can't read partitions file
       at org.apache.hadoop.hbase.mapreduce.hadoopbackport.TotalOrderPartitioner.setConf(TotalOrderPartitioner.java:111)
       at org.apache.hadoop.util.ReflectionUtils.setConf(ReflectionUtils.java:62)
       at org.apache.hadoop.util.ReflectionUtils.newInstance(ReflectionUtils.java:117)
       at org.apache.hadoop.mapred.MapTask$NewOutputCollector.<init>(MapTask.java:560)
       at org.apache.hadoop.mapred.MapTask.runNewMapper(MapTask.java:639)
       at org.apache.hadoop.mapred.MapTask.run(MapTask.java:323)
       at org.apache.hadoop.mapred.LocalJobRunner$Job.run(LocalJobRunner.java:210)
Caused by: java.io.FileNotFoundException: File _partition.lst does not exist.
       at org.apache.hadoop.fs.RawLocalFileSystem.getFileStatus(RawLocalFileSystem.java:383)
       at org.apache.hadoop.fs.FilterFileSystem.getFileStatus(FilterFileSystem.java:251)
       at org.apache.hadoop.fs.FileSystem.getLength(FileSystem.java:776)
       at org.apache.hadoop.io.SequenceFile$Reader.<init>(SequenceFile.java:1424)
       at org.apache.hadoop.io.SequenceFile$Reader.<init>(SequenceFile.java:1419)
       at org.apache.hadoop.hbase.mapreduce.hadoopbackport.TotalOrderPartitioner.readPartitions(TotalOrderPartitioner.java:296)
```

`LocalJobRunner` 意味着作业运行在本地，而不是集群。

解决这个问题，得让`HADOOP_CLASSPATH`包括 HBase 的依赖：

```
HADOOP_CLASSPATH=`hbase classpath` hadoop jar $HBASE_HOME/hbase-server-VERSION.jar rowcounter usertable
```

## 112.2 启动作业时的`IllegalAccessError`。

[HBASE-10304 Running an hbase job jar: IllegalAccessError: class com.google.protobuf.ZeroCopyLiteralByteString cannot access its superclass com.google.protobuf.LiteralByteString](https://issues.apache.org/jira/browse/HBASE-10304)

[HBASE-11118 non environment variable solution for "IllegalAccessError: class com.google.protobuf.ZeroCopyLiteralByteString cannot access its superclass com.google.protobuf.LiteralByteString"](https://issues.apache.org/jira/browse/HBASE-11118)

启动 Spark 作业时，也会有这个 issue：[HBASE-10877 HBase non-retriable exception list should be expanded](https://issues.apache.org/jira/browse/HBASE-10877)


# 113. NameNode

See more: [HDFS](https://hbase.apache.org/book.html#arch.hdfs)

## 113.1 表和 region

