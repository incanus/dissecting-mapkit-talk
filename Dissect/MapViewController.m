//
//  MapViewController.m
//  Dissect
//
//  Created by Justin R. Miller on 10/25/12.
//  Copyright (c) 2012 MapBox. All rights reserved.
//

#import "MapViewController.h"

#import <MapKit/MapKit.h>

@implementation MapViewController

- (id)init
{
    self = [super initWithNibName:nil bundle:nil];

    if (self)
    {
        self.title = @"Map";
        self.tabBarItem.image = [UIImage imageNamed:@"map.png"];
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // create a default map view
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];

    // make sure it resizes to landscape
    mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    // add it to our view
    [self.view addSubview:mapView];
}

@end