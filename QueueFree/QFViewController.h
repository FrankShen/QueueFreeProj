//
//  QFViewController.h
//  QueueFree
//
//  Created by BuG.BS on 12-10-24.
//  Copyright (c) 2012年 BuG.BS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTabBarView.h"
#import <CoreData/CoreData.h>

@interface QFViewController : UIViewController<NSFetchedResultsControllerDelegate>

@property (weak, nonatomic) IBOutlet CustomTabBarView *TabBar;
@property (weak, nonatomic) UIView *QFHomeView;
@property (weak, nonatomic) UIView *QFStarView;
@property (weak, nonatomic) UIView *QFQsnsView;
@property (weak, nonatomic) IBOutlet UITableView *StarTableView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
//Add by Cui Hao for testing, when it's done, it will be deleted:
@property (nonatomic, strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, strong) UIManagedDocument *restaurantDatabase;
@property (nonatomic, strong) NSArray* array;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
//the end of this adding.

@end
