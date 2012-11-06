//
//  Telephone.h
//  QueueFree
//
//  Created by Cui Hao on 12-11-6.
//  Copyright (c) 2012年 BuG.BS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Restaurant;

@interface Telephone : NSManagedObject

@property (nonatomic, retain) NSString * number;
@property (nonatomic, retain) Restaurant *restaurantInfo;

@end
