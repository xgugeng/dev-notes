<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [第1章 vi文本编辑器](#%E7%AC%AC1%E7%AB%A0%C2%A0vi%E6%96%87%E6%9C%AC%E7%BC%96%E8%BE%91%E5%99%A8)
  - [打开关闭文件](#%E6%89%93%E5%BC%80%E5%85%B3%E9%97%AD%E6%96%87%E4%BB%B6)
  - [保存并离开文件](#%E4%BF%9D%E5%AD%98%E5%B9%B6%E7%A6%BB%E5%BC%80%E6%96%87%E4%BB%B6)
  - [结束不保存结果](#%E7%BB%93%E6%9D%9F%E4%B8%8D%E4%BF%9D%E5%AD%98%E7%BB%93%E6%9E%9C)
- [导航](#%E5%AF%BC%E8%88%AA)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# 第1章 vi文本编辑器

Unix环境下的编辑器有多种，一般可以分为

| 行编辑器  | ed ex  一次只能显示一行     |
| ----- | ------------------- |
| 全屏编辑器 | vi emacs   显示文件的一部分 |

vi命令的特点：

- 字母区分大小写 
- 输入时不会显示在屏幕上 
- 不需要在命令后按 `Enter` 键 

 

## 打开关闭文件

使用vi进行文本编辑的时候，是在内存里的文本副本上进行操作，也就是说是在缓冲区中进行操作，存储编辑的结果时，实际上是将缓冲区的内容写入文件中。

打开文件的命令是：
```
:vi [filename] 
```
 

## 保存并离开文件

命令模式 `ZZ` 或者 `:wq`

输入`:w`是保存文件，但不离开 vi

 

## 结束不保存结果

`:e!` 恢复到上一次存储的文件内容

`:q!` 消除所有编辑结果，并退出vi

`:w newfile` 可将编辑的结果写入新的文件（就是另存为）

# 导航

[目录](README.md)

下一章：[2. 简单的文本编辑器](2. 简单的文本编辑器.md)