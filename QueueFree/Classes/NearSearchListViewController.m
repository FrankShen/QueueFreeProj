//
//  NearSearchListViewController.m
//  QueueFree
//
//  Created by BuG.BS on 12-10-26.
//  Copyright (c) 2012年 BuG.BS. All rights reserved.
//

#import "NearSearchListViewController.h"
#import "NSMapViewController.h"
#import "Restaurant+Plist.h"


@interface NearSearchListViewController ()
@property (nonatomic) BOOL isList;
@end

@implementation NearSearchListViewController

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
    
    
    NSMapViewController *nearSearchMVC = [[NSMapViewController alloc]init];
    
    //[self addChildViewController:nearSearchMVC];
    
    //nearSearchMVC.mapView = [[[NSBundle mainBundle] loadNibNamed:@"NSMapView" owner:self options:nil] lastObject];
    
    [self.view addSubview:nearSearchMVC.mapView];
    
    
    self.isList = NO;
    self.viewChangeButton.title = @"列表";
    //[self addPin];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setListView:nil];
    [self setViewChangeButton:nil];
    [super viewDidUnload];
}

- (IBAction)viewChangeButtonPressed:(id)sender
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
    
    [self.view exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
    
    self.isList = !self.isList;
    self.viewChangeButton.title = self.isList ? @"地图" : @"列表";
}


@end
