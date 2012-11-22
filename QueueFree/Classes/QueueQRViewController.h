//
//  QueueQRViewController.h
//  QueueFree
//
//  Created by BuG.BS on 12-11-13.
//  Copyright (c) 2012年 BuG.BS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QueueQRViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *qrCode;
@property (weak, nonatomic) IBOutlet UILabel *queueNum;
@property (weak, nonatomic) IBOutlet UILabel *waitNum;
@property (nonatomic) int index;
@property (strong, nonatomic) NSString *codeStr;
@property (strong, nonatomic) NSString *queueStr;
@property (nonatomic) int peopleNum;
@end
