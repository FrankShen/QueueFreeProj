//
//  NearSearchListViewController.m
//  QueueFree
//
//  Created by BuG.BS on 12-10-26.
//  Copyright (c) 2012年 BuG.BS. All rights reserved.
//

#import "NearSearchListViewController.h"
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
    
    nearSearchMVC = [[NSMapViewController alloc]init];
    nearSearchTVC = [[NSTableViewController alloc]init];
    
    [self.view insertSubview:nearSearchMVC.mapView atIndex:0];
    
    
    self.isList = NO;
    self.viewChangeButton.title = @"列表";
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setViewChangeButton:nil];
    [super viewDidUnload];
}

- (IBAction)viewChangeButtonPressed:(id)sender
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
    if(!self.isList)
    {
        [self.view insertSubview:nearSearchTVC.view atIndex:2];
    }
    else
    {
        [self.view exchangeSubviewAtIndex:2 withSubviewAtIndex:0];

        [self.view exchangeSubviewAtIndex:2 withSubviewAtIndex:1];
    }
    
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
    
    self.isList = !self.isList;
    self.viewChangeButton.title = self.isList ? @"地图" : @"列表";
    
}

#pragma mark mapButton

- (IBAction)mapButtonPressed:(id)sender
{
    [nearSearchMVC ShowRegionOfTheUserLocationPressed];
}

#pragma mark segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //segue.sourceViewController;
    //segue.destinationViewController;
    //sender;
    //调用segue的方法[self performSegueWithIdentifier:<#(NSString *)#> sender:<#(id)#>];

    if ([segue.identifier isEqualToString:@"GoToRestaurant"]){
        RestaurantViewController *newViewController = segue.destinationViewController;
        //sourceViewController是当前的vc，destinationViewController是下一个vc，sender是可传递的数据，只要将数据信息存在NSDictionary中，然后作为sender，在这个函数里抓取sender里的数据放到下一个vc里就可以了。
        
        
        // .....
        
        
    }
}

@end
