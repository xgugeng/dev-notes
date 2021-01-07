//
//  BIDHeaderCell.m
//  DialogViewer
//
//  Created by JN on 10/18/13.
//  Copyright (c) 2013 Apress. All rights reserved.
//

#import "BIDHeaderCell.h"

@implementation BIDHeaderCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.label.backgroundColor = [UIColor colorWithRed:0.9
                                                     green:0.9
                                                      blue:0.8
                                                     alpha:1.0];
        self.label.textColor = [UIColor blackColor];
    }
    return self;
}

+ (UIFont *)defaultFont {
    return [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
}

@end
