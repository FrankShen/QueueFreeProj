//
//  NSMapViewController.m
//  QueueFree
//
//  Created by pursue_ct on 12-11-6.
//  Copyright (c) 2012年 BuG.BS. All rights reserved.
//

#import "NSMapViewController.h"

@interface NSMapViewController ()

@end

@implementation NSMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _mapView = [[[NSBundle mainBundle] loadNibNamed:@"NSMapView" owner:self options:nil] lastObject];
        
        _mapView.userLocation.title = @"你的位置";
        _mapView.showsUserLocation = YES;
        
        locationManager = [[CLLocationManager alloc]init];
        locationManager.delegate = self;
        
        [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        
        [locationManager setDistanceFilter:1000.0f];
        [locationManager startUpdatingLocation];
        
        MKCoordinateRegion theRegin;
        
        CLLocationCoordinate2D theCoordinate;
        
        theCoordinate.latitude = 31.2830017791500;
        theCoordinate.longitude = 121.50064302406390;
        
        theRegin.center = theCoordinate;
        theRegin.span.latitudeDelta = 0.005f;
        theRegin.span.longitudeDelta = 0.005f;
        
    //Wait for core data...
        Annotation *test = [AnnotationCreate createMapPointWithcoordinateX:31.2830017791500 coordinateY:121.50064302406390 Title:@"同济大学" Subtitle:@"四平路校区"];
        Annotation *test2 = [AnnotationCreate createMapPointWithcoordinateX:31.2807017791500 coordinateY:121.50064302406390 Title:@"同济大学体育馆" Subtitle:@"四平路校区"];
        Annotation *test3 = [AnnotationCreate createMapPointWithcoordinateX:31.2834017791500 coordinateY:121.50364302406390 Title:@"同济大学图书馆" Subtitle:@"四平路校区"];
        
        [_mapView addAnnotations:[NSArray arrayWithObjects:test,test2,
                                                            test3,nil]];
        [_mapView setRegion:theRegin];
        
    //This Bug cannot solve.   Just add a annotation.
        //_mapView.delegate = self;
        
        
        [_mapView regionThatFits:theRegin];
        
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//add pins.
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    
    MKPinAnnotationView *pinView = nil;
    if(annotation != mapView.userLocation)
    {
        static NSString *defaultPinID = @"com.invasivecode.pin";
        pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
        if ( pinView == nil ) pinView = [[MKPinAnnotationView alloc]
                                          initWithAnnotation:annotation reuseIdentifier:defaultPinID];
        pinView.pinColor = MKPinAnnotationColorRed;
        pinView.canShowCallout = YES;
        pinView.animatesDrop = YES;
        
    }
    else {
        [mapView.userLocation setTitle:annotation.title];
        [mapView.userLocation setSubtitle:annotation.subtitle];
    }
    return pinView;
}

//current location.Use for excute the distance.
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    CLLocationCoordinate2D loc = [newLocation coordinate];
    NSLog(@"loc.lat=%f,loc.log=%f",loc.latitude,loc.longitude);
}

-(CLLocationCoordinate2D)CurrentCLLocation
{
    CLLocation *location=[[CLLocation alloc] init];
    CLLocationCoordinate2D placeMarkLocation=[location coordinate];
    CLLocationManager *locmanager = [[CLLocationManager alloc] init];
    placeMarkLocation.latitude = [[locmanager location] coordinate].latitude;
    placeMarkLocation.longitude =[[locmanager location] coordinate].longitude;
    NSLog(@"1 得到当前的经纬度 placeMarkLocation=%f,%f",placeMarkLocation.latitude,placeMarkLocation.longitude);
    locmanager=nil;
    return placeMarkLocation;
}


@end
