//
//  UIColor+BIDRandom.m
//  QuartzFun
//
//  Created by JN on 2013-11-29.
//  Copyright (c) 2013 Apress. All rights reserved.
//

#import "UIColor+BIDRandom.h"

#define ARC4RANDOM_MAX 0x100000000LL

@implementation UIColor (BIDRandom)
+ (UIColor *)randomColor {
    CGFloat red = (CGFloat)arc4random() / (CGFloat)ARC4RANDOM_MAX;
    CGFloat blue = (CGFloat)arc4random() / (CGFloat)ARC4RANDOM_MAX;
    CGFloat green = (CGFloat)arc4random() / (CGFloat)ARC4RANDOM_MAX;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}
@end
