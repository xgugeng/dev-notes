//
//  BIDDetailViewController.m
//  TinyPix
//
//  Created by JN on 09/11/13.
//  Copyright (c) 2013 Apress. All rights reserved.
//

#import "BIDDetailViewController.h"
#import "BIDTinyPixView.h"

@interface BIDDetailViewController ()
@property (weak, nonatomic) IBOutlet BIDTinyPixView *pixView;
- (void)configureView;
@end

@implementation BIDDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.pixView.document = self.detailItem;
        [self.pixView setNeedsDisplay];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    UIDocument *doc = self.detailItem;
    [doc closeWithCompletionHandler:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
