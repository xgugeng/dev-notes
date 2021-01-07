//
//  BIDDisclosureDetailViewController.m
//  Nav
//
//  Created by JN on 10/11/13.
//  Copyright (c) 2013 Apress. All rights reserved.
//

#import "BIDDisclosureDetailViewController.h"

@interface BIDDisclosureDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation BIDDisclosureDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.label.text = [NSString stringWithFormat:
                       @"This is the detail view for %@.",
                       self.item];
    self.title = self.item;
}

@end
