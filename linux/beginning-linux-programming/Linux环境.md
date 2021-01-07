<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [4.1 程序参数](#41-%E7%A8%8B%E5%BA%8F%E5%8F%82%E6%95%B0)
  - [getopt函数](#getopt%E5%87%BD%E6%95%B0)
  - [ ](#)
  - [getopt_long函数](#getopt_long%E5%87%BD%E6%95%B0)
- [4.2 环境变量](#42-%E7%8E%AF%E5%A2%83%E5%8F%98%E9%87%8F)
- [4.3 时间和日期](#43-%E6%97%B6%E9%97%B4%E5%92%8C%E6%97%A5%E6%9C%9F)
- [4.4 临时文件](#44-%E4%B8%B4%E6%97%B6%E6%96%87%E4%BB%B6)
- [4.5 用户信息](#45-%E7%94%A8%E6%88%B7%E4%BF%A1%E6%81%AF)
- [4.6 主机信息](#46-%E4%B8%BB%E6%9C%BA%E4%BF%A1%E6%81%AF)
- [4.7 日志](#47-%E6%97%A5%E5%BF%97)
- [4.8 资源和限制](#48-%E8%B5%84%E6%BA%90%E5%92%8C%E9%99%90%E5%88%B6)
- [导航](#%E5%AF%BC%E8%88%AA)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# 4.1 程序参数

## getopt函数

将传递给main的argc和argv作为参数，同时接受一个选项指定字符串optstring，该字串告诉getopt哪些选项可用，以及其是否有关联值

```c
int getopt (int argc, char *const argv[], const char *optstring);

extern char *optarg;

extern int optind, opterr, optopt;
```

循环调用getopt可以一次得到每个选项

##  

## getopt_long函数

接受以双划线开始的长参数

 

# 4.2 环境变量

```c
char *getenv (const char *name);

int putenv (const char *string);
```

环境变量由“名字=值”的字符串组成。程序可以通过environ变量直接访问它

 

# 4.3 时间和日期

| time      | time_t time (time_t *tloc);              | 获得底层的时间值，返回的是1970年1月1日0时至今的秒数。如果tloc不为空，time函数还会把返回值指向tloc指向的位置 |
| --------- | ---------------------------------------- | ---------------------------------------- |
| difftime  | double difftime (time_t time1, time_t  time2); | 计算两个time_t值之间的秒数                         |
| gmtime    | struct  tm *gmtime(const time_t timeval); | 把底层时间值分解为一个结构                            |
| localtime | struct  tm *localtime (const time_t *timeval); | 返回当地时区的时间                                |
| mktime    | time_t  mktime (struct tm *timeptr);     | 把分解出的tm结构再转为time_t                       |
| asctime   | char *asctime (const struct tm *timeptr); | 返回值由tm结构给出的时间和日期                         |
| ctime     | char  *ctime (const time_t *timeval);    | 相当于调用asctime (localtime(timeval));       |
| strftime  | size_t  strftime (char *s, size_t maxsize, const char *format, struct tm *timeptr); | 格式化timeptr指向的tm结构所表示的时间，并将结果存入字符串s中      |
| strptime  | char *strptime (const char *buf, const  char *format, struct tm *timeptr); |                                          |

 

# 4.4 临时文件

| char  *tmpnam (char *s);                 | 生成一个唯一的文件名                            |
| ---------------------------------------- | ------------------------------------- |
| FILE  *tmpfile (void);                   | 返回一个文件流指针，指向唯一的临时文件，以读写方式打开。关闭时文件自动删除 |
| char  *mktemp (char *template);  int  mkstemp (char *template); | 为临时文件名指定一个模板。mkstemp类似于tmpfile        |

 

# 4.5 用户信息

| uid_t  getuid (void);                    | 返回程序关联的UID              |
| ---------------------------------------- | ----------------------- |
| char  *getlogin (void);                  | 返回与当前用户关联的登录名           |
| struct passed *getwuid (uid_t uid);      |                         |
| struct  passed *getwnam (const char *name); |                         |
| void  endpwent (void);                   |                         |
| struct  passwd *getpwent (void);         |                         |
| void  setpwent (void);                   |                         |
| uid_t  geteuid (void);  gid_t  getedig (void);  int  setuid (uid_t uid);  int  setgid (gid_t gid); | 只有超级用户才能调用setuid和setgid |

 

# 4.6 主机信息

```c
int gethostname (char *name, size_t namelen);

int uname (struct utsname *name);

int gethostid (void);
```

 

# 4.7 日志

```c
void syslog (int priority, const char *message, arguments...); //向系统发送一条日志

void closelog (void);

void openlog (const char *ident, int logopt, int facility);

int setlogmask (int maskpri):
```

 

# 4.8 资源和限制

`limits.h`中定义了许多OS限制的显式常量， `sys/resouce.h`提供了资源操作的定义

```c
int getpriority (int which, id_t who);

int setpriority (int which, id_t who, int priority);

int getrlimit (int resource, struct rlimit *r_limit);

int setrlimit (int resource, const struct rlimit *r_limit);

int getrusage (int who, struct ruage *r_usage);
```



# 导航

[目录](README.md)

上一章：[3. 文件操作](文件操作.md)

下一章：[5. 终端](终端.md)