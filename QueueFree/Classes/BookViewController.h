//
//  BookViewController.h
//  QueueFree
//
//  Created by BuG.BS on 12-11-13.
//  Copyright (c) 2012年 BuG.BS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UILabel *peopleNum;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UIDatePicker *picker;
@property (nonatomic) int peopleNumInt;
@end
