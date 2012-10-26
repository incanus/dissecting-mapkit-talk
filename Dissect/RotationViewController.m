//
//  RotationViewController.m
//  Dissect
//
//  Created by Justin R. Miller on 10/25/12.
//  Copyright (c) 2012 MapBox. All rights reserved.
//

#import "RotationViewController.h"

#import "TiledLayerContentView.h"

#import <QuartzCore/QuartzCore.h>

@interface RotationViewController ()

@property (nonatomic, strong) UISwitch *pointSwitch;

@end

@implementation RotationViewController

- (id)init
{
    self = [super initWithNibName:nil bundle:nil];

    if (self)
    {
        self.title = @"Rotation";
        self.tabBarItem.image = [UIImage imageNamed:@"rotation.png"];
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // disable zooming for simplicity's sake
    self.scrollView.maximumZoomScale = 1;

    // don't clip stuff that overflows the scroll view
    self.scrollView.clipsToBounds = NO;

    // add a bunch of pins
    for (int x = 100; x < 1000; x = x + 200)
    {
        for (int y = 100; y < 1000; y = y + 200)
        {
            UIImage *pinImage = [UIImage imageNamed:@"jack.png"];

            CALayer *pinLayer = [CALayer layer];

            pinLayer.contents = (id)[pinImage CGImage];
            
            pinLayer.bounds = CGRectMake(0, 0, pinImage.size.width, pinImage.size.height);

            pinLayer.position = CGPointMake(x, y);

            [self.contentView.layer addSublayer:pinLayer];
        }
    }

    // add a rotation slider
    UISlider *rotationSlider = [[UISlider alloc] initWithFrame:CGRectMake(20, 0, 400, 50)];

    rotationSlider.minimumValue = 0;
    rotationSlider.maximumValue = 360;

    [rotationSlider addTarget:self action:@selector(rotationChanged:) forControlEvents:UIControlEventValueChanged];

    [self.view addSubview:rotationSlider];

    // add a switch for point counter-rotation
    self.pointSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(430, 10, 50, 20)];

    [self.view addSubview:self.pointSwitch];
}

- (void)rotationChanged:(UISlider *)slider
{
    // compute angle in radians
    CGFloat angle = slider.value * (M_PI / 180);

    // group the UIView & CALayer animations together
    [CATransaction begin];
    [CATransaction setAnimationDuration:0];

    [UIView animateWithDuration:0
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^(void)
                     {
                         // rotate the scroll view by the angle
                         self.scrollView.transform = CGAffineTransformMakeRotation(angle);

                         if (self.pointSwitch.on)
                         {
                             // rotate each sublayer by the negative angle to offset
                             for (CALayer *layer in self.contentView.layer.sublayers)
                             {
                                 layer.transform = CATransform3DMakeAffineTransform(CGAffineTransformMakeRotation(-angle));
                             }
                         }
                     }
                     completion:nil];

    [CATransaction commit];
}

@end