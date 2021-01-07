<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [最大报文段长度](#%E6%9C%80%E5%A4%A7%E6%8A%A5%E6%96%87%E6%AE%B5%E9%95%BF%E5%BA%A6)
- [TCP的半关闭](#tcp%E7%9A%84%E5%8D%8A%E5%85%B3%E9%97%AD)
- [TCP的状态变迁图](#tcp%E7%9A%84%E7%8A%B6%E6%80%81%E5%8F%98%E8%BF%81%E5%9B%BE)
- [复位报文段](#%E5%A4%8D%E4%BD%8D%E6%8A%A5%E6%96%87%E6%AE%B5)
- [同时打开](#%E5%90%8C%E6%97%B6%E6%89%93%E5%BC%80)
- [同时关闭](#%E5%90%8C%E6%97%B6%E5%85%B3%E9%97%AD)
- [TCP选项](#tcp%E9%80%89%E9%A1%B9)
- [导航](#%E5%AF%BC%E8%88%AA)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

建立一个连接需要三次握手，而终止一个连接要经过4次握手。

为了建立一条TCP连接：

1、请求端（通常称为客户）发送一个SYN段指明客户打算连接的服务器的端口，以及初始序号。这个 SYN段为报文段1 。
2、服务器发回包含服务器的初始序号的SYN报文段（报文段2）作为应答。同时，将确认序号设置为客户的ISN加1 以对客户的 SYN报文段进行确认。一个SYN将占用一个序号。
3、客户必须将确认序号设置为服务器的ISN加1 以对服务器的SYN报文段进行确认（报文段 3）。

![img](img/chap18/img0.png)

![img](img/chap18/img1.png)

# 最大报文段长度

最大报文段长度MSS表示TCP传往另一端的最大块数据的长度。当一个连接建立时，连接的双方都要通告各自的MSS。

MSS让主机限制另一端发送数据报的长度。加上主机也能控制它发送数据报的长度，这将使以较小MTU连接到一个网络上的主机避免分段。

# TCP的半关闭

TCP提供了连接的一端在结束它的发送后还能接收来自另一端数据的能力。

![img](img/chap18/img2.png)
 

# TCP的状态变迁图

![graphic](img/chap18/img3.png)

# 复位报文段

TCP首部中的RST比特是用于“复位”的。一般说来，无论何时一个报文。段发往基准的连接（ referenced connection）出现错误，TCP都会发出一个复位报文段（这里提到的“基准的连接”是指由目的 I P地址和目的端口号以及源 I P地址和源端口号指明的连接）。

产生复位的一种常见情况是当连接请求到达时，目的端口没有进程正在听。对于 UDP，我们在6 、5 节看到这种情况，当一个数据报到达目的端口时，该端口没在使用，它将产生一个 I C M P端口不可达的信息。而 TCP则使用复位。

异常终止一个连接，或者检测半打开连接都需要发送一个复位报文段。

# 同时打开

两个应用程序同时彼此执行主动打开的情况是可能的。每一方必须发送一个SYN，且这些SYN 必须传递给对方。这需要每一方使用一个对方熟知的端口作为本地端口。这又称为同时打开。

![graphic](img/chap18/img4.png)

# 同时关闭

![graphic](img/chap18/img5.png)

# TCP选项

![graphic](img/chap18/img6.png)

# 导航

[目录](README.md)

上一章：[17、TCP：传输控制协议](17、TCP：传输控制协议.md)

下一章：[19、TCP的交互数据流](19、TCP的交互数据流.md) 
