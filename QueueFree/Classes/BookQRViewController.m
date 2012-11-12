//
//  BookQRViewController.m
//  QueueFree
//
//  Created by BuG.BS on 12-11-13.
//  Copyright (c) 2012年 BuG.BS. All rights reserved.
//

#import "BookQRViewController.h"
#import "Barcode.h"
#import <MessageUI/MessageUI.h>
@interface BookQRViewController ()<MFMailComposeViewControllerDelegate>

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
    self.nameLabel.text = self.userStr;
    self.dateLabel.text = self.dateStr;
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
- (IBAction)shareButtonPressed:(id)sender
{
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    if ([MFMailComposeViewController canSendMail]) {
        NSData *data = UIImagePNGRepresentation(self.qrCode.image);
        [mc addAttachmentData:data mimeType:@"image/png" fileName:@"QRCode"];
        [self presentModalViewController:mc animated:YES];
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error {
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail send canceled...");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved...");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent...");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail send errored: %@...", [error localizedDescription]);
            break;
        default:
            break;
    }
    [self dismissModalViewControllerAnimated:YES];
}
@end
