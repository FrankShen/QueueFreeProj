//
//  UserFavourCell.h
//  QueueFree
//
//  Created by BuG.BS on 12-11-12.
//  Copyright (c) 2012年 BuG.BS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserFavourCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *shopImage;
@property (weak, nonatomic) IBOutlet UILabel *shopName;
@property (weak, nonatomic) IBOutlet UILabel *shopAddress;

@end
