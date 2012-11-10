//
//  QFGlobalSearchBrain.m
//  QueueFree
//
//  Created by Cui Hao on 12-11-10.
//  Copyright (c) 2012年 BuG.BS. All rights reserved.
//

#import "QFGlobalSearchBrain.h"

@implementation QFGlobalSearchBrain

@synthesize resultList = _resultList;

- (NSArray *)theResultArrayForKeyWord:(NSString *)keyWord
{
    NSLog(@"Hello I am the Search Brain");
    NSArray *root = [[[UIApplication sharedApplication] delegate] performSelector:@selector(getDataArray)];
    _resultList = [[NSMutableArray alloc] init];
    for (NSDictionary *restaurant in root) {
        //Search the restaurant name
        NSString *name = [restaurant valueForKey:@"名称"];
        NSRange range = [name rangeOfString:keyWord];
        if (range.length == keyWord.length) {
            [_resultList addObject:restaurant];
        }
        //Search the dish name
        NSArray *dishes = [restaurant valueForKey:@"菜品信息"];
        for (NSString *dish in dishes) {
            NSRange rang = [dish rangeOfString:keyWord];
            if (rang.length == keyWord.length) {
                [_resultList addObject:restaurant];
            }
        }
    }
    
    return _resultList;
}

@end
