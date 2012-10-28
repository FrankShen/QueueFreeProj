//
//  Dish.h
//  QueueFree
//
//  Created by Cui Hao on 12-10-28.
//  Copyright (c) 2012年 BuG.BS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Restaurant;

@interface Dish : NSManagedObject

@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Restaurant *restaurantInfo;

@end
