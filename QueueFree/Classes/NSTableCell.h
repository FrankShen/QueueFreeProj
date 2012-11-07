//
//  NSTableViewCell.h
//  QueueFree
//
//  Created by pursue_ct on 12-11-7.
//  Copyright (c) 2012年 BuG.BS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *shopImage;
@property (weak, nonatomic) IBOutlet UILabel *shopName;
@property (weak, nonatomic) IBOutlet UILabel *queuePeopleNumber;
@property (weak, nonatomic) IBOutlet UILabel *distanceToUserLocation;

@end
