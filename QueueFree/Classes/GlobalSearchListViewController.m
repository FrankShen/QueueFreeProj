//
//  GlobalSearchListViewController.m
//  QueueFree
//
//  Created by BuG.BS on 12-10-26.
//  Copyright (c) 2012年 BuG.BS. All rights reserved.
//

#import "GlobalSearchListViewController.h"


@interface GlobalSearchListViewController ()
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
    
    [self.theFormerView addSubview:self.globalSearchMVC.mapView];
    
    // the Test for QFGlobalSearchBrain by Cui Hao
    
    searchBrain = [[QFGlobalSearchBrain alloc] init];
    
    NSArray *resultList = [searchBrain theResultArrayForKeyWord:@"路"];
    for (NSDictionary *rest in resultList) {
        NSLog(@"NAME:%@", [rest valueForKey:@"名称"]);
    }

    NSArray *resultList2 = [searchBrain theResultArrayForKeyWord:@"馋"];
    for (NSDictionary *rest in resultList2) {
        NSLog(@"NAME:%@", [rest valueForKey:@"名称"]);
    }
    
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

@end
