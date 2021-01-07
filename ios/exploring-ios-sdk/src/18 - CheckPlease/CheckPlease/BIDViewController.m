//
//  BIDViewController.m
//  CheckPlease
//
//  Created by JN on 2013-12-20.
//  Copyright (c) 2013 apress. All rights reserved.
//

#import "BIDViewController.h"
#import "BIDCheckMarkRecognizer.h"

@interface BIDViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation BIDViewController

- (void)doCheck:(BIDCheckMarkRecognizer *)check
{
    self.label.text = @"Checkmark";
    [self performSelector:@selector(eraseLabel)
               withObject:nil afterDelay:1.6];
}

- (void)eraseLabel
{
    self.label.text = @"";
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    BIDCheckMarkRecognizer *check = [[BIDCheckMarkRecognizer alloc]
                                     initWithTarget:self
                                     action:@selector(doCheck:)];
    [self.view addGestureRecognizer:check];
}

@end
