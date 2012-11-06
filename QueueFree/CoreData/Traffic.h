//
//  Traffic.h
//  QueueFree
//
//  Created by Cui Hao on 12-11-6.
//  Copyright (c) 2012年 BuG.BS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Restaurant;

@interface Traffic : NSManagedObject

@property (nonatomic, retain) NSString * introduction;
@property (nonatomic, retain) NSNumber * type;
@property (nonatomic, retain) NSSet *restaurantInfo;
@end

@interface Traffic (CoreDataGeneratedAccessors)

- (void)addRestaurantInfoObject:(Restaurant *)value;
- (void)removeRestaurantInfoObject:(Restaurant *)value;
- (void)addRestaurantInfo:(NSSet *)values;
- (void)removeRestaurantInfo:(NSSet *)values;

@end
