//
//  QFGlobalSearchBrain.h
//  QueueFree
//
//  Created by Cui Hao on 12-11-10.
//  Copyright (c) 2012年 BuG.BS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QFGlobalSearchBrain : NSObject

@property (nonatomic, strong) NSMutableArray *resultList;

- (NSArray *)theResultArrayForKeyWord:(NSString *)keyWord;

@end
