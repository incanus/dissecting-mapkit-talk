//
//  AnnotationsViewController.m
//  Dissect
//
//  Created by Justin R. Miller on 10/25/12.
//  Copyright (c) 2012 MapBox. All rights reserved.
//

#import "AnnotationsViewController.h"

#import <MapBox/MapBox.h>

@implementation AnnotationsViewController

- (id)init
{
    self = [super initWithNibName:nil bundle:nil];

    if (self)
    {
        self.title = @"Annotations";
        self.tabBarItem.image = [UIImage imageNamed:@"annotations.png"];
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // pick retina or non-retina map tiles
    NSURL *tileURL;

    if ([[UIScreen mainScreen] scale] > 1.0)
        tileURL = [NSURL URLWithString:@"http://a.tiles.mapbox.com/v3/justin.map-nq0f1vuc.jsonp"];
    else
        tileURL = [NSURL URLWithString:@"http://a.tiles.mapbox.com/v3/justin.map-ngrqqx0w.jsonp"];

    // make map view
    RMMapView *mapView = [[RMMapView alloc] initWithFrame:self.view.bounds andTilesource:[[RMMapBoxSource alloc] initWithReferenceURL:tileURL]];

    // make sure it resizes to landscape
    mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    // make a huge on-disk tile cache
    mapView.tileCache = [[RMTileCache alloc] initWithExpiryPeriod:60 * 60 * 24 * 7 * 365]; // one year expiration

    // add it to our view
    [self.view addSubview:mapView];

    // set initial zoom & center
    mapView.zoom = 13;
    mapView.centerCoordinate = CLLocationCoordinate2DMake(45.579806, -122.572145);

    // add hotel annotation
    RMAnnotation *hotel = [[RMAnnotation alloc] initWithMapView:mapView coordinate:mapView.centerCoordinate andTitle:@"Embassy Suites"];
    hotel.layer = [[RMMarker alloc] initWithMapBoxMarkerImage:@"lodging" tintColor:[UIColor redColor]];
    [mapView addAnnotation:hotel];

    // add shape annotation
    CLLocationCoordinate2D shapeStart = CLLocationCoordinate2DMake(mapView.centerCoordinate.latitude - 0.01, mapView.centerCoordinate.longitude - 0.01);
    RMAnnotation *shape = [[RMAnnotation alloc] initWithMapView:mapView coordinate:shapeStart andTitle:@"Random Shape"];
    RMShape *shapeLayer = [[RMShape alloc] initWithView:mapView];
    shapeLayer.lineColor = [UIColor yellowColor];
    shapeLayer.fillColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.5];
    shapeLayer.lineWidth = 5;
    [shapeLayer moveToCoordinate:shapeStart];
    [shapeLayer addLineToCoordinate:CLLocationCoordinate2DMake(shape.coordinate.latitude + 0.01, shape.coordinate.longitude - 0.01)];
    [shapeLayer addLineToCoordinate:CLLocationCoordinate2DMake(shape.coordinate.latitude + 0.005, shape.coordinate.longitude + 0.01)];
    [shapeLayer addLineToCoordinate:shapeStart];
    shape.layer = shapeLayer;
    [mapView addAnnotation:shape];
}

@end