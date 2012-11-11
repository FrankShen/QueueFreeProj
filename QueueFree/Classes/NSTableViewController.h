//
//  NSTableViewController.h
//  QueueFree
//
//  Created by pursue_ct on 12-11-8.
//  Copyright (c) 2012年 BuG.BS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSMapViewController.h"

@protocol NSTableViewDelegate <NSObject>

- (void)performSegue:(NSString *)shopName;

@end

@interface NSTableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    int tableViewRowCount;
}

@property (weak,nonatomic)IBOutlet UITableView *nsTableView;
@property (strong,nonatomic)NSArray *dataList;
@property (weak,nonatomic) id<NSTableViewDelegate> delegate;
- (int)dictanceFromTheUserLocationWithDictionaryData:(NSDictionary *)dictionary;

@end
