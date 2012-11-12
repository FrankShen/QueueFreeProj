//
//  GlobalSearchListViewController.m
//  QueueFree
//
//  Created by BuG.BS on 12-10-26.
//  Copyright (c) 2012年 BuG.BS. All rights reserved.
//

#import "GlobalSearchListViewController.h"


@interface GlobalSearchListViewController ()<GSTableViewDelegate>
@property (nonatomic) BOOL isList;
@property (nonatomic, strong) QFGlobalSearchBrain *searchBrain;
@end

@implementation GlobalSearchListViewController
@synthesize searchBrain;

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
    self.isList = YES;
    self.viewChangeButton.title = @"地图";
    
    
    self.globalSearchMVC = [[GSMapViewController alloc]init];
    self.globalSearchTVC = [[GSTableViewController alloc]init];
    
    //[self.theFormerView insertSubview:self.globalSearchMVC.mapView atIndex:0];
    //[self.theFormerView insertSubview:self.globalSearchTVC.view atIndex:0];
    
    
    // the Test for QFGlobalSearchBrain by Cui Hao
  
    
    // the end of the Test
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setKeyword:nil];
    [self setViewChangeButton:nil];
    [self setTheFormerView:nil];
    [super viewDidUnload];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (![self.keyword isExclusiveTouch]){
        [self.keyword resignFirstResponder];
    }
}

- (IBAction)searchButtonPressed:(id)sender
{
    if (![self.keyword isExclusiveTouch]){
        [self.keyword resignFirstResponder];
        
        searchBrain = [[QFGlobalSearchBrain alloc] init];
        
        NSArray* resultList = [searchBrain theResultArrayForKeyWord:self.keyword.text];
        for (NSDictionary *rest in resultList) {
            NSLog(@"%@",[rest valueForKey:@"名称"]);
            self.globalSearchTVC.resultArray = [NSArray arrayWithObject:rest];
        }
        
        [self.theFormerView insertSubview:self.globalSearchTVC.view atIndex:0];
    }
}

- (IBAction)viewChangeButtonPressed:(id)sender
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
    [self.theFormerView exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
    
    self.isList = !self.isList;
    self.viewChangeButton.title = self.isList ? @"地图" : @"列表";
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

@end
