<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [堆大小](#%E5%A0%86%E5%A4%A7%E5%B0%8F)
- [文件描述符](#%E6%96%87%E4%BB%B6%E6%8F%8F%E8%BF%B0%E7%AC%A6)
- [内存锁定](#%E5%86%85%E5%AD%98%E9%94%81%E5%AE%9A)
- [线程个数限制](#%E7%BA%BF%E7%A8%8B%E4%B8%AA%E6%95%B0%E9%99%90%E5%88%B6)
- [虚拟内存最大size](#%E8%99%9A%E6%8B%9F%E5%86%85%E5%AD%98%E6%9C%80%E5%A4%A7size)
- [最大的映射条数](#%E6%9C%80%E5%A4%A7%E7%9A%84%E6%98%A0%E5%B0%84%E6%9D%A1%E6%95%B0)
- [客户端JVM](#%E5%AE%A2%E6%88%B7%E7%AB%AFjvm)
- [串行GC](#%E4%B8%B2%E8%A1%8Cgc)
- [系统调用过滤](#%E7%B3%BB%E7%BB%9F%E8%B0%83%E7%94%A8%E8%BF%87%E6%BB%A4)
- [`OnError` 和 `OnOutOfMemoryError`](#onerror-%E5%92%8C-onoutofmemoryerror)
- [G1GC](#g1gc)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

早期版本的Elasticsearch将配置错误打印在 WARNING 日志中，容易被忽视。后来，Elasticsearch引入了引导检查（Bootstrap Check）。

引导检查将确保Elasticsearch和系统设置对Elasticsearch来说是安全的。如果在开发模式，检查失败会打印在 WARNING 日志中；生产模式中，检查失败会终止Elasticsearch启动进程。

# 堆大小

如果堆的初始size和最大size不同，那么JVM就会暂停来 resize。因此，两者最好是相同的。

如果启用`bootstrap.memory_lock`，JVM会在启动时锁定堆的初始size。如果堆的初始size和最大size不同，resize 之后JVM的堆就不会锁定。

默认情况下，Elasticsearch使用2 GB的堆。使用`Xms`（堆最小size）和`Xmx`（堆最大size）。设置堆大小的原则有：

- `Xms`和`Xmx`相同。

- 堆越大，Elasticsearch可用来缓存的空间就越多。但堆太大会引发GC暂停。

- `Xmx`不宜超过物理RAM的50%，确保内核文件系统缓存可以使用剩余的RAM。

- `Xmx`不宜超过JVM compressed object pointers 。

  ​

# 文件描述符

Elasticsearch在多处用到了文件描述符（如，每个分片有多个segment组成）。如果文件描述符不够用了，Elasticsearch有可能丢失数据。因此必须使用`ulimit`打开限制。



# 内存锁定

为了避免内存和磁盘之间的swap，`bootstrap.memory_lock`可以锁定堆内存（基于`mlockall`）。

即便打开了`bootstrap.memory_lock`，Elasticsearch仍有可能无法锁定堆。



# 线程个数限制

Elasticsearch在接收一个请求之后，会将其分解为stage，然后将各个stage分发给不同的线程池executor。

线程的个数限制就确保Elasticsearch能够创建足够的线程来处理请求。

修改`/etc/security/limits.conf`中的`nproc`即可调整该限制。



# 虚拟内存最大size

Elasticsearch使用`mmap`将索引转换为地址空间，这时候索引数据从JVM heap中取出，但仍然驻留在内存中。这就需要确保Elasticsearch可以使用无限的地址空间：修改`/etc/security/limits.conf`中是`as`为`unlimited`。



# 最大的映射条数

为了高效使用`mmap`，Elasticsearch需要创建许多内存映射区域。最大的映射条数可以通过`sysctl`修改`vm.max_map_count`为至少 262144。



# 客户端JVM

OpenJDK家族的JVM提供了两个不同的JVM：客户端JVM和服务端JVM。两者采用不同的编译器。客户端JVM优化了启动时间、内存footprint，而服务端JVM最大化了性能。

客户端JVM检查，确保Elasticsearch不是运行在客户端JVM中。

现代操作系统中，默认的都是服务端JVM。



# 串行GC

串行GC适用于单个CPU、或者极小的heap，当然也就不适合Elasticsearch。



# 系统调用过滤

Elasticsearch安装了很多系统调用过滤器，用来滤掉一些对Elasticsearch有害的`fork`调用。



# `OnError` 和 `OnOutOfMemoryError`

JVM的选项`OnError` 和 `OnOutOfMemoryError`让JVM在遇到上述error 的时候执行一段命令。

这个check与系统调用过滤不兼容。



# G1GC

早期版本的HotSpot JVM在G1GC开启的情况下会触发索引崩溃，影响了JDK 8u40之前的版本。

G1GC检查就是剔除早期版本的HotSpot JVM。

