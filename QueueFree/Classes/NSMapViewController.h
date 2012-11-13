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
@protocol NSMapViewDelegate <NSObject>

//- (void)performTheSegue: (id)sender;
- (UIButton *) createTheButtonWithPinTitle:(NSString *)title;

@end

@interface NSMapViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate,MKAnnotation>
{
    CLLocationManager *locationManager;
    int pinIDCount;
}

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (weak,nonatomic) id<NSMapViewDelegate> delegate;
- (void)ShowRegionOfTheUserLocationPressed;

@end
