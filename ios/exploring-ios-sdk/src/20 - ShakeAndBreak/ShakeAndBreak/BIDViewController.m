//
//  BIDViewController.m
//  ShakeAndBreak
//
//  Created by JN on 2014-1-15.
//  Copyright (c) 2014 Apress. All rights reserved.
//

#import "BIDViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface BIDViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) UIImage *fixed;
@property (strong, nonatomic) UIImage *broken;
@property (assign, nonatomic) BOOL brokenScreenShowing;
@property (strong, nonatomic) AVAudioPlayer *crashPlayer;
@end

@implementation BIDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"glass"
                                         withExtension:@"wav"];
    
    NSError *error = nil;
    self.crashPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url
                                                              error:&error];
    if (!self.crashPlayer) {
        NSLog(@"Audio Error! %@", error.localizedDescription);
    }
    
    self.fixed = [UIImage imageNamed:@"home.png"];
    self.broken = [UIImage imageNamed:@"homebroken.png"];
    
    self.imageView.image = self.fixed;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.imageView.image = self.fixed;
    self.brokenScreenShowing = NO;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event;
{
    if (!self.brokenScreenShowing && motion == UIEventSubtypeMotionShake) {
        self.imageView.image = self.broken;
        [self.crashPlayer play];
        self.brokenScreenShowing = YES;
    }
}

@end
