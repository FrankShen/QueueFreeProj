//
//  NSMapViewController.h
//  QueueFree
//
//  Created by pursue_ct on 12-11-6.
//  Copyright (c) 2012年 BuG.BS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Annotation.h"
#import "AnnotationCreate.h"

@interface NSMapViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate,MKAnnotation>
{
    CLLocationManager *locationManager;
}
@property(weak,nonatomic) MKMapView *mapView;


@end
