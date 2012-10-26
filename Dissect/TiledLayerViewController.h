//
//  TiledLayerViewController.h
//  Dissect
//
//  Created by Justin R. Miller on 10/25/12.
//  Copyright (c) 2012 MapBox. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TiledLayerContentView;

@interface TiledLayerViewController : UIViewController <UIScrollViewDelegate>

// put these in the interface so subclasses can use them
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) TiledLayerContentView *contentView;

@end