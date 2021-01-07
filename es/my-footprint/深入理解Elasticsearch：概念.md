<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [近实时 （Near Realtime，NRT）](#%E8%BF%91%E5%AE%9E%E6%97%B6-near-realtimenrt)
- [集群（Cluster)](#%E9%9B%86%E7%BE%A4cluster)
- [节点（Node）](#%E8%8A%82%E7%82%B9node)
  - [协调节点](#%E5%8D%8F%E8%B0%83%E8%8A%82%E7%82%B9)
- [索引（Index）](#%E7%B4%A2%E5%BC%95index)
- [类型（Type）](#%E7%B1%BB%E5%9E%8Btype)
- [文档（Document）](#%E6%96%87%E6%A1%A3document)
- [分片和备份（Shards & Replicas）](#%E5%88%86%E7%89%87%E5%92%8C%E5%A4%87%E4%BB%BDshards--replicas)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

Elasticsearch是一个高扩展的全文搜索和分析引擎，它可以近实时地存储、搜索、分析海量的数据。在深入Elasticsearch之前，必须了解一下它的核心概念。

# 近实时 （Near Realtime，NRT）

Elasticsearch是一个近实时的搜索引擎，这就意味着从索引一个文档（document）到该文档可被查询之间有轻微的延迟。

# 集群（Cluster)

集群是一个或多个节点（服务器）的集合，这些节点共享同一个cluster name。节点只能属于一个集群。单个集群的节点数量没有限制。

集群中保存了所有的数据，并在各个节点之上提供索引和搜索功能。

# 节点（Node）

节点就是单台服务器，有自己的节点名称（启动时赋予一个默认的随机UUID）。

节点根据配置的cluster name加入某个集群，默认为 `elasticsearch`。

每个节点都可以处理 HTTP层 和 运输层（Transport）的通信。前者为外部的 REST 客户端所用，后者用于节点间的通信。

每个节点都知道其它节点的位置，并能够将客户端请求转发给合适的节点。根据职责的不同，节点可分为：

- Master-eligible node。`node.master`为`true`（默认），意味着该节点可以被选举为 master。
- Data node。`node.data`为`true`（默认），它负责存储数据，执行数据相关的CRUD、搜索、聚合操作。
- Ingest node。`node.ingest`为`true`（默认），它能够在索引之前预处理文档：拦截文档的 bulk 和 index 请求，施加转换，然后再将文档传回给 bulk 和 index API。用户可以定义一个管道，指定一系列的预处理器。
- Tribe node。通过`tribe.*`配置，是一种特殊类型的协调节点，它连接多个集群，接受同事对多个集群的查询和操作。

## 协调节点

收到用户请求的节点被称为协调节点，请求的处理可以分为两个阶段：

1. scatter 阶段。协调节点将请求转发给持有数据的节点。每个节点在本地执行请求，并将结果返回给协调节点。
2. gather 阶段。协调节点将收到的结果归并，然后返回给用户。

每个节点都是隐式的协调节点，`node.master`, `node.data` 和 `node.ingest` 都为 `false`的节点是纯粹的协调节点。

# 索引（Index）

索引是具有相似特征的文档的集合（document）。例如，你有一个客户数据的索引，以及一个产品目录的索引。

索引根据名称（小写）来区分。名称相当于索引的引用，当索引、搜索、更新、删除文档时，都是根据名称来定位索引的。

单个集群中的索引数量也没有限制。

# 类型（Type）

在索引内，你可以定义一个或多个类型。类型是索引的逻辑分类，而分类的规则完全取决于你。通常来说，类型可以定义为拥有共同字段（field）的文档集合。

假设一个博客平台， 所有的数据都放在一个索引中。在这个索引中，你可将用户数据定义为一个类型，博客数据一个类型，评论数据一个类型。

# 文档（Document）

文档是索引中信息的基本单元。比如某个用户信息，就是一条文档。文档采用JSON描述。

在索引/类型内，你可以存无数的文档。一个文档只能属于一个索引，也必须被赋给某个类型。

# 分片和备份（Shards & Replicas）

Elasticsearch 针对超大的索引提供了分片机制，即 shards。创建一个索引的时候，你可以指定它的分片个数。每个分片都是一个完全独立可用的『索引』。

分片的意义在于：

- 水平拆分和扩展
- 支持并发操作

分片如何分发、文档如何聚合成搜索请求等操作都在 Elasticsearch 内部完成，对用户来说是透明的。

为了提高可靠性，Elasticsearch还针对分片提供了备份机制，即 replica shards。

备份的意义在于：

- 节点/分片宕掉之后的高可用。需要说明的是，replica 和它的 primary shard 不在同一节点。
- 提高查询的并发，因为可以在备份上执行查询。



综上所述，每个索引都被分成多个分片。索引可以设置是否备份。一旦设置了备份，每个索引都有primary shards 和 replica shards。备份机制是索引级别的，索引创建之时，备份机制即生效，之后可以动态修改备份的个数。但是，你不能修改分片的个数。

默认情况下，每个索引分配了5个primary shards 和 1个 replia。这就意味着集群中至少需要两个节点。

