<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [11.1 AOF持久化的实现](#111-aof%E6%8C%81%E4%B9%85%E5%8C%96%E7%9A%84%E5%AE%9E%E7%8E%B0)
  - [命令追加](#%E5%91%BD%E4%BB%A4%E8%BF%BD%E5%8A%A0)
  - [AOF文件的写入与同步](#aof%E6%96%87%E4%BB%B6%E7%9A%84%E5%86%99%E5%85%A5%E4%B8%8E%E5%90%8C%E6%AD%A5)
- [11.2 AOF文件的载入与数据还原](#112-aof%E6%96%87%E4%BB%B6%E7%9A%84%E8%BD%BD%E5%85%A5%E4%B8%8E%E6%95%B0%E6%8D%AE%E8%BF%98%E5%8E%9F)
- [11.3 AOF重写](#113-aof%E9%87%8D%E5%86%99)
  - [实现](#%E5%AE%9E%E7%8E%B0)
- [导航](#%E5%AF%BC%E8%88%AA)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

AOF（Append Only File）持久化，与RDB持久化通过保存数据库中的键值对来记录数据库状态不同，AOF保存Redis所执行的写命令来记录数据库状态。被写入AOF文件的命令都是以Redis的命令请求协议格式保存的，纯文本格式，打开即可查看。

# 11.1 AOF持久化的实现

AOF持久化功能的实现可分为命令追加（append）、文件写入、文件同步（sync）三个步骤。

## 命令追加

如果打开AOF功能，服务器在执行完一个写命令后，会以协议格式将被执行的命令追加到服务器状态的`aof_buf`缓冲区的末尾。

```c
struct redisServer {
  // ...
  sds aof_buf;
  // ...
};
```

## AOF文件的写入与同步

Redis的服务器进程就是一个事件循环（loop），这个循环中的文件事件负责接受客户端的请求，并向客户端发送回复，而时间事件则负责执行像`serverCron`函数这样的定时任务。

服务器在处理文件任务时可能会执行写命令，追加内容到`aof_buf`缓冲区，所以服务器在每次结束一个事件循环前，都会调用`flushAppendOnlyFile`，考虑是否将缓冲区的内容写入到AOF文件中。

> flushAppendOnlyFile函数的行为由服务器配置的`appendfsync`选项的值来决定：always、everysec（默认）、no。

# 11.2 AOF文件的载入与数据还原

服务器只要读入并重新执行一遍AOF文件中的写命令，就可以还原服务器关闭之前的数据库状态：

1. 创建一个不带连接的**伪客户端**。

2. 从AOF文件中分析并读取一条写命令。

3. 使用伪客户端执行被读出的命令

4. 一直执行步骤2和3，知道AOF文件中的所有命令都被处理完位置。

# 11.3 AOF重写

为了解决AOF文件体积膨胀的问题，Redis提供了AOF重写功能。通过该功能，Redis可以创建一个新的AOF文件来替代现有的AOF文件，新文件不会包含荣誉命令，体积也会小很多。

## 实现

AOF文件重写不需要对现有AOF文件做任何读取、分析或写入操作，而是通过读取服务器当前的数据库状态实现的。首先从数据库中读取现在的键，然后用一条命令去记录键值对，代替之前记录这个键值对的多条命令。这就是AOF重写的实现原理。

Redis服务器采用单个线程来处理命令请求，所以将AOF重写程序放到子进程中，这样父进程可以继续处理请求。父子进程会出现数据不一致的问题，Redis服务器设置了一个AOF重写缓冲区，这个缓冲区在创建子进程之后开始使用，但Redis服务器执行完一个写命令后，会通知将写命令发送给AOF缓冲区和AOF重写缓冲区。子进程完成AOF重写操作后，向父进程发送一个信号，父进程将执行以下操作：

1. 将AOF重写缓冲区的内容写入新AOF文件。

2. 对新的AOF文件改名，覆盖现有的AOF文件。

# 导航

[目录](README.md)

上一章：[10、RDB持久化](10、RDB持久化.md)

下一章：[12、事件](12、事件.md)
