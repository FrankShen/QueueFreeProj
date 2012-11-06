//
//  AnnotationCreate.h
//  QueueFree
//
//  Created by pursue_ct on 12-11-6.
//  Copyright (c) 2012年 BuG.BS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Annotation.h"

@interface AnnotationCreate : NSObject<MKAnnotation>

+(Annotation *) createMapPointWithcoordinateX:(double)coorX coordinateY:(double)coorY Title:(NSString*)title Subtitle:(NSString*)subtitle;

@end
