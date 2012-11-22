//
//  QFAppDelegate.h
//  QueueFree
//
//  Created by BuG.BS on 12-10-24.
//  Copyright (c) 2012年 BuG.BS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCDAsyncSocket.h"
#define SIGNAL_1 100
#define SIGNAL_2 101
#define SIGNAL_3 102
#define SIGNAL_4 103
@protocol QFAppDelegate <NSObject>

- (void)reloadDataOK:(id)sender;

@end

@interface QFAppDelegate : UIResponder <UIApplicationDelegate,GCDAsyncSocketDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSMutableArray *Database;

@property (strong, nonatomic) GCDAsyncSocket *socket;
@property (strong, nonatomic) NSString *ipaddress;
@property (nonatomic) int portAddress;

@property (weak, nonatomic) id<QFAppDelegate>DataDelegate;

- (NSArray *)getDataArray;
- (void)connectWithIPAndPort:(NSDictionary *)sender;
- (void)sendData:(NSDictionary *)sender;
@end
