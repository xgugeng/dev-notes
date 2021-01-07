<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [导航](#%E5%AF%BC%E8%88%AA)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

C++的整体设计目标是：让程序员觉得编程很愉快，一种通用的程序设计语言，更好的C，支持数据抽象，支持面向对象。

C++的一般性规则（社会性规则）

1. 它的发展必须由实际问题推动
2. 不要追求无益的过渡完美
3. C++必须是现在就有用滴
4. 每个特征必须存在一种合理的明显实现方式
5. 总提供一条转变的通路
6. C++是语言，而不是完整的系统
7. 为每种风格提供支持
8. 不试图强迫人做什么
9. 支持从分别开发的部分出发进行软件的组合

C++的技术性规则

1. 不隐式地违反静态类型系统
2. 为用户定义类型提供与内部类型同样好的支持
3. 局部化是好事情：代码局部化，访问局部化
4. 避免顺序依赖性
5. 如果有疑问，就选择与有关特征的那种最容易教给人的形式
6. 语法是重要的
7. 应该清除使用预处理程序的必要性

C++作为一种表述高层设计的语言，对低级程序设计支持规则

1. 使用传统的连接程序
2. 没有无故的与C的不兼容性
3. 在C++下面部位更低级的语言留下空间（汇编语言除外）：隔离低级特征
4. 对不用的东西不需要付出代价
5. 遇到有疑问的地方就提供手工控制的手段

# 导航

[目录](README.md)

上一章：[C++的诞生](C++的诞生.md)

下一章：[存储管理](存储管理.md)