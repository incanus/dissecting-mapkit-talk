//
//  ThreeDeeViewController.m
//  Dissect
//
//  Created by Justin R. Miller on 10/25/12.
//  Copyright (c) 2012 MapBox. All rights reserved.
//

#import "ThreeDeeViewController.h"

#import <QuartzCore/QuartzCore.h>

@interface ThreeDeeViewController ()

@property (nonatomic, assign) CGFloat tiltAngle;
@property (nonatomic, assign) CGFloat oldRotateAngle;
@property (nonatomic, assign) CGFloat newRotateAngle;

@end

@implementation ThreeDeeViewController

- (id)init
{
    self = [super initWithNibName:nil bundle:nil];

    if (self)
    {
        self.title = @"3D";
        self.tabBarItem.image = [UIImage imageNamed:@"3d.png"];
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // don't clip stuff that overflows the scroll view
    self.scrollView.clipsToBounds = NO;

    // add rotation gesture
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotate:)];
    [self.scrollView addGestureRecognizer:rotation];

    // add tilt gesture
    UIPanGestureRecognizer *tilt = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(tilt:)];
    tilt.minimumNumberOfTouches = 2;
    tilt.maximumNumberOfTouches = 2;
    [self.scrollView addGestureRecognizer:tilt];
}

// rotate gesture
- (void)rotate:(UIRotationGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan)
        self.oldRotateAngle = self.newRotateAngle;

    // build on existing rotation
    self.newRotateAngle = self.oldRotateAngle + recognizer.rotation;

    [self update3D];
}

// tilt gesture
- (void)tilt:(UIPanGestureRecognizer *)recognizer
{
    CGFloat angle = [recognizer translationInView:recognizer.view.superview].y / -3;

    // cap at 65 degree tilt
    CGFloat cap = 65;

    if (angle >= cap)
        angle = cap;

    if (angle <= 0)
        angle = 0;

    self.tiltAngle = angle;

    [self update3D];
}

- (void)update3D
{
    self.scrollView.layer.zPosition = 1000;

    // start with the identity
    CATransform3D transform = CATransform3DIdentity;

    // rotate it around z-axis
    transform = CATransform3DRotate(transform, self.newRotateAngle, 0, 0, 1);

    // rotate THAT around x-axis
    transform = CATransform3DConcat(transform, CATransform3DMakeRotation(self.tiltAngle * M_PI / 180, 1, 0, 0));

    // apply the transform
    self.scrollView.layer.transform = transform;
}

@end