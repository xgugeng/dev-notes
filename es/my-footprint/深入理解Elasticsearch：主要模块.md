<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [集群路由和分片分配（Cluster-level routing and shard allocation）](#%E9%9B%86%E7%BE%A4%E8%B7%AF%E7%94%B1%E5%92%8C%E5%88%86%E7%89%87%E5%88%86%E9%85%8Dcluster-level-routing-and-shard-allocation)
  - [1. 集群级别的分片分配](#1-%E9%9B%86%E7%BE%A4%E7%BA%A7%E5%88%AB%E7%9A%84%E5%88%86%E7%89%87%E5%88%86%E9%85%8D)
    - [分片分配的设置](#%E5%88%86%E7%89%87%E5%88%86%E9%85%8D%E7%9A%84%E8%AE%BE%E7%BD%AE)
- [发现（Discovery）](#%E5%8F%91%E7%8E%B0discovery)
- [网关（Gateway）](#%E7%BD%91%E5%85%B3gateway)
- [HTTP](#http)
- [索引（Indices）](#%E7%B4%A2%E5%BC%95indices)
- [网络（Network）](#%E7%BD%91%E7%BB%9Cnetwork)
- [节点客户端（Node client）](#%E8%8A%82%E7%82%B9%E5%AE%A2%E6%88%B7%E7%AB%AFnode-client)
- [无痛（Pailess）](#%E6%97%A0%E7%97%9Bpailess)
- [插件（Plugins）](#%E6%8F%92%E4%BB%B6plugins)
- [脚本（Scripting）](#%E8%84%9A%E6%9C%ACscripting)
- [快照（Snapshot/Restore)](#%E5%BF%AB%E7%85%A7snapshotrestore)
- [线程池（Thread pools）](#%E7%BA%BF%E7%A8%8B%E6%B1%A0thread-pools)
- [传输（Transport）](#%E4%BC%A0%E8%BE%93transport)
- [Tribe 节点（Tribe nodes）](#tribe-%E8%8A%82%E7%82%B9tribe-nodes)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

Elasticsearch中每个模块的设置可以是：

- 静态的。这些设置是节点级别的，要么在`elasticsearch.yml`、要么在环境变量、要么在命令行启动参数。
- 动态的。使用API更新。

# 集群路由和分片分配（Cluster-level routing and shard allocation）

> 控制分片什么时候、怎样分配给哪个节点。

集群相关的设置都是动态的，可以通过API调整。

## 1. 集群级别的分片分配

分片分配是将分片放到节点的过程，它可以发生在初始化回复、备份分配、rebalance、移除或新增节点时。

### 分片分配的设置

分片分配和恢复的常见设置：

- `cluster.routing.allocation.enable` 控制特定类型的分片分配。
- ​



# 发现（Discovery）

>  节点如何相互发现从而构成一个集群。

# 网关（Gateway）

> 恢复启动之前有多少个节点需要加入集群。

# HTTP

> 控制HTTP REST 接口

# 索引（Indices）



# 网络（Network）



# 节点客户端（Node client）

> Java 节点客户端加入集群，但不存储任何数据，也不能成为master节点。

# 无痛（Pailess）

> Elasticsearch内置的脚本语言，旨在安全。

# 插件（Plugins）

# 脚本（Scripting）

# 快照（Snapshot/Restore)

# 线程池（Thread pools）

# 传输（Transport）

> 配置网络传输层，Elasticsearch用来实现节点间的通信。

# Tribe 节点（Tribe nodes）

> 一个Tribe节点可以加入一个或多个集群，在多个集群的范围内扮演一个联邦客户端(federated client)。

