# NSDictionary -> NSData

```objective-c
// 方法1：NSKeyedArchiver
NSDictionary *dict = @{
                       @"key1": @"value1",
                       @"key1": @"value2"
                       };
NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dict];

// 方法2：NSJSONSerialization
NSError *writeError = nil;
NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:&writeError];
if (writeError != nil) {
    NSLog(@"Convent to JSON failed: %@", [writeError localizedDescription]);
    return;
}
```

# NSData -> NSDictionary

```objective-c
// 方法1：NSKeyedUnarchiver
NSDictionary *myDictionary = (NSDictionary*) [NSKeyedUnarchiver unarchiveObjectWithData:myData];

// 方法2：NSJSONSerialization
NSDictionary *dictFromData = [NSJSONSerialization JSONObjectWithData:dataFromDict
                                                           options:NSJSONReadingAllowFragments
                                                               error:&error];
```

# NSArray -> NSData

```objective-c
// 方法1：NSKeyedArchiver
NSArray *array = [NSArray arrayWithObjects:@"1",@"2",@"3",nil];  
NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arr];

// 方法2：NSJSONSerialization
NSError *writeError = nil;
NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:&writeError];
if (writeError != nil) {
    NSLog(@"Convent to JSON failed: %@", [writeError localizedDescription]);
    return;
}
```

# NSData -> NSArray

```objective-c
// 方法1：NSKeyedUnarchiver
NSArray *data2arry = [NSKeyedUnarchiver unarchiveObjectWithData:data]; 

// 方法2：NSJSONSerialization
NSArray *arrayFromData = [NSJSONSerialization JSONObjectWithData:dataFromArray
                                                           options:NSJSONReadingAllowFragments
                                                               error:&error];
```

无论使用NSKeyedUnarchiver还是NSJSONSerialization，其实它接受的参数类型都是id，所以我们也可以将继承自NSObject的自定义类转换为NSData，但该对象必须遵循NSCoding协议，即实现：

```objective-c
- (instancetype)initWithCoder:(NSCoder *)aDecoder;
- (void)encodeWithCoder:(NSCoder *)aCoder;
```

例如:

```objective-c
@interface Book : NSObject <NSCoding>
@property NSString *title;
@property NSString *author;
@property NSUInteger pageCount;
@property NSSet *categories;
@property (getter = isAvailable) BOOL available;
@end

@implementation Book

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) {
        return nil;
    }

    self.title = [decoder decodeObjectForKey:@"title"];
    self.author = [decoder decodeObjectForKey:@"author"];
    self.pageCount = [decoder decodeIntegerForKey:@"pageCount"];
    self.categories = [decoder decodeObjectForKey:@"categories"];
    self.available = [decoder decodeBoolForKey:@"available"];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.title forKey:@"title"];
    [encoder encodeObject:self.author forKey:@"author"];
    [encoder encodeInteger:self.pageCount forKey:@"pageCount"];
    [encoder encodeObject:self.categories forKey:@"categories"];
    [encoder encodeBool:[self isAvailable] forKey:@"available"];
}

@end
```

