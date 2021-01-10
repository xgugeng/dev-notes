<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [3.1 概述](#31-%E6%A6%82%E8%BF%B0)
- [3.2 CRUD 操作](#32-crud-%E6%93%8D%E4%BD%9C)
  - [3.2.1 `Put` 方法](#321-put-%E6%96%B9%E6%B3%95)
    - [1. 单行`put`](#1-%E5%8D%95%E8%A1%8Cput)
    - [2. `KeyValue`](#2-keyvalue)
    - [3. 客户端的写缓冲](#3-%E5%AE%A2%E6%88%B7%E7%AB%AF%E7%9A%84%E5%86%99%E7%BC%93%E5%86%B2)
    - [4. `Put`列表](#4-put%E5%88%97%E8%A1%A8)
    - [5. 原子性操作 compare-and-set](#5-%E5%8E%9F%E5%AD%90%E6%80%A7%E6%93%8D%E4%BD%9C-compare-and-set)
  - [3.2.2 `get`方法](#322-get%E6%96%B9%E6%B3%95)
    - [单行 `get`](#%E5%8D%95%E8%A1%8C-get)
    - [`Result`类](#result%E7%B1%BB)
    - [`Get`列表](#get%E5%88%97%E8%A1%A8)
    - [获取数据的相关方法](#%E8%8E%B7%E5%8F%96%E6%95%B0%E6%8D%AE%E7%9A%84%E7%9B%B8%E5%85%B3%E6%96%B9%E6%B3%95)
  - [3.2.3 删除方法](#323-%E5%88%A0%E9%99%A4%E6%96%B9%E6%B3%95)
    - [单行删除](#%E5%8D%95%E8%A1%8C%E5%88%A0%E9%99%A4)
    - [`Delete`的列表](#delete%E7%9A%84%E5%88%97%E8%A1%A8)
    - [原子性操作compare-and-delete](#%E5%8E%9F%E5%AD%90%E6%80%A7%E6%93%8D%E4%BD%9Ccompare-and-delete)
- [3.3 批量处理操作](#33-%E6%89%B9%E9%87%8F%E5%A4%84%E7%90%86%E6%93%8D%E4%BD%9C)
- [3.4 行锁](#34-%E8%A1%8C%E9%94%81)
- [3.5 扫描](#35-%E6%89%AB%E6%8F%8F)
  - [`ResultScanner` 类](#resultscanner-%E7%B1%BB)
    - [缓存与批量处理](#%E7%BC%93%E5%AD%98%E4%B8%8E%E6%89%B9%E9%87%8F%E5%A4%84%E7%90%86)
- [3.6 各种特性](#36-%E5%90%84%E7%A7%8D%E7%89%B9%E6%80%A7)
  - [`HTable`的实用方法](#htable%E7%9A%84%E5%AE%9E%E7%94%A8%E6%96%B9%E6%B3%95)
  - [`Bytes`类](#bytes%E7%B1%BB)
- [导航](#%E5%AF%BC%E8%88%AA)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

HBase 是 Java 编写的，所以原生的 API 也是 Java 开发的。

# 3.1 概述

HBase 的主要客户端接口是由 `org.apache.hadoop.hbase.client`包中的`HTable`类提供的。通过这个类，用户可以存储、检索、删除数据。

所有的修改操作都是**原子性**的。这会影响到**这一行**数据的所有并发读写操作。这意味着

> 其他客户端或线程对同一行的读写操作不会影响该行数据的原子性，要么读到最新的修改，要么等待系统允许写入该行。

行原子性会保护到该行的**所有列**。

当然，创建`HTable`是有代价的，每个实例都要扫描`.META`表，以确定该表是否存在、是否可用。这些检查非常耗时。建议复用`HTable`对象。

如果需要多个`HTable`实例，考虑`HTablePool`类。

# 3.2 CRUD 操作

## 3.2.1 `Put` 方法

### 1. 单行`put`

```java
void put(Put put) throws IOException
  
// Put 构造函数
Put(byte[] row)
  
// 向 Put 实例添加数据
// ts 时间戳为可选参数，忽略的话，Region Server会填充之。
Put add (byte[] family, byte[] qualifier, long ts, byte[] value)
  
// 检查是否存在特定的单元格
boolean has(byte[] family, byte[] qualifier, long ts)
```

### 2. `KeyValue`

`KeyValue`提供了一系列实现`Comparator`接口的内部类。

### 3. 客户端的写缓冲

每一个`put`操作实际上是一个RPC请求。HBase的API配备了客户端的写缓冲区。缓冲区负责收集`put`操作，然后调用RPC操作一次性将`put`送往服务器。全局交换机控制着该缓冲区是否在使用：

```java
void setAutoFlush(boolean autoFlush)
bool isAutoFlush
```

默认情况下，客户端的缓冲区是禁用的，除非：

```java
table.setAutoFlush(false)
```

缓冲区仅在两种情况下会刷写：

1. 显式：`flushCommits`
2. 隐式：用户调用`put`或`setWriteBufferSize`时触发。如果缓冲区超过限制，会自动触发。`close()`会无条件触发。

### 4. `Put`列表

客户端的API可以批量处理操作：

```java
void put(List<Put> puts) throws IOException
```

### 5. 原子性操作 compare-and-set

有一种特别的`put`调用，能够保证自身操作的原子性：检查写（check and put）：

```java
boolean checkAndPut(byte[] row, byte[] family, byte[] qualifier, byte[] value, Put put) throws IOException
```



## 3.2.2 `get`方法

`HTable`提供了`get`方法，与之对应的还有`Get`类。

### 单行 `get`

这个方法可以从HBase 表中取一个特定的值：

```java
Result get(Get get) throws IOException
```

`Get`类的构造函数：

```java
Get (byte[] row)
Get (byte[] row, RowLock rowLock)
```

### `Result`类

`get()`获取的数据被封装在`Result`实例中。`Result`类提供的方法：

```java
byte[] getValue(byte[] family, byte[] qualifier)
byte[] value()
byte[] getRow()
int size()
boolean isEmpty()
KeyValue[] raw()
List<KeyValue> list()
```

另外还有一些面向列的存取函数：

```java
List<KeyValue> getColumn(byte[] family, byte[] qualifier)
KeyValue getColumnLastest(byte[] family, byte[] qualifier)
boolean containsColumn(byte[] family, bytep[] qualifier)
```

这个方法返回一个特定列的多个值。

第三类取值函数，以映射形式返回结果：

```java
NavigableMap<byte[], NavigableMap<byte[], NavigableMap<Long, byte[]>>> getMap()
NavigableMap<byte[], NavigableMap<byte[], NavigableMap<Long, byte[]>>> getNoVersionMap()
NavigableMap<byte[], NavigableMap<byte[], NavigableMap<Long, byte[]>>> getFamilyMap(byte[] family)
```

它们把所有`get()`请求的返回结果装入一个Java的`Map`类实例中。

不论用户如何获取`Result`的数据，都不会产生额外的性能消耗，因为这些数据已经从服务器传输到了客户端。

### `Get`列表

`Get`让用户可以从服务区获取多行数据：

```java
Result[] get(List<Get> gets) throws IOException
```

### 获取数据的相关方法

```java
boolean exists(Get get) throws IOException
  
// 检索数据时需要查找一个特定的行，可以使用
Result getRowOrBefore(byte[] row, byte[] family) throws IOException
```

## 3.2.3 删除方法

`HTable`也有一个`delete()`方法，与之对应的是`Delete`类。

### 单行删除

```java
void delete(Delete delete) throws IOException
  
// Delete 构造对象
Delete(byte[] row)
Delete(byte[] row, long timestamp, RowLock rowLock)
```

`Delete`还支持删除特定的列。

### `Delete`的列表

```java
void delete(List<Delete> deletes) throws IOException
```

### 原子性操作compare-and-delete

读取并修改的功能：

```java
boolean checkAndDelete(byte[] row, byte[] family, byte[] qualifier, byte[] value, Delete delete) throws IOException
```



# 3.3 批量处理操作

`Row`类是`Put`、`Get`和`Delete`的父类。

```java
void batch(List<Row> actions, Object[] results) throws IOException, InterruptedException
Object[] batch(List<Row> actions) throws IOException, InterruptedException
```

可以使用父类实现多态，这样可以融合不同的操作。

# 3.4 行锁

region server 提供了一个行锁（row lock），它保证了只有一个客户端能获取一行数据相应的锁，并对该行进行修改。

> 行锁有可能导致死锁的发生。

服务器会隐式加锁，当你执行：

```java
Put (byte[] row)
```

时，服务器会在调用期间创建一个锁。通过客户端的API得不到这个锁的实例。

当然，客户端也可以显式地对单行数据的多次操作进行加锁：

```java
RowLock lockRow(byte[] row) throws IOException
void unlockRow(RockLock rl) throws IOException
```

锁只能针对整个行，不能指定其行键。

锁被释放，或者租期超时，其他的客户端才能对该行进行加锁。

> Get 请求不需要加锁。



# 3.5 扫描

扫描的工作方式类似于迭代器，调用`HTable`的`getScanner()`方法会返回一个扫描器实例。用户可以使用它迭代获取数据：

```java
ResultScanner getScanner(Scan scan) throws IOException
ResultScanner getScanner(byte[] family) throws IOException
ResultScanner getScanner(byte[] family, byte[] qualifier) throws IOException
```

`Scan`类有以下的构造器：

```java
Scan()
Scan(byte[] startRow, Filter filter)
Scan(byte[] startRow)
Scan(byte[] startRow, byte[] stopRow)
```

同时还可以用多种方法限制所要读取的数据：

```java
Scan addFamily(byte[] family)
Scan addColumn(byte[] family, byte[] qualifier)
```

## `ResultScanner` 类

扫描操作不会通过一次RPC返回所有匹配的行。`ResultScanner`把扫描操作转换为类似的`get`操作，将每一行数据封装成一个`Result`实例放入一个迭代器中：

```java
Result next() throws IOException
Result[] next(int nbRows) throws IOException
void close()
```

### 缓存与批量处理

每一个`next()`调用都会生成一个单独的RPC请求，即时使用`next(int nbRows)`也如此。为了避免性能损耗，扫描器缓存就至关重要了。

扫描器缓存有两个层面：

- 表的层面。这个表所有扫描实例的缓存都会生效。

  使用`HTable`的方法可以设置表级的缓存：

  ```java
  void setSannerCaching(int scannerCaching)
  ```

- 扫描层面。只影响当前的扫描实例。

  使用`Scan`类的方法可以设置扫描级的缓存：

  ```java
  void setCaching(int caching)
  ```

用户必须在少量的RPC请求次数和内存消耗中间找到平衡点。

为了防止数据量非常大的行超过客户端进程的内存容量，用户可以控制批量获取操作：

```java
void setBatch(int batch)
int getBatch()
```

缓存是面向行一级的操作，批量是面向列一级的操作，可以让用户选择每一次`ResultScanner`的`next()`取回多少列。

```
RPC请求的次数 = (行数 x 每行的列数) / Min(每行的列数，批量大小) / 扫描器缓存
```



# 3.6 各种特性

## `HTable`的实用方法

| 方法                                       | 作用                                       |
| ---------------------------------------- | ---------------------------------------- |
| `void close()`                           | 使用完一个`HTable`实例后，需要调用`close()`。它会刷写客户端缓冲的写操作（隐式调用`flushCache()`） |
| `byte[] getTableName()`                  | 获取表名的快捷方法                                |
| `Configuration getConfiguration()`       | 获取允许用户访问的`HTable`实例中使用的配置。因为得到的是`Configuration`实例的引用，所以用户修改的参数（针对客户端）会立即生效。 |
| `byte[][] getStartKeys()` `byte[][] getEndKeys()` | 查看表的物理分布情况                               |
| `Map<HRegionInfo, HServerAddress> getRegionsInfo()` | 查看region信息                               |

## `Bytes`类

`Bytes`类提供了类型转换的方法：

- `toString()`
- `toLong()`
- ...

另外，还有些值得一提的：

- `toStringBinary()`
- `compareTo()`、`equals()`
- `add()`


# 导航

[目录](README.md)

上一章：[2、安装](2、安装.md)

下一章：[4、客户端API：高级特性](4、客户端API：高级特性.md)
