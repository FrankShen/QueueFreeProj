//
//  Telephone.h
//  QueueFree
//
//  Created by Cui Hao on 12-10-28.
//  Copyright (c) 2012年 BuG.BS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Restaurant;

@interface Telephone : NSManagedObject

@property (nonatomic, retain) NSString * number;
@property (nonatomic, retain) Restaurant *restaurantInfo;

@end
