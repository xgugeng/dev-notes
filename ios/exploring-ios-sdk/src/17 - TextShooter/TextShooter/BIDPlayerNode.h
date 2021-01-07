//
//  BIDPlayerNode.h
//  TextShooter
//
//  Created by JN on 2013-12-11.
//  Copyright (c) 2013 Apress. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface BIDPlayerNode : SKNode

// returns duration of future movement
- (CGFloat)moveToward:(CGPoint)location;

@end
