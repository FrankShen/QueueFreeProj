//
//  RestaurantViewController.m
//  QueueFree
//
//  Created by BuG.BS on 12-11-7.
//  Copyright (c) 2012年 BuG.BS. All rights reserved.
//

#import "RestaurantViewController.h"

@interface RestaurantViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (nonatomic, weak) UIView *infoView;
@end

@implementation RestaurantViewController

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
    self.infoView = [[[NSBundle mainBundle] loadNibNamed:@"RestaurantView" owner:self options:nil] lastObject];
    [self.scrollView addSubview:self.infoView];
    self.scrollView.contentSize = self.infoView.frame.size;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTimeLabel:nil];
    [self setPhoneLabel:nil];
    [self setAddressLabel:nil];
    [self setStarLabel:nil];
    [self setShopNameLabel:nil];
    [self setScrollView:nil];
    [super viewDidUnload];
}


#pragma mark delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    return cell;
}
@end
