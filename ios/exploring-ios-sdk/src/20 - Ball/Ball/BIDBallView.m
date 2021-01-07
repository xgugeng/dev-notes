//
//  BIDBallView.m
//  Ball
//
//  Created by JN on 2014-1-16.
//  Copyright (c) 2014 Apress. All rights reserved.
//

#import "BIDBallView.h"

@interface BIDBallView ()

@property (strong, nonatomic) UIImage *image;
@property (assign, nonatomic) CGPoint currentPoint;
@property (assign, nonatomic) CGPoint previousPoint;
@property (assign, nonatomic) CGFloat ballXVelocity;
@property (assign, nonatomic) CGFloat ballYVelocity;

@end

@implementation BIDBallView

- (void)commonInit
{
    self.image = [UIImage imageNamed:@"ball.png"];
    self.currentPoint = CGPointMake((self.bounds.size.width / 2.0f) +
                                    (self.image.size.width / 2.0f),
                                    (self.bounds.size.height / 2.0f) +
                                    (self.image.size.height / 2.0f));
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self commonInit];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [self.image drawAtPoint:self.currentPoint];
}

#pragma mark -

- (void)setCurrentPoint:(CGPoint)newPoint
{
    self.previousPoint = self.currentPoint;
    _currentPoint = newPoint;
    
    if (self.currentPoint.x < 0) {
        _currentPoint.x = 0;
        self.ballXVelocity = 0;
    }
    if (self.currentPoint.y < 0){
        _currentPoint.y = 0;
        self.ballYVelocity = 0;
    }
    if (self.currentPoint.x > self.bounds.size.width - self.image.size.width) {
        _currentPoint.x = self.bounds.size.width - self.image.size.width;
        self.ballXVelocity = 0;
    }
    if (self.currentPoint.y >
        self.bounds.size.height - self.image.size.height) {
        _currentPoint.y = self.bounds.size.height - self.image.size.height;
        self.ballYVelocity = 0;
    }
    
    CGRect currentRect =
    CGRectMake(self.currentPoint.x, self.currentPoint.y,
               self.currentPoint.x + self.image.size.width,
               self.currentPoint.y + self.image.size.height);
    CGRect previousRect =
    CGRectMake(self.previousPoint.x, self.previousPoint.y,
               self.previousPoint.x + self.image.size.width,
               self.currentPoint.y + self.image.size.width);
    [self setNeedsDisplayInRect:CGRectUnion(currentRect, previousRect)];
}

- (void)update
{
    static NSDate *lastUpdateTime = nil;
    
    if (lastUpdateTime != nil) {
        NSTimeInterval secondsSinceLastDraw =
        [[NSDate date] timeIntervalSinceDate:lastUpdateTime];
        
        self.ballYVelocity = self.ballYVelocity -
        (self.acceleration.y * secondsSinceLastDraw);
        self.ballXVelocity = self.ballXVelocity +
        (self.acceleration.x * secondsSinceLastDraw);
        
        CGFloat xAccel = secondsSinceLastDraw * self.ballXVelocity * 500;
        CGFloat yAccel = secondsSinceLastDraw * self.ballYVelocity * 500;
        
        self.currentPoint = CGPointMake(self.currentPoint.x + xAccel,
                                        self.currentPoint.y + yAccel);
    }
    // Update last time with current time
    lastUpdateTime = [[NSDate alloc] init];
}

@end
