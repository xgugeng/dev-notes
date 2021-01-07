**hbase.tmp.dir**

本地文件系统上的临时目录。注：`/tmp`目录重启后清空。

默认：`${java.io.tmpdir}/hbase-${user.name}`

**hbase.rootdir**

RegionServer 共享的目录，URL 必须包括文件系统 Schema。

默认：${hbase.tmp.dir}/hbase

**hbase.fs.tmp.dir**

一个 staging 目录，保存临时数据。

默认：` /user/${user.name}/hbase-staging`

**hbase.cluster.distributed**

表明集群所处的模式，单机或分布式。

默认：`false`

**hbase.zookeeper.quorum**

ZooKeeper 服务器的列表，若果`hbase-env.sh`中设置了`HBASE_MANAGES_ZK`，那么 HBase 就负责启动、停止 ZooKeeper。从客户端看来，这个列表和`hbase.zookeeper.clientPort`一起传递给 ZooKeeper 构造器，用作`connectString`的参数。

默认：`localhost`

**zookeeper.recovery.retry.maxsleeptime**

ZooKeeper 重试操作的最大休眠时间。

默认：60000

**hbase.local.dir**

本地文件系统的目录，用来本地存储。

默认：`${hbase.tmp.dir}/local/`

**hbase.master.port**

Master 绑定的端口

默认：16000

**hbase.master.info.port**

Master 的 Web UI 端口

默认：16010

**hbase.master.info.bindAddress**

Master Web UI 的绑定地址

默认：0.0.0.0

**hbase.master.logcleaner.plugins**

`LogsCleaner`服务用到的` BaseLogCleanerDelegate`列表。这些 WAL cleaner 会顺序调用。

默认：`org.apache.hadoop.hbase.master.cleaner.TimeToLiveLogCleaner`

**hbase.master.logcleaner.ttl**

WAL 停留在 `.oldlogdir` 目录中的最大时间，之后就被 Master 线程清理掉。

默认：600000

**hbase.master.hfilecleaner.plugins**

`HFileCleaner`服务用到的`BaseHFileCleanerDelegate`列表。

默认：`org.apache.hadoop.hbase.master.cleaner.TimeToLiveHFileCleaner`

**hbase.master.infoserver.redirect**

Master 是否监听 Master Web UI 端口，并将请求重定向到 Master 和 RegionServer 共享的 Web UI 服务器。

默认：`true`

**hbase.regionserver.port**

RegionServer 绑定的端口。

默认：16020

**hbase.regionserver.info.port**

RegionServer 的 Web UI 端口

默认：16030

**hbase.regionserver.info.bindAddress**

RegionServer Web UI 的绑定地址

默认：0.0.0.0

**hbase.regionserver.info.port.auto**

Master 或 RegionServer 是否应该查找一个能够绑定的端口。生产环境一般不用，直接 `hbase.regionserver.info.port`。

默认：`false`

**hbase.regionserver.handler.count**

RegionServer 上启动的 RPC 处理实例的数量，同样的属性 Master 上也有。

默认：30

**hbase.ipc.server.callqueue.handler.factor**

调用队列数量的因子。0 意味着所有的 handlers 共享一个队列。1 意味着每个 handler 都有自己的队列。

默认：0.1

**hbase.ipc.server.callqueue.read.ratio**

将调用队列拆分为读和写两个队列。0 意味着不拆分调用队列，即读和写请求都被 push 到该队列。0.5 意味着有相同数量的读队列和写队列。1.0 意味着除了一个之外的所有队列，都用于分发读请求。

默认：0

**hbase.ipc.server.callqueue.scan.ratio**

给定读队列的数量，设定 `get` 和 `scan` 队列的比例。比如设置为0.1，表示1个队列用于scan请求，另外8个用于get请求。

默认：0

**hbase.regionserver.msginterval**

RegionServer 到 Master 消息的时间间隔。

默认：3000

**hbase.regionserver.logroll.period**

滚动日志的周期，不管日志中包含多少个修改。

默认：3600000

**hbase.regionserver.logroll.errors.tolerated**

触发服务器终止之前允许的 连续的WAL 关闭错误数量。0 意味着在log rolling 时关闭当前 WAL writer，服务器会终止。设置一个小数值，允许 RegionServer 无视一些 HDFS 错误。

默认：2

**hbase.regionserver.hlog.reader.impl**

WAL file reader 的实现。

默认：`org.apache.hadoop.hbase.regionserver.wal.ProtobufLogReader`

同样的 hbase.regionserver.hlog.writer.impl，默认是：`org.apache.hadoop.hbase.regionserver.wal.ProtobufLogWriter`。

**hbase.regionserver.global.memstore.size**

在更新和刷写之前，一台 RegionServer 上允许的所有 MemStore 的 最大大小。默认是 0.4 倍的堆大小。

如果总大小达到了 `hbase.regionserver.global.memstore.size.lower.limit`，更新会被阻塞、刷写会被强制执行。这个值默认为空，让位于`hbase.regionserver.global.memstore.size.lower.limit`。

默认：none。

**hbase.regionserver.global.memstore.size.lower.limit**

刷写被强制执行前，一台 RegionServer 上所有 MemStore 的最大大小。默认是 `hbase.regionserver.global.memstore.size` 的 95%。100% 意味着 MemStore 限制让更新阻塞的时候，只会引发最小的可能的刷写。默认选项留空，让位于`hbase.regionserver.global.memstore.lowerLimit`。

默认：none。

**hbase.regionserver.optionalcacheflushinterval**

在被自动刷写前，一个修改在内存中的最长存活时间。默认一小时，设置为0表示禁用自动刷写。

默认：3600000

**hbase.regionserver.dns.interface**

RegionServer 报告 IP 地址的网络接口名字。

默认：`default`。

**hbase.regionserver.dns.nameserver**

RegionServer 使用的 DNS 主机名或 IP 地址，RegionServer 据此与 Master 通信。

默认：`default`。

**hbase.regionserver.region.split.policy**

决定 region 何时被拆分的策略。可选项包括：BusyRegionSplitPolicy, ConstantSizeRegionSplitPolicy, DisabledRegionSplitPolicy, DelimitedKeyPrefixRegionSplitPolicy, and KeyPrefixRegionSplitPolicy。

默认：`org.apache.hadoop.hbase.regionserver.SteppingSplitPolicy`。

**hbase.regionserver.regionSplitLimit**

region 的数量限制，在此数字之后，region 就不能再拆分了。这不是硬性限制，只是个参考。

默认：1000。

**zookeeper.session.timeout**

ZooKeeper 的 session 超时时间。使用的情境有两个：

1. ZK 客户端使用，HBase 来连接 ZK 集群。
2. HBase 启动 ZK 服务器的时候，传递给`maxSesstionTimeout`。

默认：90000

**zookeeper.znode.parent**

ZooKeeper 的 Root Znode。HBase 的所有 ZooKeeper 文件都被配置为该节点下的相对地址。

默认：`/hbase`。

**ookeeper.znode.acl.parent**

访问控制列表 (access control list) 的Root ZNode。

默认：`acl`。

**hbase.zookeeper.dns.interface**

ZooKeeper 服务器报告自己 IP 地址的网络接口名。

默认：`default`。

**hbase.zookeeper.dns.nameserver**

ZooKeeper 服务器使用的主机名或 IP 地址，它据此实现与 Master 的通信。

默认：`default`。

**hbase.zookeeper.peerport**

ZooKeeper peer 用来相互沟通的端口。

默认：2888。

**hbase.zookeeper.leaderport**

ZooKeeper 用来选举领导的端口。

默认：3888。

**hbase.zookeeper.property.initLimit**

ZooKeeper `zoo.cfg` 的属性。首次同步阶段花费的时钟节拍。

默认：10。

**hbase.zookeeper.property.syncLimit**

ZooKeeper `zoo.cfg` 的属性。发送一个请求和收到一个确认之间的时钟节拍。

默认：5。

**hbase.zookeeper.property.dataDir**

ZooKeeper `zoo.cfg` 的属性。快照存放的目录。

默认：`${hbase.tmp.dir}/zookeeper`。

**hbase.zookeeper.property.clientPort**

ZooKeeper `zoo.cfg` 的属性。client 连接的端口。

默认：2181。

**hbase.zookeeper.property.maxClientCnxns**

ZooKeeper `zoo.cfg` 的属性。单个 client 并发连接数的限制，以 IP 来区分独立 client。

默认：300。

**hbase.client.write.buffer**

HTable 客户端写缓冲的大小。数值调大，会占用 client 和 server 的内存，也减少了 RPC 请求的次数。`hbase.client.write.buffer * hbase.regionserver.handler.count` 就是服务器端的内存占用。

默认：2097152。

**hbase.client.pause**

通用的 client 暂定值。常用来作为 get 失败重试、region 查找等。

默认：100。


**hbase.client.pause.cqtbe**

是否为 `CallQueueTooBigException` 使用一个特殊的 client 暂定值。

默认：none。

**hbase.client.retries.number**

最大重试次数。所有操作的最大重试次数，包括 get，row 更新等。重试的间隔基于`hbase.client.pause`。首次重试是 `hbase.client.pause`间隔，接下来就是退避算法。

默认：35。

**hbase.client.max.total.tasks**

一个 HTable 实例发送给集群的最多的并行修改任务。

默认：100。

**hbase.client.max.perserver.tasks**

一个 HTable  实例发送给单台 RegionServer 的最多并发修改任务。

默认：5。

**hbase.client.max.perregion.tasks**

client 维护的和单个 region 的最多并行修改任务。如果已经有`hbase.client.max.perregion.tasks`个任务在往这个 region 中写，那么新的`Put`请求会不会被发送到这个 region。

默认：1。

TODO
