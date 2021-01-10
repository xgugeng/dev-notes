<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [19. 概念视图](#19-%E6%A6%82%E5%BF%B5%E8%A7%86%E5%9B%BE)
- [20. 物理视图](#20-%E7%89%A9%E7%90%86%E8%A7%86%E5%9B%BE)
- [21. 命名空间](#21-%E5%91%BD%E5%90%8D%E7%A9%BA%E9%97%B4)
  - [21.1 命名空间管理](#211-%E5%91%BD%E5%90%8D%E7%A9%BA%E9%97%B4%E7%AE%A1%E7%90%86)
  - [21.2 预定义的命名空间](#212-%E9%A2%84%E5%AE%9A%E4%B9%89%E7%9A%84%E5%91%BD%E5%90%8D%E7%A9%BA%E9%97%B4)
- [22. 表](#22-%E8%A1%A8)
- [23. 列](#23-%E5%88%97)
- [24. 列族](#24-%E5%88%97%E6%97%8F)
- [25. Cell](#25-cell)
- [26. 数据模型操作](#26-%E6%95%B0%E6%8D%AE%E6%A8%A1%E5%9E%8B%E6%93%8D%E4%BD%9C)
  - [26.1 Get](#261-get)
  - [26.2 Put](#262-put)
  - [26.3 扫描](#263-%E6%89%AB%E6%8F%8F)
  - [26.4 Delete](#264-delete)
- [27. 版本](#27-%E7%89%88%E6%9C%AC)
  - [27.1 指定版本号的存储](#271-%E6%8C%87%E5%AE%9A%E7%89%88%E6%9C%AC%E5%8F%B7%E7%9A%84%E5%AD%98%E5%82%A8)
  - [27.2 版本和 HBase 操作](#272-%E7%89%88%E6%9C%AC%E5%92%8C-hbase-%E6%93%8D%E4%BD%9C)
    - [Get/Scan](#getscan)
    - [Put](#put)
    - [Delete](#delete)
  - [27.3 当前的限制](#273-%E5%BD%93%E5%89%8D%E7%9A%84%E9%99%90%E5%88%B6)
    - [Delete 可能覆盖 Put](#delete-%E5%8F%AF%E8%83%BD%E8%A6%86%E7%9B%96-put)
    - [Major Compaction 改变查询结果](#major-compaction-%E6%94%B9%E5%8F%98%E6%9F%A5%E8%AF%A2%E7%BB%93%E6%9E%9C)
- [28. 排列顺序](#28-%E6%8E%92%E5%88%97%E9%A1%BA%E5%BA%8F)
- [29. 列的元数据](#29-%E5%88%97%E7%9A%84%E5%85%83%E6%95%B0%E6%8D%AE)
- [30. Join](#30-join)
- [31. ACID](#31-acid)
- [导航](#%E5%AF%BC%E8%88%AA)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

HBase 数据模型的名词：

- 表。一张表包含多个列。
- 列。一列包含 RowKey 以及一个或多个带值的列。行按照 RowKey 的字母序排列，这就凸显了 RowKey 设计的重要性。
- 列。一列由一个列族和一个列限定符组成，以冒号分隔。
- 列族。列族在物理上分开了不同的列和它们的值。每个列族都有一系列存储的属性，如cache、压缩、RowKey 编码等。表中的每一行都有相同的列族，尽管它可以不存任何数据。
- 列限定符。列限定符附在列族上，提供了特定分片的数据索引。列族在表创建的时候就固定了，但列限定符可以动态添加。不同的行，列限定符也可以大相径庭。
- Cell。Cell 是行、列族、列限定符的结合，包括一个值和一个时间戳。
- 时间戳。每个值都有一个时间戳，标识了值的版本。它是在 RegionServer 更新数据的同时写入的。


# 19. 概念视图

表 `webtable`：

| Row Key       | Time Stamp | ColumnFamily `contents`   | ColumnFamily `anchor`         | ColumnFamily `people` |
| ------------- | ---------- | ------------------------- | ----------------------------- | --------------------- |
| "com.cnn.www" | t9         |                           | anchor:cnnsi.com = "CNN"      |                       |
| "com.cnn.www" | t8         |                           | anchor:my.look.ca = "CNN.com" |                       |
| "com.cnn.www" | t6         | contents:html = "<html>…" |                               |                       |
| "com.cnn.www" | t5         | contents:html = "<html>…" |                               |                       |
| "com.cnn.www" | t3         | contents:html = "<html>…" |                               |                       |

表中空白的 Cell 实际上并不存在。

# 20. 物理视图

表在物理上是按照列族存储的。

列族 `anchor`：

| Row Key       | Time Stamp | Column Family `anchor`          |
| ------------- | ---------- | ------------------------------- |
| "com.cnn.www" | t9         | `anchor:cnnsi.com = "CNN"`      |
| "com.cnn.www" | t8         | `anchor:my.look.ca = "CNN.com"` |

列族 `contents`: 

| Row Key       | Time Stamp | ColumnFamily `contents:`  |
| ------------- | ---------- | ------------------------- |
| "com.cnn.www" | t6         | contents:html = "<html>…" |
| "com.cnn.www" | t5         | contents:html = "<html>…" |
| "com.cnn.www" | t3         | contents:html = "<html>…" |

概念视图中的空 Cell 压根不存储。当你请求`contents:html`在时间戳`t8`的值，不返回任何值。

不带时间戳的访问请求，默认访问的是最新的值，即时间戳最大的值。

# 21. 命名空间

命名空间是表的逻辑分组，类似于关系数据库中的 `database`。基于这个抽象，可以推导出多租户的相关特性：

- 配额管理。限制一个命名空间可消费的资源。
- 命名空间安全管理。为各租户提供不同级别的安全管理。
- RegionServer 分组。一个命名空间、表可以 pin 在几个 RegionServe 上，做到一定程度上是隔离。

## 21.1 命名空间管理

命名空间可以被创建、移除、修改。命名空间的成员在表创建的时候就确定了：

```
#Create a namespace
create_namespace 'my_ns'

#create my_table in my_ns namespace
create 'my_ns:my_table', 'fam'

#drop namespace
drop_namespace 'my_ns'

#alter namespace
alter_namespace 'my_ns', {METHOD => 'set', 'PROPERTY_NAME' => 'PROPERTY_VALUE'}
```

## 21.2 预定义的命名空间

有两个预定义的特殊命名空间：

- `hbase`。系统命名空间，用来容纳 HBase 的内部表。
- `default`。没有指定命名空间的表，默认都是这项。

```
#namespace=foo and table qualifier=bar
create 'foo:bar', 'fam'

#namespace=default and table qualifier=bar
create 'bar', 'fam'
```



# 22. 表

表在定义 Schema 的时候就声明了。



# 23. 列

RowKey 是无意义的字节数组。列按照字母顺序递增排列。

空的字节数组表示表的命名空间的起止。



# 24. 列族

HBase 的列按照列族分组，同一列族的列有相同的前缀。列族前缀必须是可打印的字符，限定符则可以是任意字节。

列族在 Scheme 定义的时候就确定了，限定符则可以动态添加。

调优和存储都是在列族这一级别做的，所以最好同一列族的成员有相同的访问模式和大小特征。



# 25. Cell

*{row, column, version}* 元组精确定位了一个 Cell。Cell 的内容是粗略的字节。



# 26. 数据模型操作

## 26.1 Get

Get 操作返回一个特定的列，执行的`Table.get`。

## 26.2 Put

Put 可以添加新行、修改已存在的行，执行的是`Table.put`或`Table.batch`（无写缓冲）。

## 26.3 扫描

```java
public static final byte[] CF = "cf".getBytes();
public static final byte[] ATTR = "attr".getBytes();
...

Table table = ...      // instantiate a Table instance

Scan scan = new Scan();
scan.addColumn(CF, ATTR);
scan.setRowPrefixFilter(Bytes.toBytes("row"));
ResultScanner rs = table.getScanner(scan);
try {
  for (Result r = rs.next(); r != null; r = rs.next()) {
    // process result...
  }
} finally {
  rs.close();  // always close the ResultScanner!
}
```

## 26.4 Delete 

Delete 删除一列，执行`Table.delete`。

HBase 不是原地修改数据，而是为它创建个墓碑标记。在 Major Compaction 的时候，带有该标记的值会被清理。

# 27. 版本

RowKey 和 ColumnKey 都是字节表示，version 是一个长整型，即`ava.util.Date.getTime()` or `System.currentTimeMillis`的返回。

版本按照Long 的值降序排列，这样读数据的时候最先读到的是最新的数据。

在 HBase 中：

- 对一个 Cell 的多个写操作带有相同版本号，只有最后的写操作生效。
- 不按照版本的递增数据，也可以写入数据。

## 27.1 指定版本号的存储

创建表的时候，列的最大版本号就确定了。通过`alter`命令可以修改版本号。HBase 0.96以前，默认的最大版本号是3，之后是 1。

```
hbase> alter ‘t1′, NAME => ‘f1′, VERSIONS => 5
```

0.98.2 之后，HBase 可以指定一个全局的最大版本号，它对新加入的列有效：`hbase.column.max.version`。

## 27.2 版本和 HBase 操作

### Get/Scan

Get 是基于 Scan 实现的，故以下说法也适用于 Scan。

Get 请求默认返回最新的版本，要自定义的话：

- 返回不止一个版本：`Get.setMaxVersions()`。
- 返回一个老版本：`Get.setTimeRange()`。

```java
public static final byte[] CF = "cf".getBytes();
public static final byte[] ATTR = "attr".getBytes();
...
Get get = new Get(Bytes.toBytes("row1"));
get.setMaxVersions(3);  // will return last 3 versions of row
Result r = table.get(get);
byte[] b = r.getValue(CF, ATTR);  // returns current version of value
List<KeyValue> kv = r.getColumn(CF, ATTR);  // returns all versions of this column
```

### Put

Put 请求总是会创建一个新版本的 cell。默认情况下，系统使用服务器的`curentTimeMillis`，用户也可以为每个列指定一个版本（可以比当前时间老）。

```java
public static final byte[] CF = "cf".getBytes();
public static final byte[] ATTR = "attr".getBytes();
...
Put put = new Put( Bytes.toBytes(row));
long explicitTimeInMs = 555;  // just an example
put.add(CF, ATTR, explicitTimeInMs, Bytes.toBytes(data));
table.put(put);
```

### Delete

有三种不同类型的内部删除：

- Delete：删除一个列的特定版本。
- Delete Column：删除一个列的所有版本。
- Delete Family：删除特定列族的所有列。

删除一个行的时候，HBase 在内部为该行的每个列族都创建一个墓碑标记。

`KEEP_DELETED_CELLS`选项能够阻止 Major Compaction 删除带有墓碑标记的 cell。设置删除 TTL（`hbase.hstore.time.to.purge.deletes`）可以让 cell 呆的更久一点。

## 27.3 当前的限制

### Delete 可能覆盖 Put

即便是 Put 在 Delete 之后，Delete 仍有可能覆盖 Put。 设想一下同时 Delete 和 Put 一个带有相同时间戳的 cell。

### Major Compaction 改变查询结果

假设cell 有三个版本：t1, t2, t3。最大版本号为3。获取全部的版本只会得到 t2 和 t3。如果删除了 t2，t1就会返回。一旦 Major Compaction 执行了，这个行为就不是在这样了。

# 28. 排列顺序

HBase 的所有操作返回都是排序好的。首先按照行、然后列族、再是列，最后是时间戳。



# 29. 列的元数据

除了内部的 KeyValue 实例，没有其他地方存储列族的列元数据。

过去所有列的唯一办法，就是处理所有的行。



# 30. Join

HBase 不支持 Join。



# 31. ACID

[ACID Semantics](http://hbase.apache.org/acid-semantics.html)

[ACID in HBase](http://hadoop-hbase.blogspot.com/2012/03/acid-in-hbase.html)


# 导航

[目录](README.md)

上一章：[The Apache HBase Shell](shell.md)

下一章：[HBase and Schema Design](shema-design.md)
