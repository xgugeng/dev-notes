//
//  BIDStartScene.m
//  TextShooter
//
//  Created by JN on 2014-1-23.
//  Copyright (c) 2014 Apress. All rights reserved.
//

#import "BIDStartScene.h"
#import "BIDLevelScene.h"

@implementation BIDStartScene

- (instancetype)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        self.backgroundColor = [SKColor greenColor];
        
        SKLabelNode *topLabel = [SKLabelNode labelNodeWithFontNamed:@"Courier"];
        topLabel.text = @"TextShooter";
        topLabel.fontColor = [SKColor blackColor];
        topLabel.fontSize = 48;
        topLabel.position = CGPointMake(self.frame.size.width * 0.5,
                                        self.frame.size.height * 0.7);
        [self addChild:topLabel];
        
        SKLabelNode *bottomLabel = [SKLabelNode labelNodeWithFontNamed:@"Courier"];
        bottomLabel.text = @"Touch anywhere to start";
        bottomLabel.fontColor = [SKColor blackColor];
        bottomLabel.fontSize = 20;
        bottomLabel.position = CGPointMake(self.frame.size.width * 0.5,
                                           self.frame.size.height * 0.3);
        [self addChild:bottomLabel];
        
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    SKTransition *transition = [SKTransition doorwayWithDuration:1.0];
    SKScene *game = [[BIDLevelScene alloc] initWithSize:self.frame.size];
    [self.view presentScene:game transition:transition];
    
    [self runAction:[SKAction playSoundFileNamed:@"gameStart.wav"
                               waitForCompletion:NO]];
}

@end
