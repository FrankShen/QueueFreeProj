//
//  QFAppDelegate.m
//  QueueFree
//
//  Created by BuG.BS on 12-10-24.
//  Copyright (c) 2012年 BuG.BS. All rights reserved.
//

#import "QFAppDelegate.h"

@implementation QFAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"QueueFree" ofType:@"plist"];
    
    self.Database = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    for (int idx = 0; idx < self.Database.count; ++idx){
        NSMutableDictionary *tempDic = [[self.Database objectAtIndex:idx] mutableCopy];
        [tempDic setObject:[NSString stringWithFormat:@"%d",arc4random()%21] forKey:@"people0"];
        [tempDic setObject:[NSString stringWithFormat:@"%d",arc4random()%21] forKey:@"people1"];
        [tempDic setObject:[NSString stringWithFormat:@"%d",arc4random()%21] forKey:@"people2"];
        [self.Database replaceObjectAtIndex:idx withObject:tempDic];
    }
    
    self.socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    NSString *msg = @"1;2;3";

    
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (NSArray *)getDataArray
{
    return self.Database;
}

- (void) connectWithIPAndPort:(NSDictionary *)sender
{
    self.ipaddress = [sender objectForKey:@"ip"];
    self.portAddress = [[sender objectForKey:@"port"] intValue];
    
    NSError *err = nil;
    [self.socket connectToHost:self.ipaddress onPort:self.portAddress error:&err];
    
}

- (void) sendData:(NSDictionary *)sender
{
    [self.socket connectToHost:self.ipaddress onPort:self.portAddress error:nil];
    NSLog(@"%d",self.socket.isConnected);
    NSData *data = [sender objectForKey:@"data"];
    NSString *signal = [sender objectForKey:@"signal"];
    if ([signal isEqualToString:@"1"]){
        [self.socket writeData:data withTimeout:-1 tag:SIGNAL_1];
        [self.socket readDataWithTimeout:-1 tag:SIGNAL_1];
    } else if ([signal isEqualToString:@"2"]){
        [self.socket writeData:data withTimeout:-1 tag:SIGNAL_2];
    } else if ([signal isEqualToString:@"3"]){
        [self.socket writeData:data withTimeout:-1 tag:SIGNAL_3];
        [self.socket readDataWithTimeout:-1 tag:SIGNAL_3];
    } else if ([signal isEqualToString:@"4"]){
        [self.socket writeData:data withTimeout:-1 tag:SIGNAL_4];
        [self.socket readDataWithTimeout:-1 tag:SIGNAL_4];
    }
}

#pragma mark Delegate

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSString *msg = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",msg);
    if (tag == SIGNAL_1) {
        [self.DataDelegate reloadDataOK:msg];
    } else if (tag == SIGNAL_3) {
        [self.DataDelegate reloadDataOK:msg];
    } else if (tag == SIGNAL_4) {
        NSRange range;
        range = [msg rangeOfString:@";"];
        NSString *people0 = [msg substringToIndex:range.location];
        NSString *msg2 = [msg substringFromIndex:range.location+1];
        range = [msg2 rangeOfString:@";"];
        NSString *people1 = [msg2 substringToIndex:range.location];
        NSString *people2 = [msg2 substringFromIndex:range.location+1];
        people2 = [people2 substringToIndex:people2.length-1];
        
        NSMutableDictionary *dic = [[self.Database objectAtIndex:10] mutableCopy];
        [dic setObject:people0 forKey:@"people0"];
        [dic setObject:people1 forKey:@"people1"];
        [dic setObject:people2 forKey:@"people2"];
        [self.Database replaceObjectAtIndex:10 withObject:dic];
        [self.DataDelegate reloadDataOK:nil];
    }
}

@end
