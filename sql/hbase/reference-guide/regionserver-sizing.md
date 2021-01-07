<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [34. 列族的数量](#34-%E5%88%97%E6%97%8F%E7%9A%84%E6%95%B0%E9%87%8F)
  - [34.1 列族的基数](#341-%E5%88%97%E6%97%8F%E7%9A%84%E5%9F%BA%E6%95%B0)
- [35. RowKey 设计](#35-rowkey-%E8%AE%BE%E8%AE%A1)
  - [35.1 热点](#351-%E7%83%AD%E7%82%B9)
  - [35.2 单向递增的 RowKey 或时间序列 数据](#352-%E5%8D%95%E5%90%91%E9%80%92%E5%A2%9E%E7%9A%84-rowkey-%E6%88%96%E6%97%B6%E9%97%B4%E5%BA%8F%E5%88%97-%E6%95%B0%E6%8D%AE)
  - [35.3 最小化 row 和 列的大小](#353-%E6%9C%80%E5%B0%8F%E5%8C%96-row-%E5%92%8C-%E5%88%97%E7%9A%84%E5%A4%A7%E5%B0%8F)
    - [列族](#%E5%88%97%E6%97%8F)
    - [属性](#%E5%B1%9E%E6%80%A7)
    - [RowKey 长度](#rowkey-%E9%95%BF%E5%BA%A6)
    - [字节模式](#%E5%AD%97%E8%8A%82%E6%A8%A1%E5%BC%8F)
  - [35.4 反向时间戳](#354-%E5%8F%8D%E5%90%91%E6%97%B6%E9%97%B4%E6%88%B3)
  - [35.5 RowKey 和列族](#355-rowkey-%E5%92%8C%E5%88%97%E6%97%8F)
  - [35.6 RowKey 的不可变性](#356-rowkey-%E7%9A%84%E4%B8%8D%E5%8F%AF%E5%8F%98%E6%80%A7)
  - [35.7 RowKey 和 Region 拆分的关系](#357-rowkey-%E5%92%8C-region-%E6%8B%86%E5%88%86%E7%9A%84%E5%85%B3%E7%B3%BB)
- [36. 版本数量](#36-%E7%89%88%E6%9C%AC%E6%95%B0%E9%87%8F)
  - [36.1 版本的最大数量](#361-%E7%89%88%E6%9C%AC%E7%9A%84%E6%9C%80%E5%A4%A7%E6%95%B0%E9%87%8F)
  - [36.2 版本的最小数量](#362-%E7%89%88%E6%9C%AC%E7%9A%84%E6%9C%80%E5%B0%8F%E6%95%B0%E9%87%8F)
- [37. 支持的数据类型](#37-%E6%94%AF%E6%8C%81%E7%9A%84%E6%95%B0%E6%8D%AE%E7%B1%BB%E5%9E%8B)
  - [37.11 计数器](#3711-%E8%AE%A1%E6%95%B0%E5%99%A8)
- [38. Joins](#38-joins)
- [39. TTL](#39-ttl)
- [40. 保留已删除的 Cell](#40-%E4%BF%9D%E7%95%99%E5%B7%B2%E5%88%A0%E9%99%A4%E7%9A%84-cell)
- [41. 二级索引和备用查询路径](#41-%E4%BA%8C%E7%BA%A7%E7%B4%A2%E5%BC%95%E5%92%8C%E5%A4%87%E7%94%A8%E6%9F%A5%E8%AF%A2%E8%B7%AF%E5%BE%84)
  - [41.1 过滤器](#411-%E8%BF%87%E6%BB%A4%E5%99%A8)
  - [41.2 定期更新二级索引](#412-%E5%AE%9A%E6%9C%9F%E6%9B%B4%E6%96%B0%E4%BA%8C%E7%BA%A7%E7%B4%A2%E5%BC%95)
  - [41.3 双写二级索引](#413-%E5%8F%8C%E5%86%99%E4%BA%8C%E7%BA%A7%E7%B4%A2%E5%BC%95)
  - [41.4 汇总表](#414-%E6%B1%87%E6%80%BB%E8%A1%A8)
- [41.5 协处理器二级索引](#415-%E5%8D%8F%E5%A4%84%E7%90%86%E5%99%A8%E4%BA%8C%E7%BA%A7%E7%B4%A2%E5%BC%95)
- [42. 约束](#42-%E7%BA%A6%E6%9D%9F)
- [43. Schema 设计案例](#43-schema-%E8%AE%BE%E8%AE%A1%E6%A1%88%E4%BE%8B)
  - [43.1 日志和时间序列的数据](#431-%E6%97%A5%E5%BF%97%E5%92%8C%E6%97%B6%E9%97%B4%E5%BA%8F%E5%88%97%E7%9A%84%E6%95%B0%E6%8D%AE)
    - [时间戳作为 RowKey 前缀](#%E6%97%B6%E9%97%B4%E6%88%B3%E4%BD%9C%E4%B8%BA-rowkey-%E5%89%8D%E7%BC%80)
    - [主机名作为 RowKey 前缀](#%E4%B8%BB%E6%9C%BA%E5%90%8D%E4%BD%9C%E4%B8%BA-rowkey-%E5%89%8D%E7%BC%80)
    - [时间戳或者反向时间戳](#%E6%97%B6%E9%97%B4%E6%88%B3%E6%88%96%E8%80%85%E5%8F%8D%E5%90%91%E6%97%B6%E9%97%B4%E6%88%B3)
    - [RowKey 长度可变还是固定？](#rowkey-%E9%95%BF%E5%BA%A6%E5%8F%AF%E5%8F%98%E8%BF%98%E6%98%AF%E5%9B%BA%E5%AE%9A)
  - [43.2 Log Data and Timeseries Data on Steroids](#432-log-data-and-timeseries-data-on-steroids)
  - [43.3 客户/订单](#433-%E5%AE%A2%E6%88%B7%E8%AE%A2%E5%8D%95)
    - [单表？多表？](#%E5%8D%95%E8%A1%A8%E5%A4%9A%E8%A1%A8)
    - [订单对象设计](#%E8%AE%A2%E5%8D%95%E5%AF%B9%E8%B1%A1%E8%AE%BE%E8%AE%A1)
  - [43.4 高 vs. 宽 vs. 中](#434-%E9%AB%98-vs-%E5%AE%BD-vs-%E4%B8%AD)
    - [列 vs. 版本](#%E5%88%97-vs-%E7%89%88%E6%9C%AC)
    - [行 vs. 列](#%E8%A1%8C-vs-%E5%88%97)
    - [行作为列](#%E8%A1%8C%E4%BD%9C%E4%B8%BA%E5%88%97)
  - [43.5 列表数据](#435-%E5%88%97%E8%A1%A8%E6%95%B0%E6%8D%AE)
- [44. 性能调优](#44-%E6%80%A7%E8%83%BD%E8%B0%83%E4%BC%98)
  - [44.1 RPC 调优](#441-rpc-%E8%B0%83%E4%BC%98)
  - [44.2 停用 Nagle](#442-%E5%81%9C%E7%94%A8-nagle)
  - [44.3 限制服务器故障影响](#443-%E9%99%90%E5%88%B6%E6%9C%8D%E5%8A%A1%E5%99%A8%E6%95%85%E9%9A%9C%E5%BD%B1%E5%93%8D)
  - [44.4 优化服务端](#444-%E4%BC%98%E5%8C%96%E6%9C%8D%E5%8A%A1%E7%AB%AF)
  - [44.5 JVM 调优](#445-jvm-%E8%B0%83%E4%BC%98)
  - [44.6 OS 级别调优](#446-os-%E7%BA%A7%E5%88%AB%E8%B0%83%E4%BC%98)
- [45. 特殊案例](#45-%E7%89%B9%E6%AE%8A%E6%A1%88%E4%BE%8B)
  - [45.1 尽快失败优于等待](#451-%E5%B0%BD%E5%BF%AB%E5%A4%B1%E8%B4%A5%E4%BC%98%E4%BA%8E%E7%AD%89%E5%BE%85)
  - [45.2 能够忍受轻微的数据过期](#452-%E8%83%BD%E5%A4%9F%E5%BF%8D%E5%8F%97%E8%BD%BB%E5%BE%AE%E7%9A%84%E6%95%B0%E6%8D%AE%E8%BF%87%E6%9C%9F)
  - [45.3 更多信息](#453-%E6%9B%B4%E5%A4%9A%E4%BF%A1%E6%81%AF)
- [导航](#%E5%AF%BC%E8%88%AA)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

这篇博文值得参考：[HBase region server memory sizing](http://hadoop-hbase.blogspot.com/2013/01/hbase-region-server-memory-sizing.html)。

# 34. 列族的数量

HBase 不能很好地处理两个以上的列族。flush 和 compaction 是以 region 为单位进行的，当一个列族需要flush，相邻的列族也会被刷新。

尽量使用一个列族，除非你不会同时访问两个列族。

## 34.1 列族的基数

如果有多个列族，注意列族的基数（即行的数量）。

假设有个列族 A 有个100w 行，列族 B 有10亿行。A 的数据可能分布在多个 region （RegionServer）上。这就上针对 A 的扫描操作异常低效。



# 35. RowKey 设计

## 35.1 热点

HBase 的 RowKey 按字母顺序存储。因此，对 RowKey 的设计要对扫描友好，即允许将相关的 row 存在一起。差劲的 RowKey 设计会引发热点，大部分的访问请求都涌向少数节点。

**加盐**

加盐是为 RowKey 添加一个随机前缀，确保 Rowkey 按照不同的方式来排序。

**哈希**

使用单向哈希将给定的列加上相同的前缀，将它们分发到不同的 RegionServer 上，且读的时候能够预见。

**翻转 Key**

翻转固定宽度或数字的 RowKey，让最长变化的部分放在 RowKey 的前面。

## 35.2 单向递增的 RowKey 或时间序列 数据

避免使用时间戳或时间序列作为 RowKey，这会将数据一股脑儿地扔向某个 region。

在 HBase 中存储时间序列的数据，参考[OpenTSDB](http://opentsdb.net/)。

## 35.3 最小化 row 和 列的大小

[HBASE-3551](https://issues.apache.org/jira/browse/HBASE-3551?page=com.atlassian.jira.plugin.system.issuetabpanels:comment-tabpanel&focusedCommentId=13005272#comment-13005272) 这种 case，就是 cell 的基数太大。

### 列族

保持列的名字尽可能短。推荐一个字符（如，"d" 代表 `data/default`）。

### 属性

建议用短的属性名。

### RowKey 长度

尽可能短，但也要对 Get 和 Scan 友好。

这是一种折中。

### 字节模式

```java
// long
//
long l = 1234567890L;
byte[] lb = Bytes.toBytes(l);
System.out.println("long bytes length: " + lb.length);   // returns 8

String s = String.valueOf(l);
byte[] sb = Bytes.toBytes(s);
System.out.println("long as string length: " + sb.length);    // returns 10

// hash
//
MessageDigest md = MessageDigest.getInstance("MD5");
byte[] digest = md.digest(Bytes.toBytes(s));
System.out.println("md5 digest bytes length: " + digest.length);    // returns 16

String sDigest = new String(digest);
byte[] sbDigest = Bytes.toBytes(sDigest);
System.out.println("md5 digest as string length: " + sbDigest.length);    // returns 26
```

采用 `long` 还是 `string`来表示数字，是一种权衡：

- 要么更少的存储空间
- 要么更好的可读性

## 35.4 反向时间戳

反向时间戳，能让你快速找到最近版本的值。它将(`Long.MAX_VALUE - timestamp)`作为后缀加到 key 的后面。

## 35.5 RowKey 和列族

RowKey 的范围限定为列族，因为不同列族的同一个 RowKey，可以共存。

## 35.6 RowKey 的不可变性

RowKey 不能更改，但可以删除重建。

## 35.7 RowKey 和 Region 拆分的关系

欲拆分表的前提，是对 RowKey 非常了解，切要确保 所有的 region 都落在 key 的空间里。

不建议使用十六进制，但它却能够保证所有的 region 都落在 key 的空间里。



# 36. 版本数量

## 36.1 版本的最大数量

每个列族都有自己的版本最大数量，通过`HColumnDescriptor`配置，默认是1。

HBase 不是重写行的值，而是添加一个不同时间戳的新值。在 Major Compaction 时，多余版本的值会被清除。

不建议将该值调得很大，因为它会增加 StoreFile 的大小。

## 36.2 版本的最小数量

也是通过`HColumnDescriptor`配置，默认是0 。

它常于 TTL 一起使用，意在只保留最近的几个数据。



# 37. 支持的数据类型

HBase 只支持字节的写入和读出。其他输入，如字符串、数字、复杂结构体、图片，都转成字节才能写。

## 37.11 计数器

HBase 还支持一个计数器，参见[Increment](http://hbase.apache.org/apidocs/org/apache/hadoop/hbase/client/Table.html#increment%28org.apache.hadoop.hbase.client.Increment%29)。

计数器的同步是在 RegionServer 做的，而不是 Client 。


# 38. Joins

如果你有多张表，可能在 Schema 设计的时候，就考虑到 Join 的问题，毕竟 HBase 不支持 Join。


# 39. TTL

列族可以设定一个 TTL，HBase 会自动删除达到过期时间的行，包括最新版本的行。

HBase 1.0.0 后，增加了 Cell 的 TTL。Cell 的 TTL 和列族的 TTL 有两点不同：

1. Cell 的 TTL 单位是毫秒，而列族是秒。
2. Cell TTL 的优先级低于列族的 TTL。


# 40. 保留已删除的 Cell

默认情况下，删除标记让 Cell 对 Get 和 Scan 不可见，甚至是 Get 和 Scan 操作带有一个时间戳，而在这个时间之前，Cell 尚未被删除。

列族可以选择保留已删除的 Cell。这时，它对 Get 和 Scan 可见，甚至是它们带有一个时间戳，而在这个时间之后，Cell 才被删除。

已删除的 Cell 仍需要 TTL，并且永远不过超过『版本的最大数量』规定。

```java
HColumnDescriptor.setKeepDeletedCells(true);
```


# 41. 二级索引和备用查询路径

HBase 并没有像关系型数据库一样提供二级索引，它更擅长更大的数据存储空间。

## 41.1 过滤器

[Client Request Filters](http://hbase.apache.org/book.html#client.filter)

不要全表扫描！不要全表扫描！不要全表扫描！

## 41.2 定期更新二级索引

MapReduce 任务定期更新的表，看用作一个二级索引。但这可能和最新的数据不同步。

## 41.3 双写二级索引

另一个策略是在数据打到 HBase 集群的时候，在另一张表中构建索引。但如果数据表已经存在，只能依靠 MapReduce 来更新一遍索引表。

## 41.4 汇总表

如果时间宽度很大（一年），同时数据量巨大，可以使用汇总表。也是借助 MapReduce 生成一个新表。

[mapreduce.example.summary](http://hbase.apache.org/book.html#mapreduce.example.summary)

# 41.5 协处理器二级索引

协处理器像是关系型数据库的触发器，0.92 后添加。

参加：[coprocessors](http://hbase.apache.org/book.html#cp)


# 42. 约束

HBase 0.94 引入了[Constraint](http://hbase.apache.org/devapidocs/org/apache/hadoop/hbase/constraint/Constraint.html)。它用强制约束表中的属性（比如，值必须是0~10）遵循某种规则。

使用约束会大幅降低写吞吐量，不建议使用。


# 43. Schema 设计案例

## 43.1 日志和时间序列的数据

假设我们收集的数据包括：

- 主机名
- 时间戳
- 日志事件
- 值/信息

### 时间戳作为 RowKey 前缀

`[timestamp][hostname][log-event]` 的设计在面对 RowKey 的单向递增时会出现问题。

引入 bucket 的概念：

```
long bucket = timestamp % numBuckets;
```

所以最终的 RowKey，

```
[bucket][timestamp][hostname][log-event]
```

查询特定时间段的数据，需要每个 bucket 遍历一遍。这也是一种权衡。

### 主机名作为 RowKey 前缀

`[hostname][log-event][timestamp]` 也可作为备选，如果你想大量的主机。这样一来，查询某个主机的数据就很简单了。

### 时间戳或者反向时间戳

如果更多关注的是最近的时间，那么应该使用反向时间戳：

`timestamp = Long.MAX_VALUE – timestamp`

### RowKey 长度可变还是固定？

使用哈希构成 RowKey：

- [MD5 hash of hostname] = 16 bytes
- [MD5 hash of event-type] = 16 bytes
- [timestamp] = 8 bytes

使用数字替换构成的 RowKey：

- [substituted long for hostname] = 8 bytes
- [substituted long for event type] = 8 bytes
- [timestamp] = 8 bytes

无论是哪种方式，主机名和事件类型，都作为列。

## 43.2 Log Data and Timeseries Data on Steroids 

最好使用 OpenTSDB 方案，它重写数据，将时间排列的行塞进列中。

see: [http://opentsdb.net/schema.html](http://opentsdb.net/schema.html), and [Lessons Learned from OpenTSDB](http://www.cloudera.com/content/cloudera/en/resources/library/hbasecon/video-hbasecon-2012-lessons-learned-from-opentsdb.html) from HBaseCon2012.

```
[hostname][log-event][timestamp1]
[hostname][log-event][timestamp2]
[hostname][log-event][timestamp3]
```

上述数据被重写为：

```
[hostname][log-event][timerange]
```

然后写入列。

## 43.3 客户/订单

客户记录包括：

- 编号
- 名称
- 地址
- 手机号

订单记录包括：

- 客户编号
- 订单编号
- 交易日志
- 一系列嵌套对象，包含地址等

假设客户编号和订单编号唯一地区分了一次订单。这两个属性应该构成 RowKey：

```
[customer number][order number]
```

同样的，你也可以使用哈希或数字替换来组合 RowKey。

### 单表？多表？

传统的做法是用两个独立表 CUSTOMER 和 SALES。另一个选项是用一个记录类型区分记录，将它们全部压入一张表。

客户记录类型的 RowKey：

- [customer-id]
- [type] = type indicating `1' for customer record type

订单记录类型的 RowKey：

- [customer-id]
- [type] = type indicating `2' for order record type
- [order]

这样做的好处是，将不同类型的记录按照客户编号组织。坏处是，扫描某个特定类型的记录就蛋疼了。

### 订单对象设计

订单对象包括：
- Order。一个 Order 包含多个 ShippingLocation。
- LineItem。一个 ShippingLocation 包含多个 LineItem。

**完全范式化**

几个独立的表 `ORDER`、`SHIPPING_LOCATION`、`LINE_ITEM`。

`ORDER` 表的 RowKey 设计如章节 43.3 开头。

`SHIPPING_LOCATION` 的 RowKey 构成：

- `[order-rowkey]`
- `[shipping location number]` (e.g., 1st location, 2nd, etc.)

`LINE_ITEM`的 RowKey 构成：

- `[order-rowkey]`
- `[shipping location number]` (e.g., 1st location, 2nd, etc.)
- `[line item number]` (e.g., 1st lineitem, 2nd, etc.)

这样设计的缺点是获取某个订单的消息，你必须：

1. 从`ORDER`表中获得 Order
2. 扫描`SHIPPING_LOCATION`表，找到`ShippingLocation`实例。
3. 扫描`LINE_ITEM`表，找到每个`ShippingLocation`。

**单表**

Order 的 RowKey：

- `[order-rowkey]`
- `[ORDER record type]`

`ShippingLocation`组成的 RowKey：

- `[order-rowkey]`
- `[SHIPPING record type]`
- `[shipping location number]` (e.g., 1st location, 2nd, etc.)

`LineItem`组成的 RowKey：

- `[order-rowkey]`
- `[LINE record type]`
- `[shipping location number]` (e.g., 1st location, 2nd, etc.)
- `[line item number]` (e.g., 1st lineitem, 2nd, etc.)

**反范式化**

单表的一个变体是反范式化，将对象层次结构压平，比如将`ShppingLocation`属性变成一个个`LineItem`实例。

`LineItem`组成的 RowKey：

- `[order-rowkey]`
- `[LINE record type]`
- `[line item number]` (e.g., 1st lineitem, 2nd, etc., care must be taken that there are unique across the entire order)

`LineItem`的列如下：

- itemNumber
- quantity
- price
- shipToLine1 (denormalized from ShippingLocation)
- shipToLine2 (denormalized from ShippingLocation)
- shipToCity (denormalized from ShippingLocation)
- shipToState (denormalized from ShippingLocation)
- shipToZip (denormalized from ShippingLocation)

这么做的缺点是更新变得很复杂。

**BLOB 对象**

这个订单对象看做一个 BLOB，RowKey 不变，只有一列`order`来存储序列化后的容器（Order, ShippingLocation, LienItem）。

好处是减少了 I/O，缺点是兼容性问题。

## 43.4 高 vs. 宽 vs. 中

### 列 vs. 版本

一般来说，倾向于使用行，而不是版本来存更多的诗句。

因为使用行可以存储 RowKey 的时间戳，这样其后的操作就不会覆盖它。

### 行 vs. 列

一般来说，还是倾向于行。

### 行作为列

OpenTSDB 就是个很好的例子，单行表示定义的时间范围，然后离散事件被视为列。这种方法的覆写数据很复杂，但能提高 I/O 性能。

## 43.5 列表数据

本节的例子是如何存储每个用户的列表数据。一个选项是将大部分数据存在 Key 中：

```
<FixedWidthUserName><FixedWidthValueId1>:"" (no value)
<FixedWidthUserName><FixedWidthValueId2>:"" (no value)
<FixedWidthUserName><FixedWidthValueId3>:"" (no value)
```

另一个选项是：

```
<FixedWidthUserName><FixedWidthPageNum0>:<FixedWidthLength><FixedIdNextPageNum><ValueId1><ValueId2><ValueId3>...
<FixedWidthUserName><FixedWidthPageNum1>:<FixedWidthLength><FixedIdNextPageNum><ValueId1><ValueId2><ValueId3>...
```

上述两个选择就是高表和宽表的问题。


# 44. 性能调优

## 44.1 RPC 调优

- `hbase.regionserver.handler.count`设置成CPU 核心数。
- `hbase.ipc.server.callqueue.handler.factor` 拆分读和写的队列。
- `hbase.ipc.server.callqueue.read.ratio` 拆分读和写的队列。
- `hbase.ipc.server.callqueue.scan.ratio` 拆分 Get 和 Scan 的队列。

## 44.2 停用 Nagle

延迟的 ACK 会增加 RPC 的往返时间 200ms。

- In Hadoop’s `core-site.xml`:
  - `ipc.server.tcpnodelay = true`
  - `ipc.client.tcpnodelay = true`
- In HBase’s `hbase-site.xml`:
  - `hbase.ipc.client.tcpnodelay = true`
  - `hbase.ipc.server.tcpnodelay = true`

## 44.3 限制服务器故障影响

尽快发现 RegionServer 的故障并转移：

- In `hbase-site.xml`, set `zookeeper.session.timeout` to 30 seconds or less to bound failure detection (20-30 seconds is a good start).
- Detect and avoid unhealthy or failed HDFS DataNodes: in `hdfs-site.xml` and `hbase-site.xml`, set the following parameters:
  - `dfs.namenode.avoid.read.stale.datanode = true`
  - `dfs.namenode.avoid.write.stale.datanode = true`

## 44.4 优化服务端

- Skip the network for local blocks. In `hbase-site.xml`, set the following parameters:
  - `dfs.client.read.shortcircuit = true`
  - `dfs.client.read.shortcircuit.buffer.size = 131072` (Important to avoid OOME)
- Ensure data locality. In `hbase-site.xml`, set `hbase.hstore.min.locality.to.skip.major.compact = 0.7` (Meaning that 0.7 <= n <= 1)
- Make sure DataNodes have enough handlers for block transfers. In `hdfs-site.xml`, set the following parameters:
  - `dfs.datanode.max.xcievers >= 8192`
  - `dfs.datanode.handler.count =` number of spindles

## 44.5 JVM 调优

- 使用 CMS 垃圾回收器: `-XX:+UseConcMarkSweepGC`

- Keep eden space as small as possible to minimize average collection time. Example:

  ```
  -XX:CMSInitiatingOccupancyFraction=70
  ```

- Optimize for low collection latency rather than throughput: `-Xmn512m`

- Collect eden in parallel: `-XX:+UseParNewGC`

- Avoid collection under pressure: `-XX:+UseCMSInitiatingOccupancyOnly`

- Limit per request scanner result sizing so everything fits into survivor space but doesn’t tenure. In `hbase-site.xml`, set `hbase.client.scanner.max.result.size` to 1/8th of eden space (with -`Xmn512m` this is ~51MB )

- Set `max.result.size` x `handler.count` less than survivor space

## 44.6 OS 级别调优

- Turn transparent huge pages (THP) off:

  ```
  echo never > /sys/kernel/mm/transparent_hugepage/enabled
  echo never > /sys/kernel/mm/transparent_hugepage/defrag
  ```

- Set `vm.swappiness = 0`

- Set `vm.min_free_kbytes` to at least 1GB (8GB on larger memory systems)

- Disable NUMA zone reclaim with `vm.zone_reclaim_mode = 0`



# 45. 特殊案例

## 45.1 尽快失败优于等待

- In `hbase-site.xml` on the client side, set the following parameters:
  - Set `hbase.client.pause = 1000`
  - Set `hbase.client.retries.number = 3`
  - If you want to ride over splits and region moves, increase `hbase.client.retries.number` substantially (>= 20)
  - Set the RecoverableZookeeper retry count: `zookeeper.recovery.retry = 1` (no retry)
- In `hbase-site.xml` on the server side, set the Zookeeper session timeout for detecting server failures: `zookeeper.session.timeout` ⇐ 30 seconds (20-30 is good).

## 45.2 能够忍受轻微的数据过期

开启时间线一致性：

- Deploy HBase 1.0.0 or later.
- Enable timeline consistent replicas on the server side.
- Use one of the following methods to set timeline consistency:
  - Use `ALTER SESSION SET CONSISTENCY = 'TIMELINE’`
  - Set the connection property `Consistency` to `timeline` in the JDBC connect string

## 45.3 更多信息

[perf.schema](http://hbase.apache.org/book.html#perf.schema)


# 导航

[目录](README.md)

上一章：[HBase and Schema Design](shema-design.md)

下一章：[HBase and MapReduce](hbase-mapreduce.md)
