//
//  BookQRViewController.h
//  QueueFree
//
//  Created by BuG.BS on 12-11-13.
//  Copyright (c) 2012年 BuG.BS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookQRViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *qrCode;
@property (strong, nonatomic) NSString *codeStr;
@end
