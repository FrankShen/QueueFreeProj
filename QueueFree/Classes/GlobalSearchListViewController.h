//
//  GlobalSearchListViewController.h
//  QueueFree
//
//  Created by BuG.BS on 12-10-26.
//  Copyright (c) 2012年 BuG.BS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestaurantViewController.h"
#import "GSMapViewController.h"
#import "QFGlobalSearchBrain.h"


@interface GlobalSearchListViewController : UIViewController{
    
}
@property (weak, nonatomic) IBOutlet UITextField *keyword;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *viewChangeButton;
@property (weak, nonatomic) GSMapViewController* globalSearchMVC;
@property (weak, nonatomic) UIView* listView;

@end
