//
//  NSMapViewController.m
//  QueueFree
//
//  Created by pursue_ct on 12-11-6.
//  Copyright (c) 2012年 BuG.BS. All rights reserved.
//

#import "NSMapViewController.h"

@interface NSMapViewController ()
@property (nonatomic, strong) NSMutableArray *annotations;

@end

@implementation NSMapViewController
@synthesize annotations = _annotations;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.mapView = [[[NSBundle mainBundle] loadNibNamed:@"NSMapView" owner:self options:nil] lastObject];
        
        self.mapView.userLocation.title = @"你的位置";
        self.mapView.showsUserLocation = YES;
        
        locationManager = [[CLLocationManager alloc]init];
        locationManager.delegate = self;
        
        [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        
        [locationManager setDistanceFilter:1000.0f];
        [locationManager startUpdatingLocation];
        
        MKCoordinateRegion theRegin;
        
        CLLocationCoordinate2D theCoordinate;
        
        theCoordinate.latitude = 31.2830017791500;
        theCoordinate.longitude = 121.50064302406390;
        
        theRegin.center = self.mapView.userLocation.coordinate;
        
    //Wait for core data...
        
        _annotations = [[NSMutableArray alloc] init];
        
        NSArray *root = [[[UIApplication sharedApplication] delegate] performSelector:@selector(getDataArray)];
        
        for (NSDictionary *theRestaurant in root) {
            
            NSString *name = [theRestaurant valueForKey:@"名称"];
            NSString *address = [theRestaurant valueForKey:@"地址"];
            double latitude = [[theRestaurant valueForKey:@"东经"] doubleValue];
            double longitude = [[theRestaurant valueForKey:@"北纬"] doubleValue];
            
            Annotation *anno = [AnnotationCreate createMapPointWithcoordinateX:longitude coordinateY:latitude Title:name Subtitle:address];
            
            [_annotations addObject:anno];
        }        
        
        [self.mapView addAnnotations:_annotations];
        [self.mapView setRegion:theRegin];
        
    //This Bug cannot solve.   Just add a annotation.
        //_mapView.delegate = self;
        
        
        [self.mapView regionThatFits:theRegin];
        
        }
        return self;
}



- (void)ShowRegionOfTheUserLocationPressed{
   
    MKCoordinateRegion theRegion;
    
    theRegion.center = self.mapView.userLocation.coordinate;
    
    theRegion.span.latitudeDelta = 0.009f;
    theRegion.span.longitudeDelta = 0.009f;

    
    [self.mapView setRegion:theRegion];
    
    [self.mapView regionThatFits:theRegion];
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


- (void)viewDidUnload {
    [super viewDidUnload];
}
@end
