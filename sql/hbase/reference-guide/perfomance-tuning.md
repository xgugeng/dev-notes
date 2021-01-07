<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [93. 操作系统](#93-%E6%93%8D%E4%BD%9C%E7%B3%BB%E7%BB%9F)
  - [93.1 内存](#931-%E5%86%85%E5%AD%98)
  - [93.2 64 位](#932-64-%E4%BD%8D)
  - [93.3 交换空间](#933-%E4%BA%A4%E6%8D%A2%E7%A9%BA%E9%97%B4)
  - [93.4 CPU](#934-cpu)
- [94. 网络](#94-%E7%BD%91%E7%BB%9C)
  - [94.1 单交换机](#941-%E5%8D%95%E4%BA%A4%E6%8D%A2%E6%9C%BA)
  - [94.2 多交换机](#942-%E5%A4%9A%E4%BA%A4%E6%8D%A2%E6%9C%BA)
  - [94.3 多机架](#943-%E5%A4%9A%E6%9C%BA%E6%9E%B6)
  - [94.4 网络端口](#944-%E7%BD%91%E7%BB%9C%E7%AB%AF%E5%8F%A3)
  - [94.5 网络一致性和分区容错](#945-%E7%BD%91%E7%BB%9C%E4%B8%80%E8%87%B4%E6%80%A7%E5%92%8C%E5%88%86%E5%8C%BA%E5%AE%B9%E9%94%99)
- [95. Java](#95-java)
  - [95.1 GC](#951-gc)
    - [GC 暂停](#gc-%E6%9A%82%E5%81%9C)
- [96. HBase 配置](#96-hbase-%E9%85%8D%E7%BD%AE)
  - [96.1改善99分位](#961%E6%94%B9%E5%96%8499%E5%88%86%E4%BD%8D)
  - [96.2 管理 Compaction](#962-%E7%AE%A1%E7%90%86-compaction)
  - [96.3 `hbase.regionserver.hadnler.count`](#963-hbaseregionserverhadnlercount)
  - [96.4 `hfile.block.cache.size`](#964-hfileblockcachesize)
  - [96.5 BlockCache 预取](#965-blockcache-%E9%A2%84%E5%8F%96)
  - [96.6 `hbase.regionserver.global.memstore.size`](#966-hbaseregionserverglobalmemstoresize)
  - [96.7 `hbase.regionserver.global.memstore.size.lower.limit`](#967-hbaseregionserverglobalmemstoresizelowerlimit)
  - [96.8 `hbase.hstore.blockingStoreFiles`](#968-hbasehstoreblockingstorefiles)
  - [96.9 `hbase.hregion.memstore.block.multiplier`](#969-hbasehregionmemstoreblockmultiplier)
  - [96.10 `hbase.regionserver.checksum.verify`](#9610-hbaseregionserverchecksumverify)
  - [96.11 `callQueue` 选项](#9611-callqueue-%E9%80%89%E9%A1%B9)
- [97. ZooKeeper](#97-zookeeper)
- [98. Schema 设计](#98-schema-%E8%AE%BE%E8%AE%A1)
  - [98.1 列族的数量](#981-%E5%88%97%E6%97%8F%E7%9A%84%E6%95%B0%E9%87%8F)
  - [98.2 键和属性长度](#982-%E9%94%AE%E5%92%8C%E5%B1%9E%E6%80%A7%E9%95%BF%E5%BA%A6)
  - [98.3 表的 region 大小](#983-%E8%A1%A8%E7%9A%84-region-%E5%A4%A7%E5%B0%8F)
  - [98.4 Bloom 过滤器](#984-bloom-%E8%BF%87%E6%BB%A4%E5%99%A8)
    - [什么时候使用 Bloom 过滤器](#%E4%BB%80%E4%B9%88%E6%97%B6%E5%80%99%E4%BD%BF%E7%94%A8-bloom-%E8%BF%87%E6%BB%A4%E5%99%A8)
    - [开启 Bloom 过滤器](#%E5%BC%80%E5%90%AF-bloom-%E8%BF%87%E6%BB%A4%E5%99%A8)
    - [配置服务端 Bloom 过滤器的行为](#%E9%85%8D%E7%BD%AE%E6%9C%8D%E5%8A%A1%E7%AB%AF-bloom-%E8%BF%87%E6%BB%A4%E5%99%A8%E7%9A%84%E8%A1%8C%E4%B8%BA)
  - [98.5 列族 BlockSize](#985-%E5%88%97%E6%97%8F-blocksize)
  - [98.6 内存中的列族](#986-%E5%86%85%E5%AD%98%E4%B8%AD%E7%9A%84%E5%88%97%E6%97%8F)
  - [98.7 Compression](#987-compression)
    - [但是。。。](#%E4%BD%86%E6%98%AF)
- [99. HBase 通用范式](#99-hbase-%E9%80%9A%E7%94%A8%E8%8C%83%E5%BC%8F)
  - [99.1 约束](#991-%E7%BA%A6%E6%9D%9F)
- [100. 写 HBase](#100-%E5%86%99-hbase)
  - [100.1 批量加载](#1001-%E6%89%B9%E9%87%8F%E5%8A%A0%E8%BD%BD)
  - [100.2 创建表：预创建 region](#1002-%E5%88%9B%E5%BB%BA%E8%A1%A8%E9%A2%84%E5%88%9B%E5%BB%BA-region)
  - [100.3 创建表：延迟日志刷新](#1003-%E5%88%9B%E5%BB%BA%E8%A1%A8%E5%BB%B6%E8%BF%9F%E6%97%A5%E5%BF%97%E5%88%B7%E6%96%B0)
  - [100.4 HBase Client：自动 flush](#1004-hbase-client%E8%87%AA%E5%8A%A8-flush)
  - [100.5 HBase Client: 关闭 Put 的 WAL](#1005-hbase-client-%E5%85%B3%E9%97%AD-put-%E7%9A%84-wal)
  - [100.6 HBase Client：根据 RegionServer 的 Put 分组](#1006-hbase-client%E6%A0%B9%E6%8D%AE-regionserver-%E7%9A%84-put-%E5%88%86%E7%BB%84)
  - [100.7 MapReduce：跳过 Reducer](#1007-mapreduce%E8%B7%B3%E8%BF%87-reducer)
  - [100.8 反模式：一个热点 region](#1008-%E5%8F%8D%E6%A8%A1%E5%BC%8F%E4%B8%80%E4%B8%AA%E7%83%AD%E7%82%B9-region)
- [101. 读 HBase](#101-%E8%AF%BB-hbase)
  - [101.1 扫描缓存](#1011-%E6%89%AB%E6%8F%8F%E7%BC%93%E5%AD%98)
    - [MapReduce 作业的扫描缓存](#mapreduce-%E4%BD%9C%E4%B8%9A%E7%9A%84%E6%89%AB%E6%8F%8F%E7%BC%93%E5%AD%98)
  - [101.2 扫描的属性选择](#1012-%E6%89%AB%E6%8F%8F%E7%9A%84%E5%B1%9E%E6%80%A7%E9%80%89%E6%8B%A9)
  - [101.3 避免扫描查找](#1013-%E9%81%BF%E5%85%8D%E6%89%AB%E6%8F%8F%E6%9F%A5%E6%89%BE)
  - [101.4 MapReduce: 输入拆分](#1014-mapreduce-%E8%BE%93%E5%85%A5%E6%8B%86%E5%88%86)
  - [101.5 关闭 `ResultScanner`](#1015-%E5%85%B3%E9%97%AD-resultscanner)
  - [101.6 Block Cache](#1016-block-cache)
  - [101.7 RowKey 的加载](#1017-rowkey-%E7%9A%84%E5%8A%A0%E8%BD%BD)
  - [101.8 并发：监控数据分布](#1018-%E5%B9%B6%E5%8F%91%E7%9B%91%E6%8E%A7%E6%95%B0%E6%8D%AE%E5%88%86%E5%B8%83)
  - [101.9 Bloom 过滤器](#1019-bloom-%E8%BF%87%E6%BB%A4%E5%99%A8)
    - [StoreFile footprint](#storefile-footprint)
    - [Bloom 过滤器配置](#bloom-%E8%BF%87%E6%BB%A4%E5%99%A8%E9%85%8D%E7%BD%AE)
        - [`io.storefile.bloom.enabled` global kill switch](#iostorefilebloomenabled-global-kill-switch)
        - [`io.storefile.bloom.error.rate`](#iostorefilebloomerrorrate)
        - [`io.storefile.bloom.max.fold`](#iostorefilebloommaxfold)
  - [101.10 对冲读取](#10110-%E5%AF%B9%E5%86%B2%E8%AF%BB%E5%8F%96)
- [102 删除 HBase 的数据](#102-%E5%88%A0%E9%99%A4-hbase-%E7%9A%84%E6%95%B0%E6%8D%AE)
  - [102.1 使用 HBase 表作为队列](#1021-%E4%BD%BF%E7%94%A8-hbase-%E8%A1%A8%E4%BD%9C%E4%B8%BA%E9%98%9F%E5%88%97)
  - [102.2 删除 RPC](#1022-%E5%88%A0%E9%99%A4-rpc)
- [103. HDFS](#103-hdfs)
  - [103.1 低延迟读取问题](#1031-%E4%BD%8E%E5%BB%B6%E8%BF%9F%E8%AF%BB%E5%8F%96%E9%97%AE%E9%A2%98)
  - [103.2 利用本地数据](#1032-%E5%88%A9%E7%94%A8%E6%9C%AC%E5%9C%B0%E6%95%B0%E6%8D%AE)
  - [103.3 HBase 和 HDFS 的性能比较](#1033-hbase-%E5%92%8C-hdfs-%E7%9A%84%E6%80%A7%E8%83%BD%E6%AF%94%E8%BE%83)
- [104. Amazon EC2](#104-amazon-ec2)
- [105. HBase 与 MapReduce 的协作](#105-hbase-%E4%B8%8E-mapreduce-%E7%9A%84%E5%8D%8F%E4%BD%9C)
- [106. 案例](#106-%E6%A1%88%E4%BE%8B)
- [导航](#%E5%AF%BC%E8%88%AA)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# 93. 操作系统

## 93.1 内存

RAM ! RAM ! RAM ! HBase 很吃内存！

## 93.2 64 位

使用 64 位操作系统，64 位 JVM。

## 93.3 交换空间

关闭交换空间，将 `swappiness` 置为 0。

## 93.4 CPU

Hadoop 使用 native 的硬件校验和：[hadoop.native.lib]。


# 94. 网络

避免网络问题降低 HBase 性能最关键的是使用的交换设备。

## 94.1 单交换机

所有的流量都要经过这台交换机，它必须能够抗住。

## 94.2 多交换机

多交换机可能是一个陷阱。低价硬件的最常见配置是从一个交换机到另一个交换机使用简单的1Gbps上行链路。被忽视的单点很容易成为集群通信的瓶颈。特别是对于MapReduce作业，读取和写入大量数据，这种上行链路的通信可能会饱和。

缓解这个问题也很简单：

- 根据集群的规模使用适当的硬件。
- 使用较大的单交换机配置，即单个48端口，而不是2x 24端口
- 配置上行链路的端口中继，利用多个接口增加交换机带宽。

## 94.3 多机架

多机架也可能遇到遇到多交换机同样的问题：

- 交换机性能较差
- 到另一机架的上行带宽不足

跨多个机架避免问题的最简单的方法是使用端口集群来创建到其他机架的绑定上行链路。然而，该方法的缺点在于可能使用的端口开销。比如，从机架A到机架B创建一个8Gbps的端口通道，使用24个端口中的8个在机架之间进行通信，使您的投资回报率很差，但使用的数量太少可能意味着您没有充分利用簇。

## 94.4 网络端口

是否所有的网络接口都工作正常？[Case Study #1 (Performance Issue On A Single Node)](http://hbase.apache.org/book.html#casestudies.slownode)

## 94.5 网络一致性和分区容错

分布式系统的 CAP 定理：

- Consistency。所有节点看到同样的数据。
- Availability。每个请求都会收到回复，不管是成功还是失败的回复。
- Partition Tolerance。即使其中一些组件对其他组件不可用，系统也继续运行。


HBase 在一致性和分区容错上做的非常好。参见：[blog post](https://rayokota.wordpress.com/2015/09/30/call-me-maybe-hbase/)。


# 95. Java

## 95.1 GC

### GC 暂停

[Avoiding Full GCs with MemStore-Local Allocation Buffers](http://www.slideshare.net/cloudera/hbase-hug-presentation) 这篇文章里，Todd Lipcon 描述了两种 GC 引起的 stop-the-world：

- CMS 故障模式
- 老生代堆碎片

定位第一个问题，要开启`-XX:CMSInitiatingOccupancyFraction`，并降低它的值。

第二个问题，MSLAB 可以派上用场：`hbase.hregion.memstore.mslab.enabled`置为 `true`。开启后，每个 MemStore 实例将占用至少一个 MSLAB 内存实例。如果有数以千计的 region，每个 region 都有许多列族，那么 MSLAB 的这种分配对内存是个考验，甚至导致 OOM。

[HBASE-8163 MemStoreChunkPool: An improvement for JAVA GC when using MSLAB](https://issues.apache.org/jira/browse/HBASE-8163) 是对 GC 的改进，在写入大量负载期间降低年轻GC的量的配置。

[Eliminating Large JVM GC Pauses Caused by Background IO Traffic](https://engineering.linkedin.com/blog/2016/02/eliminating-large-jvm-gc-pauses-caused-by-background-io-traffic)


# 96. HBase 配置

[Recommended Configurations](http://hbase.apache.org/book.html#recommended_configurations)

## 96.1改善99分位 

hedged_reads

## 96.2 管理 Compaction

[compactions and splits

## 96.3 `hbase.regionserver.hadnler.count` 

[hbase.regionserver.handler.count](http://hbase.apache.org/book.html#hbase.regionserver.handler.count)

## 96.4 `hfile.block.cache.size`

[hfile.block.cache.size](http://hbase.apache.org/book.html#hfile.block.cache.size)

RegionServer 进程的内存设定。

## 96.5 BlockCache 预取

[HBASE-9857](https://issues.apache.org/jira/browse/HBASE-9857) 增加了 HFile 的预取选项。在缓存打开之后，使用内存中的表数据尽可能快地加热BlockCache，并且预取不计为高速缓存未命中。

## 96.6 `hbase.regionserver.global.memstore.size`

[[hbase.regionserver.global.memstore.size\]](http://hbase.apache.org/book.html#hbase.regionserver.global.memstore.size)

## 96.7 `hbase.regionserver.global.memstore.size.lower.limit`

[[hbase.regionserver.global.memstore.size.lower.limit\]](http://hbase.apache.org/book.html#hbase.regionserver.global.memstore.size.lower.limit)

## 96.8 `hbase.hstore.blockingStoreFiles`

[[hbase.hstore.blockingStoreFiles\]](http://hbase.apache.org/book.html#hbase.hstore.blockingStoreFiles)

## 96.9 `hbase.hregion.memstore.block.multiplier`

[[hbase.hregion.memstore.block.multiplier\]](http://hbase.apache.org/book.html#hbase.hregion.memstore.block.multiplier)

如果有足够的 RAM，增加这个选项能够有所助益。

## 96.10 `hbase.regionserver.checksum.verify`

HBase 将校验和存入数据块，无论何时读取数据都需查找检验和。

See [[hbase.regionserver.checksum.verify\]](http://hbase.apache.org/book.html#hbase.regionserver.checksum.verify), [[hbase.hstore.bytes.per.checksum\]](http://hbase.apache.org/book.html#hbase.hstore.bytes.per.checksum) and [[hbase.hstore.checksum.algorithm\]](http://hbase.apache.org/book.html#hbase.hstore.checksum.algorithm). For more information see the release note on [HBASE-5074 support checksums in HBase block cache](https://issues.apache.org/jira/browse/HBASE-5074).

## 96.11 `callQueue` 选项

[HBASE-11355](https://issues.apache.org/jira/browse/HBASE-11355) 引入了`callQueue`的调优选项。

`hbase.ipc.server.num.callqueue` 增加 `callQueue` 的数量。

`hbase.ipc.server.callqueue.read.ratio` 调整读和写队列的比重。

`hbase.ipc.server.callqueue.scan.ratio` 分配 Get 和 Scan 队列的比重。

`hbase.ipc.server.callqueue.handler.factor` 在程序中调节 Queue 的数量：

- 0 表示所有 handler 共享一个队列
- 1 表示每个 handler 一个队列
- 0.5 表示每两个 handler 共享一个队列


# 97. ZooKeeper

See [ZooKeeper](http://hbase.apache.org/book.html#zookeeper) for information on configuring ZooKeeper, and see the part about having a dedicated disk.

# 98. Schema 设计

## 98.1 列族的数量

[On the number of column families](http://hbase.apache.org/book.html#number.of.cfs)

## 98.2 键和属性长度

See [Try to minimize row and column sizes](http://hbase.apache.org/book.html#keysize). See also [However…](http://hbase.apache.org/book.html#perf.compression.however) for compression caveats.

## 98.3 表的 region 大小

每张表的 region 大小可调用`HTableDescriptor`上的`setFileSize`设置。

[Determining region count and size](http://hbase.apache.org/book.html#ops.capacity.regions)

## 98.4 Bloom 过滤器

Bloom 过滤器以的发明者命名，用来预测给定元素是否是一组数据的成员。它的积极结果并不总是准确的，但是否定的结果保证是准确的。

对 HBase 而言，Bloom 过滤器提供了轻量级的内存结构，可将给定 Get 操作（Bloom过滤器不适用于Scans）的磁盘读取数减少到仅包含所需行的StoreFiles。性能随并行读数的增加而提升。

Bloom 过滤器本身存储在每个 HFile 的元数据中，不需要更新。当一个 region 被部署到RegionServer时，打开一个HFile，Bloom 过滤器被加载到内存中。

HBase 包括一些调整机制，用于折叠 Bloom 过滤器以减小尺寸并将 false positive 的概率保持在所需范围内。

Bloom 过滤器在[HBASE-1200](https://issues.apache.org/jira/browse/HBASE-1200) 引入。HBase 0.96之后，基于行的 Bloom 过滤器默认开启。

### 什么时候使用 Bloom 过滤器

RegionServer 的`blockCacheHitRatio`就标识了 Bloom 过滤器的效果。Bloom 过滤器不仅可以基于行，也可以基于行+列。

如果通常扫描整行，行+列组合将不会带来任何好处。基于行的 Bloom 过滤器可以在行+列Get上操作，但反过来不行。但是，如果有大量的列级别 Puts，比如每个StoreFile中都只 Put 一行，那么基于行的过滤器将始终返回一个积极的结果，这没有任何好处。除非每行有一列，否则列+列Bloom 过滤器需要更多空间，以便存储更多的键。当每个数据条目的大小至少为几 KB 大小时，Bloom 过滤器工作最好。

如果数据存储在几个较大的 StoreFile 中时，开销将减少，以避免在低级扫描期间额外的磁盘IO来查找特定的行。

Bloom 过滤器需要在删除时进行重建。

### 开启 Bloom 过滤器

`HColumnDescriptor` 上的 `setBloomFilterType` 方法设置列族的 Bloom 过滤器。

在 HBase shell 的操作：

```
hbase> create 'mytable',{NAME => 'colfam1', BLOOMFILTER => 'ROWCOL'}
```

### 配置服务端 Bloom 过滤器的行为

| Parameter                                | Default   | Description                              |
| ---------------------------------------- | --------- | ---------------------------------------- |
| io.storefile.bloom.enabled               | yes       | 设置为 no 会关闭服务器端的过滤器                       |
| io.storefile.bloom.error.rate            | .01       | false positive 的平均比率                     |
| io.storefile.bloom.max.fold              | 7         | 保证最大折合率                                  |
| io.storefile.bloom.max.keys              | 128000000 | 指定最大数量的 key                              |
| io.storefile.delete.family.bloom.enabled | true      | Master 启动 Delete Family Bloom过滤器并将其存储在StoreFile中。 |
| io.storefile.bloom.block.size            | 131072    | 目标Bloom块大小                               |
| hfile.block.bloom.cacheonwrite           | false     | 开启 cache-on-write，针对复合 Bloom 过滤器的内联块     |

## 98.5 列族 BlockSize

每个列族都有自己的 blocksize，默认是 64K。大的 cell 值需要大的 blockssize。blocksize 和生成的 StoreFile 索引之间存在反比关系（即，如果将 blocksize 加倍，则生成的索引应大致减半）。

## 98.6 内存中的列族

列族可以被配置为 in-memory。数据仍然永久存储在磁盘。内存中的 block 在Block Cache 中最高的优先级，但不保证保证整个表都在内存中。

## 98.7 Compression

生产环境下，定义列族的时候就应该使用 Compression。

查看更多：[Compression and Data Block Encoding In HBase](https://hbase.apache.org/book.html#compression)

### 但是。。。

Compaction 减少磁盘上的数据。当它在内存中（在MemStore中）或在线上（在RegionServer和客户端之间传输）时，它被增大。所以尽管使用ColumnFamily压缩是一个最佳实践，但是不会完全消除过大尺寸的键、超大尺寸的列族名称、超大尺寸的列名的影响。


# 99. HBase 通用范式

## 99.1 约束

```java
Get get = new Get(rowkey);
Result r = table.get(get);
byte[] b = r.getValue(Bytes.toBytes("cf"), Bytes.toBytes("attr"));  // returns current version of value
```

上述写法的问题在于，将 String 转换为字节数组非常耗时，推荐下面这种写法：

```java
public static final byte[] CF = "cf".getBytes();
public static final byte[] ATTR = "attr".getBytes();

// ...
Get get = new Get(rowkey);
Result r = table.get(get);
byte[] b = r.getValue(CF, ATTR);  // returns current version of value
```


# 100. 写 HBase

## 100.1 批量加载

[Bulk Loading](https://hbase.apache.org/book.html#arch.bulk.load)

## 100.2 创建表：预创建 region

默认情况下，HBase中的表最初创建一个 region。加快批量导入过程的办法是预先创建空 region。

预创建 region 有两种办法，第一种基于`Admin`：

```java
byte[] startKey = ...;      // your lowest key
byte[] endKey = ...;        // your highest key
int numberOfRegions = ...;  // # of regions to create
admin.createTable(table, startKey, endKey, numberOfRegions);
```

另一种使用 HBase API：

```java
byte[][] splits = ...;   // create your own splits
admin.createTable(table, splits);
```

## 100.3 创建表：延迟日志刷新

Put 之后默认立即刷写 WAL。但 WAL 的刷写是可以延迟的，这样做的好处是性能得到提升，但如果 RegionServer 宕机了会损失一些数据。

可以通过 `HTableDescriptor` 在表上配置延迟日志刷新。 `hbase.regionserver.optionallogflushinterval`的默认值为1000ms。


## 100.4 HBase Client：自动 flush

执行很多 Put 时，请确保在 `Table` 实例上将 `setAutoFlush` 设置为 `false`。否则将一次发送一个 Put 到 RegionServer。通过 `table.add(Put)` 和`table.add(<List> Put)` 添加到同一写入缓冲区中。如果 `autoFlush = false`，这些消息不会被发送，直到写缓冲区被填满。要显式刷新消息，请调用 `flushCommits`。调用 `close` 表实例将触发 `flushCommits`。

## 100.5 HBase Client: 关闭 Put 的 WAL

禁用 WAL 可以提高 Put 的性能，这只在批量加载的时候有效。因为它可能会丢失数据，而批量加载可以在宕机之后重跑。

## 100.6 HBase Client：根据 RegionServer 的 Put 分组

根据 RegionServer，将 Put 分组，能够减少每个 `wirteBuffer`flush 的客户端 RPC 请求数量。

`HTableUtil`在 Master 上提供该功能。

## 100.7 MapReduce：跳过 Reducer

使用 Reducer 时，Mapper 中的所有输出（Puts）将被 spool 到磁盘，然后将其排序/shuffle 到其他可能在节点外的 Reducer。这比直接写入HBase更有效率。

## 100.8 反模式：一个热点 region

确保你的预拆分策略，能够让所有的 key 分布到不同的 region 上。

HBase 的 client 能够直接与 RegionServer 通信：`Table.getRegionLocation`。


# 101. 读 HBase

## 101.1 扫描缓存

将扫描缓存设置为 500，可以一次向 client 传输 500 行数据。

设置过高， 也会消耗不少的双方不少的内存，这是一种权衡。

### MapReduce 作业的扫描缓存

客户端返回到下一组数据的RegionServer之前处理一批记录需要更长时间，则Map任务中可能超时。如果处理行的速度很快，可以将缓存设大。

## 101.2 扫描的属性选择

`scan.addFamily` 让扫描只返回特定列族的数据，减少性能压力。

## 101.3 避免扫描查找

使用 `scan.addColumn` 显式选择列时，HBase将调度搜索操作以在所选列之间进行搜索。当行列数很、每列只有几个版本时，这可能是低效的。如果不搜索5-10列或512-1024字节，寻找操作通常较慢。

为了机会性地查看几列/版本，以查看在调度搜索操作之前是否可以找到下一列/版本，可以在 Scan 对象上设置新的属性`Scan.HINT_LOOKAHEAD`。

```java
Scan scan = new Scan();
scan.addColumn(...);
scan.setAttribute(Scan.HINT_LOOKAHEAD, Bytes.toBytes(2));
table.getScanner(scan);
```

## 101.4 MapReduce: 输入拆分

如果 MapReduce 作业使用 HBase 作为输入源，且存在一个慢的 map 任务使用同样的输入拆分，可以查阅：[Case Study #1 (Performance Issue On A Single Node)](https://hbase.apache.org/book.html#casestudies.slownode)。

## 101.5 关闭 `ResultScanner`

这个操作不能提高性能，但能规避性能问题。如果你忘了关闭 `ResultScanner`，RegionServer 可能会出现问题：

```java
Scan scan = new Scan();
// set attrs...
ResultScanner rs = table.getScanner(scan);
try {
  for (Result r = rs.next(); r != null; r = rs.next()) {
  // process result...
} finally {
  rs.close();  // always close the ResultScanner!
}
table.close()
```

## 101.6 Block Cache

Scan 实例可以使用 RegionServer 的 block cache，通过 `setCacheBlocks` 即可。对于 MapReduce 作业的 Scan，应当设置为 `false`。

对于频繁访问的行，应当使用 block cache。

将Block Cache移出堆栈可以缓存更多数据。[Off-heap Block Cache](https://hbase.apache.org/book.html#offheap.blockcache)

## 101.7 RowKey 的加载

执行仅需要 RowKey（无列族、限定符、值或时间戳）的表扫描时，使用 `setFilter` 添加一个具有 `MUST_PASS_ALL` 操作符的 `FilterList` 。过滤器列表应包括`FirstKeyOnlyFilter` 和 `KeyOnlyFilter`。使用此过滤器组合将导致 `RegionServer` 从磁盘读取单个值的最坏情况情况，并为单个行向客户端提供最小的网络流量。

## 101.8 并发：监控数据分布

当执行大量并发读取时，监视目标表的数据分布。如果目标表的 region 太少，则可能从太少的节点提供读取。

## 101.9 Bloom 过滤器

启用 Bloom 过滤器可以加快进入磁盘的速度，并有助于改善读取延迟。

HBase 0.19.X 之前有个动态版本的 Bloom 过滤器，工作地很不理想。第二版是静态的。

[HBASE-1200](https://issues.apache.org/jira/browse/HBASE-1200)

### StoreFile footprint

Bloom过滤器添加一个条目到StoreFile 通用 `FileInfo` 数据结构中，添加两个条目到 StoreFile 元数据。

- `FileInfo` 的 `BLOOM_FILTER_TYPE` 可设置为 `NONE`/`ROW`/`ROWCOL`。
- `StoreFile` 元数据的 `BLOOM_FILTER_META`，保存 Bloom 的大小、使用的哈希函数。它很小， `StoreFile.read`加载时被缓存。
- `StoreFile` 元数据的 `BLOOM_FILTER_DATA`，保存实际的过滤器数据，按需获取，存在 LRU 缓存中。

### Bloom 过滤器配置

##### `io.storefile.bloom.enabled` global kill switch

`io.storefile.bloom.enabled` in `Configuration` serves as the kill switch in case something goes wrong. Default = `true`.

##### `io.storefile.bloom.error.rate`

`io.storefile.bloom.error.rate` = false positive 的平均比率。 默认 1%。 减少 0.5% 约等于每个 Bloom 条目+1。

##### `io.storefile.bloom.max.fold`

`io.storefile.bloom.max.fold` = 确保的最小的 fold 比率。 默认 7。

## 101.10 对冲读取

Hadoop 2.4.0 引入了对冲读取。正常情况，每个读请求会触发一个线程。开启对冲读取后，Client 会等待一段时间（可配置），如果没有结果返回，Client 会再启第二个线程读取另一个 replica。这两个线程，后返回的数据被丢弃。

对冲读取可以消除瘸腿 datanode 的影响。但也会增加 RegionServer 的负载。这也是一种权衡。

另外，使用对重读还要注意 （[HBASE-17083](https://issues.apache.org/jira/browse/HBASE-17083)）：

- 可能导致网络拥堵 
- 确保线程池足够大 

因为 HBase 的 RegionServer 就是一个 HDFS 客户端，所以你可以在 HBase 中开启对冲读取：

- `dfs.client.hedged.read.threadpool.size` - 专用于服务对冲读取的线程数。如果设置为0（默认值），对冲读取被禁用。
- `dfs.client.hedged.read.threshold.millis` - 在产生第二个读取线程之前等待的毫秒数。

对冲读取的性能指标：

- hedgedReadOps - 读取线程的已触发次数。这可能表明读请求通常很慢，或者对冲读取被触发得太快。
- hedgeReadOpsWin - 对冲读取线程比原始线程更快的次数。这可能表明给定的RegionServer在处理请求时遇到问题。

# 102 删除 HBase 的数据

## 102.1 使用 HBase 表作为队列

HBase 用作队列时，必须定期执行 Major Compaction。将行标记为已删除，会产生额外的 StoreFile，读取的时候仍需要处理。

## 102.2 删除 RPC

`Table.delete(Delete)`不使用 writeBuffer，每次删除都会产生一次 RPC。批量删除请使用`Table.delete(List)`。

# 103. HDFS

## 103.1 低延迟读取问题

HDFS 就是为批处理设计的，因此低延迟的读取不是它优先考虑的。随着 HBase 的日益普及，这一变化正在改变，HDFS 已进行了一些改进。

参见：[Umbrella Jira Ticket for HDFS Improvements for HBase](https://issues.apache.org/jira/browse/HDFS-1599)

## 103.2 利用本地数据

Hadoop 1.0.0 之后，DFSClient 可以直接读取本地磁盘的数据，而不是通过 DataNode。这意味着 HBase 的 RegionServer 也不用使用 socket 与 DataNode 通信了。

参考资料：

- [Performance Talk](http://files.meetup.com/1350427/hug_ebay_jdcryans.pdf)
- [HBase, mail # dev - read short circuit](http://search-hadoop.com/m/zV6dKrLCVh1)

```xml
<property>
  <name>dfs.client.read.shortcircuit</name>
  <value>true</value>
  <description>
    This configuration parameter turns on short-circuit local reads.
  </description>
</property>
<property>
  <name>dfs.domain.socket.path</name>
  <value>/home/stack/sockets/short_circuit_read_socket_PORT</value>
  <description>
    Optional.  This is a path to a UNIX domain socket that will be used for
    communication between the DataNode and local HDFS clients.
    If the string "_PORT" is present in this path, it will be replaced by the
    TCP port of the DataNode.
  </description>
</property>
```

开启该特性需要注意目录的读取权限问题，以`hbase`用户。

## 103.3 HBase 和 HDFS 的性能比较

HBase 在批处理的表现不如 HDFS，原因在于它做的事情更多（读取 KeyValue、返回最新的行、特殊的时间戳等）。

随着时间的推移，这个差距正在缩写。


# 104. Amazon EC2

Amazon EC2 环境下的新跟那个问题很常见，因为它是共享的环境，吞吐量和专用服务器肯定不一样。所以针对它的测试要重复多次。


# 105. HBase 与 MapReduce 的协作

HBase 和 MapReduce 的集群不要混布。重型的 MapReduce 作业会影响 HBase 的实时请求处理。OLTP 和 OLAP 常常是冲突的。比如，短延迟敏感的磁盘读取将不得不等待更长的读取，试图挤出尽可能多的吞吐量。写 HBase 的 MR 作业会触发 flush 和 compaction，反过来又会使得 BlockCache 中的块失效。

如果要使用 MapReduce 处理 HBase 中的数据，则可以使用CopyTable（ship the deltas），也可以使用复制在OLAP集群上实时获取新数据。如果非要一同使用二者，最好设置 MR 使用更少的Map 和 Reduce 插槽，最好就一个。

HBase 用作 OLAP 操作时，最好以强化的方式进行设置，例如将ZooKeeper会话超时设置为更高，并为MemStores提供更多内存（该参数是Block Cache不会因为长扫描而被使用太多）。

# 106. 案例

[Apache HBase Case Studies](https://hbase.apache.org/book.html#casestudies)


# 导航

[目录](README.md)

上一章：

下一章：[Troubleshooting and Debugging Apache HBase](troubleshooting.md)
