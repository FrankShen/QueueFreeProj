//
//  RestaurantViewController.h
//  QueueFree
//
//  Created by BuG.BS on 12-11-7.
//  Copyright (c) 2012年 BuG.BS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DishTableViewCell.h"
@interface RestaurantViewController : UIViewController

//
@property (nonatomic, strong) NSString *shopName;//商家名称
@property (nonatomic, strong) NSString *shopAddress;//商家地址
@property (nonatomic, strong) NSString *shopPhone;//商家电话

@property (nonatomic, strong) NSMutableArray *dishImage;//菜图片
@property (nonatomic, strong) NSArray *workTime;//时间
@property (nonatomic, strong) NSMutableArray *shopImage;//商家图片

@property (nonatomic, strong) NSArray *shopStar;//商家特色，存string
@property (nonatomic, strong) NSArray *dishInfo;//菜信息


// IBOutlet
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *starLabel;
@property (weak, nonatomic) IBOutlet UIImageView *shopImageView;
@property (weak, nonatomic) IBOutlet UITableView *dishTableView;

// rootViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


- (void)initWithShop:(NSString *)_shopName;
@end
