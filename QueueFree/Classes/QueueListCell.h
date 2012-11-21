//
//  QueueListCell.h
//  QueueFree
//
//  Created by BuG.BS on 12-11-13.
//  Copyright (c) 2012年 BuG.BS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QueueListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *queueNumLabel;
@property (strong, nonatomic) NSString *qrCode;
@property (nonatomic) int index;
@end
