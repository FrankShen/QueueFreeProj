//
//  NSTableViewController.h
//  QueueFree
//
//  Created by pursue_ct on 12-11-6.
//  Copyright (c) 2012年 BuG.BS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSTableViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic)NSArray *dataList;
@property (nonatomic)NSArray *imageList;

@end
