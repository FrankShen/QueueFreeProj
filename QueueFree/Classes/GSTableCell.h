//
//  GSTableCell.h
//  QueueFree
//
//  Created by pursue_ct on 12-11-13.
//  Copyright (c) 2012年 BuG.BS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GSTableCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *shopImageView;
@property (strong, nonatomic) IBOutlet UILabel *shopName;
@property (strong, nonatomic) IBOutlet UILabel *queueNumberPeople0;
@property (strong, nonatomic) IBOutlet UILabel *queueNumberPeople1;
@property (strong, nonatomic) IBOutlet UILabel *queueNumberPeople2;
@property (strong, nonatomic) IBOutlet UILabel *shopAddress;
@end
