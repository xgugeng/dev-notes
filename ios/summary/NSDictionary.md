`NSDictionary`是Objective-C中的字典，用于保存键值对。详细的用法可以参加[官方文档](https://developer.apple.com/reference/foundation/nsdictionary)，本文仅记录本人在使用过程中的碰到一些坑。

`NSDictionary`存储的是不可变对象，一经初始化就不能修改键值对，只能求助于`NSMutableDictionary`。

# 键值的限制

键值对中的key必须是一个string，value可以是任意的object，但

- value必须遵循NSCoping协议。

  > 所以，int、bool这些基本数据类型就不能作为value了。
  >
  > 可以借助 `[NSNumber numberWithBool:YES]`来创建新的value对象。

- key和value都不能为nil。如果想表达一个nil value，请用NSNull。

# 初始化

`NSDictionary`的初始化函数包括：

```objective-c
- (instancetype)initWithObjects:(NSArray<ObjectType> *)objects 
                        forKeys:(NSArray<id<NSCopying>> *)keys;
- (instancetype)initWithObjectsAndKeys:(id)firstObject, ...;

// 例1
NSDictionary *dict1 = [[NSDictionary alloc] initWithObjectsAndKeys:
    				  @"value1", @"key1", 
                      @"value2", @"key2", 
                      nil]; // 结尾必需使用nil标志结束

// 例2
id objects[] = { someObject, @"Hello, World!", @42, someValue };
id keys[] = { @"anObject", @"helloString", @"magicNumber", @"aValue" };
NSUInteger count = sizeof(objects) / sizeof(id);
NSDictionary *dict2 = [NSDictionary dictionaryWithObjects:objects
                                                       forKeys:keys
                                                         count:count];

// 语法糖
// ATTENTION: 
// 1. 仅此方法获得的字典是有序的
// 2. 最后一个键值对后没有逗号
NSDictionary *dict3 = @{
       @"anObject" : someObject,
    @"helloString" : @"Hello, World!",
    @"magicNumber" : @42,
         @"aValue" : someValue 
};
```

# 获取键值对

方法一：

```objective-c
// 对于不存在key返回nil
- (ObjectType)objectForKey:(KeyType)aKey;
```

方法二：

```objective-c
id value = dictionary[@"helloString"];
```

# 遍历

方法一：

```objective-c
- (void)enumerateKeysAndObjectsUsingBlock:(void (^)(KeyType key, ObjectType obj, BOOL *stop))block;

 [dict4 enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {

      NSLog(@"%@ --> %@",key,obj);

 }];
```

方法二：

```objective-c
for (NSString *key in dictionary) {
    id value = dictionary[key];
    NSLog(@"Value: %@ for key: %@", value, key);
}
```

