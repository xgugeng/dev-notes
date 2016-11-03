//
//  SKNode+Extra.h
//  TextShooter
//
//  Created by JN on 2014-1-22.
//  Copyright (c) 2014 Apress. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SKNode (Extra)

- (void)receiveAttacker:(SKNode *)attacker contact:(SKPhysicsContact *)contact;
- (void)friendlyBumpFrom:(SKNode *)node;

@end
