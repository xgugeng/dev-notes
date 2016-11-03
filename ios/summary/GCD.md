GCD（Grand Central Dispatch）是苹果开发的一个多核编程的解决方法，和其他的多线程技术方案（如NSThread，NSOperationQueue，NSInvocationOperation）相比，使用起来更加简单方便。

GCD的定义像函数指针，差别是用"^"取代了"*"：

```objective-c
// 声明变量
(void) (^loggerBlock)(void);

// 定义
loggerBlock = ^{
  NSLog("Hello");
};

// 调用
loggerBlock();

// 多数情况下，我们使用内联的方式定义它
dispatch_async(dispatch_get_glboal_queue(0,0), ^{
  // do something
});
```

## 系统提供的dispatch方法

dispatch方法方便我们将block放在主线程或后台线程进行，或者延后执行：

```objective-c
// 后台执行
dispatch_async(dispatch_get_glboal_queue(0,0), ^{
  // do something
});
// 主线程执行
dispatch_async(dispatch_get_main_queue, ^{
  // do something
});
// 一次性执行
static dispatch_once_t onceToken;
dispatch_once(&onceToken, ^{
  // do someghing
});
// 延迟2秒执行
double delayInSeconds = 2.0;
dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
  // do something
});
```

dispatch_queue_t可以自己定义，使用dispatch_queue_create方法。

另外，GCD的高级用法还包括，让后台两个线程并行执行，然后等它们结束，汇总结果。

```objective-c
dispatch_group_t group = dispatch_group_create();
dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
  // 并行执行的线程一
});
dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
  // 并行执行的线程二
});
dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
  // 汇总结果
});
```

