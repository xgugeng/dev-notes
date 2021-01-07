<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [多做之过](#%E5%A4%9A%E5%81%9A%E4%B9%8B%E8%BF%87)
  - [switch](#switch)
  - [字符串连接](#%E5%AD%97%E7%AC%A6%E4%B8%B2%E8%BF%9E%E6%8E%A5)
  - [缺省可见性](#%E7%BC%BA%E7%9C%81%E5%8F%AF%E8%A7%81%E6%80%A7)
- [误做之过](#%E8%AF%AF%E5%81%9A%E4%B9%8B%E8%BF%87)
- [少做之过](#%E5%B0%91%E5%81%9A%E4%B9%8B%E8%BF%87)
- [导航](#%E5%AF%BC%E8%88%AA)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

`malloc(strlen(str))`几乎总是错的，`malloc(strlen(str)+1)`才是正确的。

所有的缺陷可归为3类：多做，少做，误做。

`NUL`用于结束一个ACSII字符串，`NULL`用于表示空。

 

# 多做之过

## switch

switch语句，default可以出现在case列表的任何位置，它在其它case均无法匹配时被执行。

标准的C编译器至少允许一条switch语句有257个case标签，这是为了允许switch满足一个8bit字符是所有情况（256+EOF）。

可以在switch的左花括号之后声明一些变量，从而进行局部存储的分配。给这些变量加上初始值没有任何意义，因为她们不会被执行 --- 语句从匹配表达式的case开始执行的。

```c++
int cond = 0;
switch(cond)
{
    cond = 1;
    case 0:cout<< 0;break; 
    case 1:cout<< 1;break;
    default:cout<< "Nothing";
}
```

输出0

switch的另一个问题是它内部的任何语句都可以加上标签，允许跳转到那里。

C中，const并不是一个真正的常量，case TWO，可能会出错。

break语句跳出的是最近的那层循环或switch语句。

 

## 字符串连接

相邻的字符串常量将被自动合并成一个字符串，但书写多行信息时，在行末加\（旧风格）。

 

## 缺省可见性

在缺省情况下，函数的名字是全局可见的，也可以加extern，效果是一样的。但是，有时缺省可见性却不可靠，它会与C的另一特性interpositioning冲突，interpositioning指用户编写和库函数同名的函数并取而代之。

 

# 误做之过

sizeof的操作数是个类型名时，必须加上括号，但如果是变量就不必。

注意运算符的优先级：`int i = 1, 2` 等价于`(int i = 1), 2`

在表达式有布尔操作、算术运算、位操作等混合运算时，最好加括号。

在优先级和结合性混搭的表达式里，计算的次序未定义。

`x = f() + g() * h()`，你不知道三个函数哪个会先执行。

如果有几个优先级相同的操作符，结合性就起仲裁作用。

大部分表达式各个操作数计算的顺序是不确定的，&&和||除外。

在函数调用中，各个参数的计算顺序是不确定的。

gets函数并不检查缓冲区的空间，事实上也无法检查缓冲区的空间。

 

# 少做之过

空格不能乱用，比如在转义字符后面的。

`z = y+++x； ` 编译器将选取能组成最大字符序列的方案，`z = y++ + x`。

有两个指向int的指针，并相对两个int数据执行除法时，ratio = *x/*y。编译器会报错，/*之间缺少空格，会被解释为注释。

C++注释,

a //* 

//*/ b

在C中表示`a/b`，C++中 `a`

返回局部变量是很危险的，解决方法：

1. 返回一个指向字符串常量的指针：如果以后还要修改它，有点麻烦。
2. 使用全局声明的数组。
3. 使用静态数组：下次调用函数会覆盖数组，要提前使用或备份。
4. 显式分配一些内存，保存返回的值。
5. 要求调用者分配内存来保存函数的返回值。

# 导航

[目录](README.md)

上一章：[1. C：穿越时空的迷雾](1. C：穿越时空的迷雾.md)

下一章：[3. 分析C语言的声明](3. 分析C语言的声明.md)