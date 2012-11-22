//
//  NearSearchListViewController.m
//  QueueFree
//
//  Created by BuG.BS on 12-10-26.
//  Copyright (c) 2012年 BuG.BS. All rights reserved.
//

#import "NearSearchListViewController.h"
#import "Restaurant+Plist.h"
#import "QFAppDelegate.h"

@interface NearSearchListViewController ()< NSTableViewDelegate,NSMapViewDelegate,QFAppDelegate>
@property (nonatomic) BOOL isList;
@end

@implementation NearSearchListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.nearSearchMVC = [[NSMapViewController alloc]init];
    self.nearSearchTVC = [[NSTableViewController alloc]init];
    
    [self.view insertSubview:self.nearSearchMVC.mapView atIndex:0];
    
    countsOfCreateButton = 0;
    
    
    self.isList = NO;
    self.viewChangeButton.title = @"列表";
    self.nearSearchTVC.delegate = self;
    self.nearSearchMVC.delegate = self;
    
    ((QFAppDelegate *)[[UIApplication sharedApplication] delegate]).DataDelegate = self;
    [[[UIApplication sharedApplication] delegate] performSelector:@selector(sendData:) withObject:@{@"signal":@"4", @"data":[@"4;" dataUsingEncoding:NSUTF8StringEncoding]}];
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
        [self.view insertSubview:self.nearSearchTVC.view atIndex:2];
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
    [self.nearSearchMVC ShowRegionOfTheUserLocationPressed];
}

#pragma mark segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"NearToRestaurant"]){
        NSString *name = sender;
        RestaurantViewController *newVC = segue.destinationViewController;
        [newVC initWithShop:name];
    }
}


#pragma mark delegate
- (void)performSegue:(NSString *)shopName
{
    [self performSegueWithIdentifier:@"NearToRestaurant" sender:shopName];
}

-(UIButton *)createTheButtonWithPinTitle:(NSString *)title
{
    NSArray *root = [[[UIApplication sharedApplication] delegate] performSelector:@selector(getDataArray)];
    for(countsOfCreateButton = 0 ; countsOfCreateButton < [root count] ; countsOfCreateButton++)
    {
        if(title == [[root objectAtIndex:countsOfCreateButton] valueForKey:@"名称"])
        {
            break;
        }
    }
    UIButton *button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [button setTag:countsOfCreateButton];
    [button addTarget:self action:@selector(performTheSegue:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

-(void)performTheSegue:(id)sender
{
    NSArray *root = [[[UIApplication sharedApplication] delegate] performSelector:@selector(getDataArray)];
    int index = [(UIButton *)sender tag];
    NSString* name = [[root objectAtIndex:index] valueForKey:@"名称"];
    [self performSegueWithIdentifier:@"NearToRestaurant" sender:name];
    
}

- (void)reloadDataOK:(id)sender
{
    [self.nearSearchTVC.nsTableView reloadData];
}

@end
