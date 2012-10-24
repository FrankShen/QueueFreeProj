//
//  QFViewController.h
//  QueueFree
//
//  Created by BuG.BS on 12-10-24.
//  Copyright (c) 2012年 BuG.BS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTabBarView.h"
@interface QFViewController : UIViewController
@property (weak, nonatomic) IBOutlet CustomTabBarView *TabBar;
@property (weak, nonatomic) UIView *QFHomeView;
@property (weak, nonatomic) UIView *QFStarView;
@property (weak, nonatomic) UIView *QFQsnsView;
@end
