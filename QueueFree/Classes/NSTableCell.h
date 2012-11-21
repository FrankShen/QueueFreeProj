//
//  NSTableViewCell.h
//  QueueFree
//
//  Created by pursue_ct on 12-11-7.
//  Copyright (c) 2012年 BuG.BS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *shopImageView;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceToUserLocationLabel;
@property (strong, nonatomic) IBOutlet UILabel *queueNumberPeople0;
@property (strong, nonatomic) IBOutlet UILabel *queueNumberPeople1;
@property (strong, nonatomic) IBOutlet UILabel *queueNumberPeople2;


@end
