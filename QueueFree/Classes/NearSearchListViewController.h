//
//  NearSearchListViewController.h
//  QueueFree
//
//  Created by BuG.BS on 12-10-26.
//  Copyright (c) 2012年 BuG.BS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "RestaurantViewController.h"
#import "NSMapViewController.h"
#import "NSTableViewController.h"

@interface NearSearchListViewController : UIViewController{
    NSMapViewController *nearSearchMVC;
    NSTableViewController *nearSearchTVC;
}


@property (weak, nonatomic) IBOutlet UIBarButtonItem *viewChangeButton;


@end
