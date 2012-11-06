//
//  AnnotationCreate.m
//  QueueFree
//
//  Created by pursue_ct on 12-11-6.
//  Copyright (c) 2012年 BuG.BS. All rights reserved.
//

#import "AnnotationCreate.h"


@implementation AnnotationCreate

+(Annotation *) createMapPointWithcoordinateX:(double)coorX coordinateY:(double)coorY Title:(NSString*)title Subtitle:(NSString*)subtitle{
    Annotation *anno = nil;
    CLLocationCoordinate2D coordpoint;
    if (coorX && coorY) {
        coordpoint.latitude = coorX;
        coordpoint.longitude = coorY;
        
        anno = [[Annotation alloc]initWithCoords:coordpoint];
        
        if(title != NULL)
        {
            anno.title = title;
        }
        
        if(subtitle != NULL)
        {
            anno.subtitle = subtitle;
        }
    }
    return anno;

}

@end
