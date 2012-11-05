//
//  Restaurant+Plist.m
//  QueueFree
//
//  Created by Cui Hao on 12-11-6.
//  Copyright (c) 2012年 BuG.BS. All rights reserved.
//

#import "Restaurant+Plist.h"

@implementation Restaurant (Plist)

+ (Restaurant *)infoWithPlistInfo:(NSDictionary *)plistInfo
             inManagedObjectContext:(NSManagedObjectContext *)context
{
    Restaurant *rest = nil;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Restaurant"];
    request.predicate = [NSPredicate predicateWithFormat:@"name = %@", [plistInfo objectForKey:@"名称"]];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"名称" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSError *error = nil;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if (!matches || ([matches count] > 1)) {
        //handle error;
    } else if ([matches count] == 0) {
        rest = [NSEntityDescription insertNewObjectForEntityForName:@"Restaurant" inManagedObjectContext:context];
        
        rest.name = [plistInfo objectForKey:@"名称"];
        NSLog(@"%@", rest.name);
        
        rest.latitude = [NSNumber numberWithDouble:[[plistInfo objectForKey:@"北纬"] doubleValue]];
        NSLog(@"%@", [plistInfo objectForKey:@"北纬"]);
        NSLog(@"%f", [rest.latitude doubleValue]);
        
        rest.longitude = [NSNumber numberWithDouble:[[plistInfo objectForKey:@"东经"] doubleValue]];
        NSLog(@"%f", [rest.longitude doubleValue]);
        
        rest.address = [plistInfo objectForKey:@"地址"];
        NSLog(@"%@", rest.address);
        
        rest.parkingNumber = [NSNumber numberWithDouble:[[plistInfo objectForKey:@"停车信息"] doubleValue]];
        NSLog(@"%d", [rest.parkingNumber integerValue]);
    } else {
        rest = [matches lastObject];
    }
    return rest;
}

@end
