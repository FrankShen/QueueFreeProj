//
//  GSTableViewController.h
//  QueueFree
//
//  Created by pursue_ct on 12-11-13.
//  Copyright (c) 2012年 BuG.BS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GSTableCell.h"
@protocol GSTableViewDelegate <NSObject>

- (void)performSegue:(NSString *)shopName;

@end

@interface GSTableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    
}

@property (weak, nonatomic)IBOutlet UITableView* gsTableView;

@property (weak,nonatomic) id<GSTableViewDelegate> delegate;
@property (strong , nonatomic) NSArray *resultArray;
@end
