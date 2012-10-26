//
//  OffsetsViewController.m
//  Dissect
//
//  Created by Justin R. Miller on 10/25/12.
//  Copyright (c) 2012 MapBox. All rights reserved.
//

#import "OffsetsViewController.h"

#import "TiledLayerContentView.h"

@implementation OffsetsViewController

- (id)init
{
    self = [super initWithNibName:nil bundle:nil];

    if (self)
    {
        self.title = @"Offsets";
        self.tabBarItem.image = [UIImage imageNamed:@"offsets.png"];
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // 100, 100 button
    UIButton *firstButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    firstButton.frame = CGRectMake(10, 10, 100, 50);
    [firstButton setTitle:@"10%, 10%" forState:UIControlStateNormal];
    [firstButton addTarget:self action:@selector(updateOffset:) forControlEvents:UIControlEventTouchUpInside];
    firstButton.tag = 10;
    [self.view addSubview:firstButton];

    // 500, 500 button
    UIButton *secondButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    secondButton.frame = CGRectMake(120, 10, 100, 50);
    [secondButton setTitle:@"50%, 50%" forState:UIControlStateNormal];
    [secondButton addTarget:self action:@selector(updateOffset:) forControlEvents:UIControlEventTouchUpInside];
    secondButton.tag = 50;
    [self.view addSubview:secondButton];

    // 5000, 5000 button
    UIButton *thirdButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    thirdButton.frame = CGRectMake(230, 10, 100, 50);
    [thirdButton setTitle:@"90%, 90%" forState:UIControlStateNormal];
    [thirdButton addTarget:self action:@selector(updateOffset:) forControlEvents:UIControlEventTouchUpInside];
    thirdButton.tag = 90;
    [self.view addSubview:thirdButton];
}

- (void)updateOffset:(UIButton *)button
{
    CGFloat percentage = (CGFloat)button.tag / 100;

    CGPoint offset = CGPointMake(self.contentView.bounds.size.width * percentage, self.contentView.bounds.size.height * percentage);

    [self.scrollView setContentOffset:offset animated:YES];
}

@end