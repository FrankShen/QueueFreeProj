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
@property (strong, nonatomic) NSString *codeStr;
@property (weak, nonatomic) IBOutlet UILabel *queueNum;
@property (strong, nonatomic) NSString *queueStr;
@end
