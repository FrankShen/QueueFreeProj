//
//  AnnotationObject.m
//  QueueFree
//
//  Created by pursue_ct on 12-11-6.
//  Copyright (c) 2012年 BuG.BS. All rights reserved.
//

#import "Annotation.h"

@implementation Annotation

@synthesize title,subtitle,coordinate;

- (id) initWithCoords:(CLLocationCoordinate2D) coords{
    
    self = [super init];
    
    if (self != nil) {
        coordinate = coords;
    }
    
    return self;
    
}



@end
