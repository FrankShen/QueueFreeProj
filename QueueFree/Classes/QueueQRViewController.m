//
//  QueueQRViewController.m
//  QueueFree
//
//  Created by BuG.BS on 12-11-13.
//  Copyright (c) 2012年 BuG.BS. All rights reserved.
//

#import "QueueQRViewController.h"
#import "Barcode.h"
#import <MessageUI/MessageUI.h>
@interface QueueQRViewController ()<MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *tempLabel;
@property (weak, nonatomic) IBOutlet UIButton *refreshButton;
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
    self.waitNum.text = [NSString stringWithFormat:@"%d", arc4random() % 21];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setQrCode:nil];
    [self setQueueNum:nil];
    [self setWaitNum:nil];
    [self setRefreshButton:nil];
    [self setTempLabel:nil];
    [super viewDidUnload];
}
- (IBAction)homePressed:(id)sender
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

- (IBAction)refreshPressed:(id)sender
{
    int num;
    num = [self.waitNum.text intValue];
    num--;
    if (num < 0){
        self.waitNum.text = @"";
        self.tempLabel.text = @"已过号";
        self.refreshButton.hidden = YES;
    } else {
        self.waitNum.text = [NSString stringWithFormat:@"%d", num];
    }
}

@end
