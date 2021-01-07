<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [6.2 curses术语](#62-curses%E6%9C%AF%E8%AF%AD)
- [6.3 屏幕](#63-%E5%B1%8F%E5%B9%95)
- [6.4 键盘](#64-%E9%94%AE%E7%9B%98)
- [6.5 窗口](#65-%E7%AA%97%E5%8F%A3)
- [6.6 子窗口](#66-%E5%AD%90%E7%AA%97%E5%8F%A3)
- [6.7 keypad模式](#67-keypad%E6%A8%A1%E5%BC%8F)
- [6.8 彩色显示](#68-%E5%BD%A9%E8%89%B2%E6%98%BE%E7%A4%BA)
- [6.9 pad](#69-pad)
- [导航](#%E5%AF%BC%E8%88%AA)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

查看自己的curses配置情况
> ls -l /usr/include/*curses.h  

查看库文件
> ls -l /usr/lib/lib*curses*

`gcc program -lcurses`

# 6.2 curses术语

curses例程工作在屏幕、窗口和子窗口之上。所谓屏幕就是你正在写的设备。屏幕占据了设备上全部的可用显示面积  

无论何时，至少存储一个curses窗口，即stdscr，与物理屏幕的尺寸完全一样  

curses函数库用两个数据结构来映射终端屏幕

1. stdscr 会在curses函数产生输出时被刷新，stdscr对应的是标准屏幕
2. curscr 对应于当前屏幕的样子

在程序调用refresh之前，输出到stdscr上的内容不会出现在显示屏幕上。curses会只奥refresh被调用时比较stdscr和curscr的不同，然后利用两者的差异来刷新屏幕

使用curses输出字符的过程如下
1. 使用curses刷新逻辑屏幕
2. 使用curses的refresh刷新物理屏幕

# 6.3 屏幕

所有的curses程序必须以initscr函数开始，以endwin结尾

```c
#include  <curses.h>
WINDOW *initscr(void)
int endwin(void)
```

刷新屏幕的基本函数

```c
int addch(const chtype char_to_add) // add系列函数在光标的当前位置添加指定的字符或字符串
int addchstr(chtype *const string_to_add)
int printw(char *format, ...) // 添加字符串到光标的当前位置
int refresh(void)
int box(WINDOW *win_ptr, chtype vertical_char, chtype horizontal_char)  // 围绕一个窗口绘制方框
int insch(chtype char_to_insert) // 插入一个字符，将已有字符右移
int insertln(void) // 插入一个空白函
int delch(void) // 与上面的insert相反
int deleteln(void)
int beep(void) // 让程序发出声音，没有声音的话就让屏幕闪烁
int flash(void) // 让屏幕闪烁，如果不能，发出声音
```

从屏幕获取
```c
chtype inch(void)
int instr(char *string)
int innstr(cha *string, int number_of_char)
```

清除屏幕
```c
int erase(void) // 在每个屏幕位置写上空白字符
int clear(void) // 与erase类似，但可以内部调用一个底层函数clearok来强制重现屏幕原文。clear通常是通常是使用一个终端命令来清除整个屏幕，而不是尝试删除当前屏幕上每个非空白的位置
int clrtobot(void) // 清除当前光标到屏幕结尾
int clrtoeol(void)  // 清除当前坐标到行尾
```

移动光标
```c
int move(int new_y, int new_x) // 移动逻辑光标，要立刻显示要refresh
int leaveok(WINDOW *window_ptr, bool leave_flag) // 设置一个标志，用于控制在屏幕刷新后curses将物理光标放置的位置
```

字符属性
```c
int attron(chtype attribute) //启用指定属性
int attroff(chtype attribute) 
int attrset(chtype attribute) // 设置curses属性
int standout(void) // “突出”模式，一般是反白显示
int standend(void)
```

# 6.4 键盘

设置键盘模式
```c
int echo(void) // 设置输入字符的回显功能
int noecho(void)
int cbreak(void) // 关于预处理模式（基于行的，用户按下回车键后，数据才会传送给程序）
int nocbreak(void)
int raw(void) // 关闭特殊字符的处理
int noraw(void)
```

键盘输入
```c
int getch(void)
int getstr(char *string)
int getnstr(char *string, int number_of_characters)
int scanw(char *format, ...)
```

# 6.5 窗口

stdscr只是WINDOW结构的一个特例
```c
WINDOW *newwin(int num_of_lines, int num_of_cols, int start_y, int start_x)
int delwin(WINDOW *window_to_delete)
```

通用函数
```c
int addch(const chtype char)
int waddch(WINDOW *window_pointer, const chtype char)
int mvaddch(int y, int x, const chtype char)
int wmvaddch(WINDOW *window_pointer, int y, int x, const chtype char)
int printw(char *format, ...)
int wprintw(WINDOW *window_pointer, char *format, ...)
int mvprintw(int y, int x, char *format, ...)
int mvwprintw(WINDOW *window_pointer, int y, int x, char *format, ...)
```

移动和更新窗口
```c
int mvwin(WINDOW *window_pointer, int new_y, int new_x)
int wrefresh(WINDOW *window_pointer)
int wclear(WINDOW *window_pointer)
int werase(WINDOW *window_pointer)
int touchwin(WINDOW *window_pointer)
int scrollok(WINDOW *window_pointer, bool scroll_flag)
int scroll(WINDOW *window_pointer)
```

# 6.6 子窗口 
```c
WINDOW *subwin(WINDOW *parent, int num_of_line, int num_of_cols, int start_y, int start_x)
int delwin(WINDOW *window_to_delete)
```

子窗口没有独立的屏幕字符存储空间。这意味着，子窗口内的任何修改都会反映到父窗口中，删除子窗口后，屏幕显示不会有任何变化


# 6.7 keypad模式
curses函数库提供了管理功能键的功能，对于每个终端来说，它的每个功能键多对应的转义序列都被保存，通常在一个terminfo结构中，而头文件curses.h通过一组前缀以KEY_的定义来管理逻辑键

curses在启动时回关闭转义字符于逻辑键之间的转换功能，该功能需要通过调用keypad函数来启用：
```c
int keypad(WINDOW *window_ptr, bool keypad_on)
```

# 6.8 彩色显示
检查当前终端是否支持彩色显示
```c
bool has_colors(void)
int start_color(void)
init_pair对准备使用的颜色组合进行初始化，对颜色属性的访问时通过COLOR_PAIR函数来完成的，pair_content获取已定义的颜色组合信息
int init_pair(short pair_number, short foreground, short background)
int COLOR_PAIR(int pair_number)
int pair_content(short pair_number, short *forground, short *background)
```

# 6.9 pad
pad可以控制尺寸大于正常窗口的逻辑屏幕。pad结构非常类似WINDOW结构，所有执行写窗口操作的curses函数同样适用于pad

创建pad
```c
WINDOW *newpad(int num_of_lines, int num_of_cols)
刷新pad，因为pad并不局限于某个特定的屏幕位置，所以必须指定需要放到屏幕上的pad范围及其位置
int prefresh(WINDOW *pad, int pad_row, int pad_col, int screen_row_min, int screen_col_min, int screen_row_max, int screen_col_max)
```

# 导航

[目录](README.md)

上一章：[5. 终端](终端.md)

下一章：[7. 数据管理](数据管理.md)