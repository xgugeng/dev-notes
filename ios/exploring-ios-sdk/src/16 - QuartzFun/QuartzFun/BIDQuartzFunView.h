//
//  BIDQuartzFunView.h
//  QuartzFun
//
//  Created by JN on 2013-11-29.
//  Copyright (c) 2013 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BIDConstants.h"

@interface BIDQuartzFunView : UIView
@property (assign, nonatomic) CGPoint firstTouchLocation;
@property (assign, nonatomic) CGPoint lastTouchLocation;
@property (assign, nonatomic) ShapeType shapeType;
@property (assign, nonatomic) BOOL useRandomColor;
@property (strong, nonatomic) UIColor *currentColor;
@property (strong, nonatomic) UIImage *drawImage;
@property (readonly, nonatomic) CGRect currentRect;
@property (assign, nonatomic) CGRect redrawRect;
@end
