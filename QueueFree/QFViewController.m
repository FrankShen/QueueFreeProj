//
//  QFViewController.m
//  QueueFree
//
//  Created by BuG.BS on 12-10-24.
//  Copyright (c) 2012年 BuG.BS. All rights reserved.
//

#import "QFViewController.h"

@interface QFViewController ()
@property (weak, nonatomic) IBOutlet UIView *CustomTabBar;

@end

@implementation QFViewController

- (void)changeSubView
{
    if (self.TabBar.starButton.selected){
        self.QFStarView.hidden = NO;
        self.QFHomeView.hidden = YES;
        self.QFQsnsView.hidden = YES;
        self.navigationItem.title = @"今日精选";
    }
    if (self.TabBar.homeButton.selected){
        self.QFStarView.hidden = YES;
        self.QFHomeView.hidden = NO;
        self.QFQsnsView.hidden = YES;
        self.navigationItem.title = @"主页";
    }
    if (self.TabBar.qsnsButton.selected){
        self.QFStarView.hidden = YES;
        self.QFHomeView.hidden = YES;
        self.QFQsnsView.hidden = NO;
        self.navigationItem.title = @"Q社区";
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.QFHomeView = [[[NSBundle mainBundle] loadNibNamed:@"QFHomeView" owner:self options:nil] lastObject];
    self.QFStarView = [[[NSBundle mainBundle] loadNibNamed:@"QFStarView" owner:self options:nil] lastObject];
    self.QFQsnsView = [[[NSBundle mainBundle] loadNibNamed:@"QFQsnsView" owner:self options:nil] lastObject];
    
    [self.view addSubview:self.QFStarView];
    [self.view addSubview:self.QFHomeView];
    [self.view addSubview:self.QFQsnsView];
    
    self.TabBar.starButton.selected = NO;
    self.TabBar.homeButton.selected = YES;
    self.TabBar.qsnsButton.selected = NO;
    
    [self changeSubView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setCustomTabBar:nil];
    [self setTabBar:nil];
    [super viewDidUnload];
}

- (IBAction)starButtonPressed:(id)sender
{
    if (!self.TabBar.starButton.selected){
        self.TabBar.starButton.selected = YES;
        self.TabBar.homeButton.selected = NO;
        self.TabBar.qsnsButton.selected = NO;
        [self changeSubView];
    }
}

- (IBAction)homeButtonPressed:(id)sender
{
    if (!self.TabBar.homeButton.selected){
        self.TabBar.starButton.selected = NO;
        self.TabBar.homeButton.selected = YES;
        self.TabBar.qsnsButton.selected = NO;
        [self changeSubView];
    }
}

- (IBAction)qsnsButtonPressed:(id)sender
{
    if (!self.TabBar.qsnsButton.selected){
        self.TabBar.starButton.selected = NO;
        self.TabBar.homeButton.selected = NO;
        self.TabBar.qsnsButton.selected = YES;
        [self changeSubView];
    }
}

@end
