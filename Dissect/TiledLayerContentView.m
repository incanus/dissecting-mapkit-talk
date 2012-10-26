//
//  TiledLayerContentView.m
//  Dissect
//
//  Created by Justin R. Miller on 10/25/12.
//  Copyright (c) 2012 MapBox. All rights reserved.
//

#import "TiledLayerContentView.h"

#import <QuartzCore/QuartzCore.h>

@implementation TiledLayerContentView

// override to enable tiling
+ (Class)layerClass
{
    return [CATiledLayer class];
}

// setup tile reloading
- (void)didMoveToSuperview
{
    ((CATiledLayer *)self.layer).levelsOfDetail     = 6; // how many zoom levels will I have total?
    ((CATiledLayer *)self.layer).levelsOfDetailBias = 5; // how many zoom levels will I magnify?
}

// delegate method to draw contents
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)context
{
    // figure out what tile we are, essentially (e.g., x:512 y:0 h:256 w:256)
    CGRect rect = CGContextGetClipBoundingBox(context);

    // figure out our scroll view's zoom scale - note this is quick & dirty
    CGFloat zoomScale = ([self.superview isKindOfClass:[UIScrollView class]] ? ((UIScrollView *)self.superview).zoomScale : 0);

    // draw the appropriate tile image based on the zoom scale
    CGContextDrawImage(context, rect, [[UIImage imageNamed:[NSString stringWithFormat:@"tile_%i.png", (int)ceilf(zoomScale)]] CGImage]);
}

@end