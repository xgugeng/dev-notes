<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [声明](#%E5%A3%B0%E6%98%8E)
- [优先级](#%E4%BC%98%E5%85%88%E7%BA%A7)
- [typedef](#typedef)
- [导航](#%E5%AF%BC%E8%88%AA)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# 声明

C语言中，对象的声明形式与它的使用形式尽可能相似。

`const int * ptr` 与`int const * ptr`相同。

合法的声明存在限制条件：

1. 函数的返回值不能是一个函数
2. 函数的返回值不能是一个数组
3. 数组里面不能有函数，`foo[]()`

以下法则是合法的

1. 函数返回值是一个函数指针
2. 函数返回值是一个数组指针
3. 数组里面可以有函数指针
4. 数组里面可以有其他数组

struct 结构标签（可选）｛

类型1 标识符1

｝变量定义（可选）

结构标签可以作为`struct {}`的简写形式。

结构中允许存在位段、无名字段以及字对其所需的填充字段。这些都是通过在字段声明后面加一个冒号以及一个表示字段位长的整数来实现的。

一行代码只做一件事，看上去更简单一些。

参数在传递时尽可能存放在寄存器中。

在struct中，每个成员依次存储，而在联合中，所有的成员都是从偏移地址零开始存储。这样每个成员的位置都重叠在一起，某一时刻，只能有一个成员真正存储于该地址。

联合被用来节省空间。

联合也可以把同一数据解释成两种不同的东西（判断大小端）。

枚举能完成的，`#define`也可以。但是`#define`定义的名字一般在编译时被丢弃，而枚举名字在调试器中一直可见。

 

# 优先级

声明的优先级规则。

A 声明从它的名字开始读取，然后按照优先级顺序依次读取。

B 优先级从高到低一次是：

     B.1 声明中括号的部分

     B.2 后缀操作符

     括号（）表示这是一个函数，而[]表示数组

     B.3 前缀操作符，*表示指针

C 如果`const`或`volatile`后紧跟类型说明符，那作用于类型说明符，其他情况下，作用于它左边紧邻的指针星号。

 

# typedef

typedef表示为一种类型引入新的名字，而不是为变量分配空间。可以出现在靠近声明开始部分的任何地方。

不要把typedef放到声明的中间部分。

`typedef` 与 `#define` 区别

1. typedef看成是一种彻底的封装类型，声明它之后不能再往里面加别的东西。

    1.1 可以用其他类型说明符对宏类型名进行扩展，但typedef不可以

    `#define peach int; unsigned peach i;`可以

    `typedef int banana; unsigned banana i;` 不可以

    1.2 在连续几个变量说明中，`typedef` 定义的类型能保证声明中所有的变量均为同一类型，`#define` 无法保证。

    `#define int_ptr int*; int_ptr chalk, cheese；` 扩展为 `int* chalk, cheese;`

不要为了方便而对结构使用typedef

# 导航

[目录](README.md)

上一章：[2. 这不是bug，而是语特性](2. 这不是bug，而是语言特性.md)

下一章：[4. 数组和指针并不相同](4. 数组和指针并不相同.md)
