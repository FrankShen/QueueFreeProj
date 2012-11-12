//
//  QueueQRViewController.m
//  QueueFree
//
//  Created by BuG.BS on 12-11-13.
//  Copyright (c) 2012年 BuG.BS. All rights reserved.
//

#import "QueueQRViewController.h"
#import "Barcode.h"
@interface QueueQRViewController ()

@end

@implementation QueueQRViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    Barcode *bar = [[Barcode alloc] init];
    [bar setupQRCode:self.codeStr];
    self.qrCode.image = [bar qRBarcode];
    self.queueNum.text = self.queueStr;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setQrCode:nil];
    [self setQueueNum:nil];
    [super viewDidUnload];
}
- (IBAction)homePressed:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
