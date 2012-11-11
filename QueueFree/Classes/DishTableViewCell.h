//
//  DishTableViewCell.h
//  QueueFree
//
//  Created by BuG.BS on 12-11-12.
//  Copyright (c) 2012年 BuG.BS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DishTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *dish1Image;
@property (weak, nonatomic) IBOutlet UIImageView *dish2Image;
@property (weak, nonatomic) IBOutlet UILabel *dish1Lable;
@property (weak, nonatomic) IBOutlet UILabel *dish2Label;
@property (weak, nonatomic) IBOutlet UIImageView *dish2Border;

@end
