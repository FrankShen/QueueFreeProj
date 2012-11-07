//
//  RestaurantViewController.h
//  QueueFree
//
//  Created by BuG.BS on 12-11-7.
//  Copyright (c) 2012年 BuG.BS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RestaurantViewController : UIViewController

// 需在segue里设置完
@property (nonatomic, strong) NSString *shopName;//商家名称
@property (nonatomic, strong) NSString *openTime;//开业时间
@property (nonatomic, strong) NSString *closeTime;//停业时间
@property (nonatomic, strong) NSString *shopAddress;//商家地址

@property (nonatomic, strong) NSArray *shopImage;//商家图片，存url
@property (nonatomic, strong) NSArray *shopPhone;//商家照片，存string
@property (nonatomic, strong) NSArray *shopStar;//商家特色，存string
@property (nonatomic, strong) NSArray *dishInfo;//菜信息，存？？（我不是最清楚）


// IBOutlet
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *starLabel;

// rootViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
