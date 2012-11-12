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
        
        //Wait for core data...
        
        _annotations = [[NSMutableArray alloc] init];
        
        NSArray *root = [[[UIApplication sharedApplication] delegate] performSelector:@selector(getDataArray)];
        
        for (NSDictionary *theRestaurant in root) {
            
            NSString *name = [theRestaurant valueForKey:@"名称"];
            NSString *address = [theRestaurant valueForKey:@"地址"];
            double longtitude = [[theRestaurant valueForKey:@"东经"] doubleValue];
            double latitude = [[theRestaurant valueForKey:@"北纬"] doubleValue];
            
            Annotation *anno = [AnnotationCreate createMapPointWithcoordinateX:latitude coordinateY:longtitude Title:name Subtitle:address];
            
            [_annotations addObject:anno];
        }
        
        theCoordinate.latitude = [[root[0] valueForKey:@"北纬"]doubleValue];
        theCoordinate.longitude =[[root[0] valueForKey:@"东经"]doubleValue];
        
        
        theRegin.center = theCoordinate;
        
        theRegin.span.latitudeDelta = 0.009f;
        theRegin.span.longitudeDelta = 0.009f;
        
        [self.mapView addAnnotations:_annotations];
        [self.mapView setRegion:theRegin];
        
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

- (void)viewDidUnload {
    [self setMapView:nil];
    [self setMapView:nil];
    [super viewDidUnload];
    
}
@end
