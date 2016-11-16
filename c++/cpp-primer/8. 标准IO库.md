# 面向对象的标准库

三个独立的头文件定义：iostream读写控制窗口的类型，fstream读写已命名文件的类型，sstream读写存储在内存中的string。后两者从iostream派生而来。

国际字符的支持：支持wchar_t，每个类前加上”w”前缀。

IO对象不可复制或赋值。

形参或返回类型也不能为流类型，但可以使引用或指针。

 

# 条件状态

IO标准库管理了一系列条件状态成员，用来标记给定的IO对象是否可用，或遇到了某种错误。

strm:iostate, strm:badbit, s.eof(), s.fail(), s.bad(), s.clear(), s.setstate(flag)

所有流对象都包含一个条件状态成员，由setstate和clear操作管理。

每个IO类还定义了3个iostate类型的常量，分别表示特定的位模式：badbit, failbit, eofbit。

流的状态由bad，fail，eof和good操作揭示。

 

# 输出缓冲区的管理

以下几种情况会导致缓冲区的内容被刷新：

1、 程序正常结束，main返回时会清空输出缓冲区。

2、 缓冲区已满，写之前，刷新。

3、 用操作符显式刷新，比如endl、flush(不在输出添加任何东西)、ends（在缓冲区插入null）。

4、 每次输出操作执行完后，用unitbuf设置流的内部状态。

5、 可将输出流与输入流关联起来，这样在读输入流时就刷新了。

unitbuf，刷新所有输出，nounitbuf将流恢复到系统管理的方式。

系统崩溃，不会刷新缓冲区。

tie函数将istream和ostream绑定起来，cout与cin本来就是绑定的，一个ostream对象每次只能和一个istream对象绑定。

 

# 文件的输入输出

ifstream，由istream派生，读文件。

ofstream，由ostream派生，写文件。

fstream，由iostream派生，读写同一文件。

创建fstream对象时，调用open使用的文件名是C风格字符串，而不是标准库string对象。

如果要重用文件流读写多个文件，必须在读另一文件前调用clear清除该流的状态。

文件模式：in，out，app，ate，trunc（打开文件时清空已存在的文件流），binary。

 

# 字符串流

istringstream，ostringstream，stringstream

# 导航

[目录](README.md)

上一章：[7. 函数](7. 函数.md)

下一章：[9. 顺序容器](9. 顺序容器.md)
