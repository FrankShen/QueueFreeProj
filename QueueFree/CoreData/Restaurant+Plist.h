//
//  Restaurant+Plist.h
//  QueueFree
//
//  Created by Cui Hao on 12-11-6.
//  Copyright (c) 2012年 BuG.BS. All rights reserved.
//

#import "Restaurant.h"

@interface Restaurant (Plist)

+ (Restaurant *)infoWithPlistInfo:(NSDictionary *)plistInfo
             inManagedObjectContext:(NSManagedObjectContext *)context;

@end
