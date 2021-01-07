<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [5.2 RARP的分组格式](#52-rarp%E7%9A%84%E5%88%86%E7%BB%84%E6%A0%BC%E5%BC%8F)
- [5.4 RARP服务器的设计](#54-rarp%E6%9C%8D%E5%8A%A1%E5%99%A8%E7%9A%84%E8%AE%BE%E8%AE%A1)
- [导航](#%E5%AF%BC%E8%88%AA)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

无盘系统的RARP实现过程是从接口卡上读取唯一的硬件地址，然后发送一份RARP请求（一帧在网络上广播的数据），请求某个主机响应该无盘系统的IP地址（在RARP应答中）。

# 5.2 RARP的分组格式

RARP分组的格式与ARP分组基本一致。它们之间主要的差别是RARP请求或应答的帧类型代码为 0x8035，而且RARP请求的操作代码为 3，应答操作代码为4。

对应于ARP，RARP请求以广播方式传送，而RARP应答一般是单播(unicast)传送的 。

# 5.4 RARP服务器的设计

RARP服务器的功能由用户进程来提供，原因在于硬件地址和IP地址的映射保存在磁盘文件中，内核一般不读取和分析磁盘文件。

RARP请求是作为一个特殊类型的以太网数据帧发送的。

RARP服务器实现的一个复杂因素是 RARP请求是在硬件层上进行广播的，这意味着它们不经过路由器进行转发。

# 导航

[目录](README.md)

上一章：[4、ARP：地址解析协议](4、ARP：地址解析协议.md)

下一章：[6、ICMP：Internet控制报文协议](6、ICMP：Internet控制报文协议.md)
