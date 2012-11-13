//
//  GSMapViewController.h
//  QueueFree
//
//  Created by pursue_ct on 12-11-12.
//  Copyright (c) 2012年 BuG.BS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Annotation.h"
#import "AnnotationCreate.h"
#import "GSTableViewController.h"

@interface GSMapViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate,MKAnnotation>
{
    CLLocationManager *locationManager;
}

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong , nonatomic) NSArray *resultArrayForMap;

@end

