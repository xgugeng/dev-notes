<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [经受延时的确认](#%E7%BB%8F%E5%8F%97%E5%BB%B6%E6%97%B6%E7%9A%84%E7%A1%AE%E8%AE%A4)
- [Nagle算法](#nagle%E7%AE%97%E6%B3%95)
- [导航](#%E5%AF%BC%E8%88%AA)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

交互数据总是以小于最大报文段长度的分组发送。

# 经受延时的确认

对于这些小的报文段，接收方使用经受时延的确认方法来判断确认是否可被推迟发送，以便与回送数据一起发送。这样通常会减少报文段的数目，尤其是对于需要回显用户输入字符的Rlogin会话。

TCP将以最大 200 ms 的时延等待是否有数据一起发送。

# Nagle算法

在较慢的广域网环境中，通常使用 Nagle算法来减少这些小报文段的数目。这个算法限制发送者任何时候只能有一个发送的小报文段未被确认。

该算法要求一个TCP连接上最多只能有一个未被确认的未完成的小分组，在该分组的确认到达之前不能发送其他的小分组。相反， TCP收集这些少量的分组，并在确认到来时以一个分组的方式发出去。

# 导航

[目录](README.md)

上一章：[18、TCP连接的建立与终止](18、TCP连接的建立与终止.md)

下一章：[20、TCP的成块数据流](20、TCP的成块数据流.md)
