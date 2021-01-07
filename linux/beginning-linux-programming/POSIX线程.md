<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [12.1 什么是线程](#121-%E4%BB%80%E4%B9%88%E6%98%AF%E7%BA%BF%E7%A8%8B)
- [12.2 线程的优点和缺点](#122-%E7%BA%BF%E7%A8%8B%E7%9A%84%E4%BC%98%E7%82%B9%E5%92%8C%E7%BC%BA%E7%82%B9)
- [12.3 第一个线程程序](#123-%E7%AC%AC%E4%B8%80%E4%B8%AA%E7%BA%BF%E7%A8%8B%E7%A8%8B%E5%BA%8F)
- [12.5 同步](#125-%E5%90%8C%E6%AD%A5)
  - [信号量](#%E4%BF%A1%E5%8F%B7%E9%87%8F)
  - [互斥量](#%E4%BA%92%E6%96%A5%E9%87%8F)
- [12.6 线程的属性](#126-%E7%BA%BF%E7%A8%8B%E7%9A%84%E5%B1%9E%E6%80%A7)
- [导航](#%E5%AF%BC%E8%88%AA)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# 12.1 什么是线程 
线程是进程内部的一个控制序列。所有的进程至少有一个执行线程。

当进程fork时，将创建出该进程的一个新副本。这个进程拥有自己的变量和PID，时间调度也是独立的，它的执行几乎完全独立于父进程。

当进程创建一个新线程时，线程拥有自己的栈，但与它的创建者共享全局变量、文件描述符、信号处理函数和当前目录状态。

# 12.2 线程的优点和缺点

优点

1. 创建线程代价小
2. 线程切换比进程切换代价少得多

缺点

1. 编程难，时序的细微差别会造成很大影响
2. 调试难，因为线程交互难以控制
3. 在单处理器上不一定快

# 12.3 第一个线程程序
线程有一套完整的函数库调用，绝大多数以`pthread_`开头。为了使用这些函数，我们必须定义宏`_REENTRANT`，在头文件中包含`pthread.h`，并且在编译程序时使用`-lpthread`来链接线程库

定义宏`_REENTRANT`，是告诉编译器我们需要可重入功能。它为我们做了三件事：

1. 会对部分函数重新定义它们的可安全重入版本，函数名一般不变，会在加上后缀`_r`
2. `stdio.h`中原来以宏的形式实现的一些函数将变成可安全重入的函数
3. `errno.h`中`errno`变量将变成一个函数调用，能够以线程安全的方式来访问真正的`errno`值

```c 
//  创建新线程
int pthread_create (pthread_t *thread
  , pthread_attr_t *attr
  , void *(*start_routine)(void *)
  , void *arg) ;
// 退出线程
void pthread_exit (void *retval) ;
// 等待线程
int pthread_join (pthread_t th, void **thread_return) ;
```

# 12.5 同步

## 信号量

信号量是一个特殊类型的变量，可以被增加或减少，但是对其访问是原子操作。

信号量函数的名字都以sem_开头，主要有：
```c 
#include <semaphore.h>
int sem_init (sem_t *sem, int pshared, unsigned int value) ; // 创建信号量
int sem_wait (sem_t *sem) ; // 信号量加1
int sem_post (sem_t *sem) ; // 信号量减1，但是会等到信号量非0时才做减法
int sem_destroy (sem_t *sem) ; // 用完信号量后清理
```

## 互斥量

互斥量允许锁住某个对象，使得每次只能有一个线程访问它。为了控制关键代码的访问，必须在进入这段代码前锁住一个互斥量，然后完成操作后解锁。
```c 
#include <pthread.h>
int pthread_mutex_init (pthread_mutex_t *mutex, const pthread_muteattr_t *mutexattr) ;
int pthread_mutex_lock (pthead_mutex_t *mutex) ;
int pthread_mutex_unlock (pthread_mutex_t *mutex) ;
int pthread_mutex_destroy (pthread_mutex_t *mutex );
```

# 12.6 线程的属性
```c 
#include <pthread.h>
int pthread_attr_init (pthread_attr_t *attr) ; // 初始化一个线程属性对象
// 修改线程属性的函数，如
int pthread_attr_setdetachstate (pthread_attr_t *attr, int detachstate ); // 脱离父线程
int pthread_attr_setschedpolicy (pthread_attr_t *attr, int policy) ; //  调度属性
12.7 取消一个线程
一个线程可以要求另一个线程终止。
int pthread_cancel (pthread_t thread) ; 
// 接收端线程可以用pthread_setcacelstate设置自己的取消状态，决定是否接受取消
int pthread_setcancelstate (int state, int *oldstate) ;
// 设置取消类型，接受取消后，立即执行或者推迟执行
int pthread_setcanceltype (int type, int *oldtype) ;
```

# 导航

[目录](README.md)

上一章：[11. 进程和信号](进程和信号.md)

下一章：[13. 进程间通信：管道](进程间通信：管道.md)
