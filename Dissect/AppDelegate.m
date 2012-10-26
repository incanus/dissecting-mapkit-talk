//
//  AppDelegate.m
//  Dissect
//
//  Created by Justin R. Miller on 10/25/12.
//  Copyright (c) 2012 MapBox. All rights reserved.
//

#import "AppDelegate.h"

#import "DSFingerTipWindow.h"

#import "MapViewController.h"
#import "TiledLayerViewController.h"
#import "OffsetsViewController.h"
#import "AnnotationsViewController.h"
#import "RotationViewController.h"
#import "ThreeDeeViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Fingertips is for demo purposes - shows device touches when mirroring display
    self.window = [[DSFingerTipWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = @[[[MapViewController alloc] init],
                                             [[TiledLayerViewController alloc] init],
                                             [[OffsetsViewController alloc] init],
                                             [[AnnotationsViewController alloc] init],
                                             [[RotationViewController alloc] init],
                                             [[ThreeDeeViewController alloc] init]];

    self.window.rootViewController = self.tabBarController;

    [self.window makeKeyAndVisible];

    return YES;
}

@end