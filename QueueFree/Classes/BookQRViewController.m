//
//  BookQRViewController.m
//  QueueFree
//
//  Created by BuG.BS on 12-11-13.
//  Copyright (c) 2012年 BuG.BS. All rights reserved.
//

#import "BookQRViewController.h"
#import "Barcode.h"
@interface BookQRViewController ()

@end

@implementation BookQRViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setNameLabel:nil];
    [self setDateLabel:nil];
    [self setQrCode:nil];
    [super viewDidUnload];
}
- (IBAction)homePrssed:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
