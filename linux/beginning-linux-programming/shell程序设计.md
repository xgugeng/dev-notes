<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [2.4 管道和重定向](#24-%E7%AE%A1%E9%81%93%E5%92%8C%E9%87%8D%E5%AE%9A%E5%90%91)
- [2.6 shell的语法](#26-shell%E7%9A%84%E8%AF%AD%E6%B3%95)
  - [2.6.1 变量](#261-%E5%8F%98%E9%87%8F)
  - [2.6.2 条件](#262-%E6%9D%A1%E4%BB%B6)
  - [2.6.3 控制结构](#263-%E6%8E%A7%E5%88%B6%E7%BB%93%E6%9E%84)
  - [2.6.4 函数](#264-%E5%87%BD%E6%95%B0)
  - [2.6.5 命令](#265-%E5%91%BD%E4%BB%A4)
- [导航](#%E5%AF%BC%E8%88%AA)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# 2.4 管道和重定向

` kill -11234 > xx.txt 2>&1 `

也可以将 `xx.txt` 改成回收站 `/dev/null`


重定向输入：` more <killout.txt `

 

可以用 `|` 来连接进程，与DOS不同的是，Linux下管道连接的进程可以同时运行，并且随着数据流的传递可以自动地协调。

 

`#!/bin/sh` 告诉系统同一行上紧跟它后面的那个参数是用来执行本文件的程序。

 

# 2.6 shell的语法

## 2.6.1 变量

不需要在使用变量之前声明它，shell区分变量的大小写，环境变量一般大写。

在shell中，你可以通过变量名前加一个$来访问它的内容，赋值时，直接使用变量名。

字符串放在双引号中，以防止变量被空白字符分给，又支持 `$` 扩展。

 

如果脚本程序在调用时带有参数，那么会创建一些额外变量，即使没有传递参数，环境变量  `$#`（传递给脚本的参数个数）依然存在

| $1, $2,  … | 脚本程序的参数                               |
| ---------- | ------------------------------------- |
| $*         | 在一个变量中列出所有的参数，各个参数中间用环境变量IFS的第一个字符分隔开 |
| $@         | $*的变体                                 |

 

其他特殊变量

| $?   | 上一个命令的返回值       |
| ---- | --------------- |
| $$   | 当前shell进程的pid   |
| $!   | 后台运行的最后一个进程的pid |
| $-   | 显示shell使用的当前选项  |
| $_   | 之前命令的最后一个参数     |

 

## 2.6.2 条件

```shell
if test -ffred.c
then
…
fi

```

等同于

```shell
 if [ -f fred.c]
then 
…
fi
```



 

## 2.6.3 控制结构

```shell
if
then ...
elif ...
else ...
fi

for foo inxxx
do
...
done

while xxx
do
...
done

util xxx
do
...
done

case varin
pattern [ | pattern] ...)
statements;;
esac
```

 

AND列表 ：`s1 && s2 …`

OR列表：`s1 || s2 …`

 

## 2.6.4 函数

函数定义 ：

```sh
fun_name()
{
...
}
```

P.S.  shell不存在前向声明，必须先定义再使用

 

## 2.6.5 命令

冒号：是一个空命令

点命令. 在当前shell中执行命令 ../shell_script. 等同于 source ./shell_script

expr 将它的参数作为一个表达式来求值

set 为shell设置参数变量

shift 把所有的参数左移一个位置，使得$2变成$1, $3变成$2

trap 用于指定在接收到信号后要采取的行动

unset 从环境中删除变量或函数

 

命令的执行

算数扩展 $(( ... ))

# 导航

[目录](README.md)

上一章：[1. 入门](入门.md)

下一章：[3. 文件操作](文件操作.md)
