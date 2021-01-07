//
//  BIDConstants.h
//  QuartzFun
//
//  Created by JN on 2013-11-29.
//  Copyright (c) 2013 Apress. All rights reserved.
//

#ifndef QuartzFun_BIDConstants_h
#define QuartzFun_BIDConstants_h

typedef NS_ENUM(NSInteger, ShapeType) {
    kLineShape = 0,
    kRectShape,
    kEllipseShape,
    kImageShape
};

typedef NS_ENUM(NSInteger, ColorTabIndex) {
    kRedColorTab = 0,
    kBlueColorTab,
    kYellowColorTab,
    kGreenColorTab,
    kRandomColorTab
};

#define degreesToRadian(x) (M_PI * (x) / 180.0)

#endif
