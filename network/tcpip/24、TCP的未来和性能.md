<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [路径MTU发现](#%E8%B7%AF%E5%BE%84mtu%E5%8F%91%E7%8E%B0)
- [窗口扩大选项](#%E7%AA%97%E5%8F%A3%E6%89%A9%E5%A4%A7%E9%80%89%E9%A1%B9)
- [为事务用的TCP扩展](#%E4%B8%BA%E4%BA%8B%E5%8A%A1%E7%94%A8%E7%9A%84tcp%E6%89%A9%E5%B1%95)
- [导航](#%E5%AF%BC%E8%88%AA)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# 路径MTU发现

TCP的路径MTU发现按如下方式进行：在连接建立时，TCP使用输出接口或对端声明的MSS中的最小MTU作为起始的报文段大小。路径 MTU发现不允许TCP超过对端声明的MSS。如果对端没有指定一个MSS，则默认为536。一个实现为每个路由单独保存路径MTU信息。

# 窗口扩大选项

窗口扩大选项使最大的 TCP窗口从65535增加到1千兆字节以上。时间戳选项允许多个报文段被精确计时，并允许接收方提供序号回绕保护（PAWS）。这对于高速连接是必须的。这些新的TCP选项在连接时进行协商，并被不理解它们的旧系统忽略，从而允许较新的系统与旧的系统进行交互。

# 为事务用的TCP扩展

为事务用的TCP扩展，即T / TCP，允许一个客户/服务器的请求-应答序列在通常的情况下只使用三个报文段来完成。它避免使用三次握手，并缩短了 TIME_WAIT状态，其方法是为每个主机高速缓存少量的信息，这些信息曾用来建立过一个连接。它还在包含数据报文段中使用SYN和FIN标志。
     
由于还有许多关于TCP能够运行多快的不精确的传闻，因此我们以对 TCP性能的分析来结束本章。对于一个使用本章介绍的较新特征、协调得非常好的实现而言， TCP的性能仅受最大的1千兆字节窗口和光速（也就是往返时间）的限制。

# 导航

[目录](README.md)

上一章：[23、TCP的保活定时器](23、TCP的保活定时器.md)

下一章：[25、SNMP：简单网络管理协议](25、SNMP：简单网络管理协议.md)
