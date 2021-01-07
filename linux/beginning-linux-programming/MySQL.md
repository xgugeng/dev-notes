<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

  - [8.1.3 安装后的故障修复](#813-%E5%AE%89%E8%A3%85%E5%90%8E%E7%9A%84%E6%95%85%E9%9A%9C%E4%BF%AE%E5%A4%8D)
- [8.2 MySQL管理](#82-mysql%E7%AE%A1%E7%90%86)
  - [8.2.1 命令](#821-%E5%91%BD%E4%BB%A4)
  - [8.2.2 创建用户并赋予权限](#822-%E5%88%9B%E5%BB%BA%E7%94%A8%E6%88%B7%E5%B9%B6%E8%B5%8B%E4%BA%88%E6%9D%83%E9%99%90)
  - [8.2.3 密码](#823-%E5%AF%86%E7%A0%81)
  - [8.2.4 创建数据库](#824-%E5%88%9B%E5%BB%BA%E6%95%B0%E6%8D%AE%E5%BA%93)
  - [8.2.5 数据结构](#825-%E6%95%B0%E6%8D%AE%E7%BB%93%E6%9E%84)
  - [8.2.6 创建表](#826-%E5%88%9B%E5%BB%BA%E8%A1%A8)
- [8.3 使用C语言访问MySQL](#83-%E4%BD%BF%E7%94%A8c%E8%AF%AD%E8%A8%80%E8%AE%BF%E9%97%AEmysql)
  - [8.3.1 连接例程](#831-%E8%BF%9E%E6%8E%A5%E4%BE%8B%E7%A8%8B)
- [导航](#%E5%AF%BC%E8%88%AA)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

MySQL配置文件通常在/etc/my.cnf

有些发行版Linux放在/etc/mysql/my.cnf

```shell 
＃ 查看MySQL服务器是否启动
ps -el | grep mysqld

＃ 登陆MySQL
mysql -u root mysql

＃ 查看服务器状态
mysqladmin -u root version

# 检查服务器中的所有配置选项
mysqladmin variables
# 输出的变量中，最有用的是：datadir和have_innodb。前者告诉你MySQL在哪里存储它的数据，后者如果是YES表示MySQL支持InnoB存储引擎。MySQL支持多种引擎

# 设定root用户密码
mysqladmin -u root password newpassword
```

## 8.1.3 安装后的故障修复

1. 如果mysql连接失败，使用ps命令检查服务器是否运行
2. 如果没有运行，检查mysql_safed-log，检查日志
3. 检查数据库是否存在

 

# 8.2 MySQL管理

## 8.2.1 命令

| myisamchk   | 检查和修复使用默认MYISAM表格式的任何数据表                 |
| ----------- | ---------------------------------------- |
| mysql       | 几乎每个管理或用户级别的任务都可以通过mysql执行               |
| mysqladmin  | 快速进行MySQL管理的主要工具                         |
| mysqlbug    | 生成一个发送给MySQL维护者的错误报告，生成前需要添加一些有用的其他信息    |
| mysqldump   | 以SQL命令集的形式将部分或整个数据库导出到一个单独文件中，该文件可以被重新导入MySQL。基于mysqldump，可以实现远程备份 |
| mysqlimport | 批量将数据导入到一个表中                             |
| mysqlshow   | 快速了解MySQL安装机器组成数据库的信息                    |

 

## 8.2.2 创建用户并赋予权限

MySQL使用grant和revoke命令来管理用户权限

```shell
grant <privilege> on <object> to <user> [identified by user-password ] [ with grant option]

revoke <a_privilege> on <an_object> from<a_user>
```

## 8.2.3 密码

改变用户密码要以root用户连接到MySQL

查询用户密码：`mysql>SELECT host, user, password FROM user;`

为用户foo指定密码bar：`mysql> UPDATE userSET password = password('bar') WHERE user = 'foo'`

 

## 8.2.4 创建数据库

```
mysql> CREATEDATABASE rick;
```

## 8.2.5 数据结构

| 布尔类型 | BOOL，包括TRUE、FALSE，也可以持有NULL              |
| ---- | ---------------------------------------- |
| 字符类型 | CHAR, CHAR (N), VARCHAR (N), TINYTEXT, MEDIUMTEXT, LONGTEXT |
| 数值类型 | 整型、浮点型                                   |
| 时间类型 | DATE, TIME, TIMESTAMP, DATETIME, YEAR    |

 

## 8.2.6 创建表

使用`CREATE`和`INSERT`来创建表并插入数据

 

# 8.3 使用C语言访问MySQL

## 8.3.1 连接例程

1. 初始化一个链接句柄

```c 
#include <mysql.h>
MYSQL *mysql_init (MYSQL *);
```

1. 实际进行连接

```c 
MYSQL *mysql_real_connect (MYSQL *connection
, const char *server_host
, const char *sql_user_name
, const char *sql_password
, const char *db_name
, unsigned int port_number
, const char *unix_socket_name
, unsigned int flags);
```
 

| 错误处理    | unsigned int mysql_errno (MYSQL *connection);  char *mysql_error (MYSQL  *connection); |
| ------- | ---------------------------------------- |
| 执行SQL语句 | int mysql_query (MYSQL *connection, const  char *query) |
| 关闭连接    | int mysql_close (MYSQL *connection);     |
| 设置一些选项  | int mysql_options (MYSQL *connection, enum option_to_set, const  char *argument); |

 
```c 
// 不返回数据的SQL语句, 如UPDATE， DELETE和INSERT
my_ulonglong mysql_affected_rows (MYSQL *connection);

//  一次提取所有数据
MYSQL_RES *mysql_store_result
(MYSQL *connection);

// 得到返回的记录数目
my_ulonglong mysql_num_rows (MYSQL_RES *result);

// 从mysql_store_result的结果中提取一行
MYSQL_ROW mysql_fetch_row (MYSQL_RES *result);

// 在结果集中进行跳转，设置将会被下一个mysql_fetch_row操作返回的行
void mysql_data_seek (MYSQL_RES *result, my_ulonglong offset);

// 返回结果集中的当前位置
MYSQL_ROW_OFFSET mysql_row_tell (MYSQL_RES *result);

// 完成对数据的所有操作之后，明确调用mysql_free_result善后
void mysql_free_result (MYSQL_RES *result);

// 提取数据
// 一次提取一行
MYSQL_RES *mysql_use_resut (MYSQL *connection);

// 提供了一些关于查询结果的基本信息
unsigned int mysql_field_count
(MYSQL *connection);

// 将元数据和数据提取到MYSQL_FIELD中
MYSQL_FIELD *mysql_fetch_field (MYSQL_RES *result);
```

# 导航

[目录](README.md)

上一章：[7. 数据管理](数据管理.md)

下一章：[9. 开发工具](开发工具.md)

