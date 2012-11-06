//
//  Restaurant.h
//  QueueFree
//
//  Created by Cui Hao on 12-11-6.
//  Copyright (c) 2012年 BuG.BS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Dish, Telephone, Traffic;

@interface Restaurant : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * characteristic;
@property (nonatomic, retain) NSDate * closingTime;
@property (nonatomic, retain) NSNumber * identity;
@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * openingTime;
@property (nonatomic, retain) NSString * other;
@property (nonatomic, retain) NSNumber * parkingNumber;
@property (nonatomic, retain) NSString * telephone;
@property (nonatomic, retain) NSSet *dishInfo;
@property (nonatomic, retain) NSSet *telephoneInfo;
@property (nonatomic, retain) NSSet *trafficInfo;
@end

@interface Restaurant (CoreDataGeneratedAccessors)

- (void)addDishInfoObject:(Dish *)value;
- (void)removeDishInfoObject:(Dish *)value;
- (void)addDishInfo:(NSSet *)values;
- (void)removeDishInfo:(NSSet *)values;

- (void)addTelephoneInfoObject:(Telephone *)value;
- (void)removeTelephoneInfoObject:(Telephone *)value;
- (void)addTelephoneInfo:(NSSet *)values;
- (void)removeTelephoneInfo:(NSSet *)values;

- (void)addTrafficInfoObject:(Traffic *)value;
- (void)removeTrafficInfoObject:(Traffic *)value;
- (void)addTrafficInfo:(NSSet *)values;
- (void)removeTrafficInfo:(NSSet *)values;

@end
