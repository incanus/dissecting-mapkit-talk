//
//  TiledLayerViewController.m
//  Dissect
//
//  Created by Justin R. Miller on 10/25/12.
//  Copyright (c) 2012 MapBox. All rights reserved.
//

#import "TiledLayerViewController.h"

#import "TiledLayerContentView.h"

#import <QuartzCore/QuartzCore.h>

@implementation TiledLayerViewController

- (id)init
{
    self = [super initWithNibName:nil bundle:nil];

    if (self)
    {
        self.title = @"Tiling";
        self.tabBarItem.image = [UIImage imageNamed:@"tiling.png"];
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // create a scroll view the same size as the main view
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];

    // make sure it resizes with the main view
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    // turn off scroll bars
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator   = NO;

    // make a larger content rect
    CGRect contentRect = CGRectMake(0, 0, self.view.bounds.size.width * 10, self.view.bounds.size.height * 10);

    // create a content view of that size
    self.contentView = [[TiledLayerContentView alloc] initWithFrame:contentRect];

    // put the content view in the scroll view
    [self.scrollView addSubview:self.contentView];

    // let the scroll view know its content size
    self.scrollView.contentSize = self.contentView.bounds.size;

    // put the scroll view inside the main view
    [self.view addSubview:self.scrollView];

    // allow the scroll view to zoom
    self.scrollView.minimumZoomScale = 1;
    self.scrollView.maximumZoomScale = 6;

    // but not bounce
    self.scrollView.bouncesZoom = NO;

    // set the scroll view delegate
    self.scrollView.delegate = self;

    // add double-tap to zoom in
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
    doubleTap.numberOfTapsRequired = 2;
    [self.scrollView addGestureRecognizer:doubleTap];

    // two-finger tap to zoom out
    UITapGestureRecognizer *twoFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(twoFingerTap:)];
    twoFingerTap.numberOfTouchesRequired = 2;
    [self.scrollView addGestureRecognizer:twoFingerTap];
}

// scroll view delegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    // just return the one and only subview
    return [scrollView.subviews objectAtIndex:0];
}

// tap gestures
- (void)doubleTap:(UIGestureRecognizer *)recognizer
{
    // zoom in (on the center, which is simpler)
    [self.scrollView setZoomScale:(self.scrollView.zoomScale + 1) animated:YES];
}

- (void)twoFingerTap:(UIGestureRecognizer *)recognizer
{
    // zoom out (on the center, which is simpler)
    [self.scrollView setZoomScale:(self.scrollView.zoomScale - 1) animated:YES];
}

@end