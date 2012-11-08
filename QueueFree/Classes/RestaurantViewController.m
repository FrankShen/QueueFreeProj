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
    
    self.shopNameLabel.text = self.shopName;
    if (self.workTime.count == 2){
        self.timeLabel.text = [NSString stringWithFormat:@"%@-%@",[self.workTime objectAtIndex:0],[self.workTime objectAtIndex:1]];
    } else {
        self.timeLabel.text = @"暂无营业时间";
    }
    self.phoneLabel.text = self.shopPhone;
    self.addressLabel.text = self.shopAddress;
    self.starLabel.text = @"";
    for (int idx = 0; idx < self.shopStar.count; ++idx){
        self.starLabel.text = [self.starLabel.text stringByAppendingFormat:@"%@ ", [self.shopStar objectAtIndex:idx]];
    }
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

- (void)initWithShop:(NSString *)name
{
    NSArray *rootData = [[[UIApplication sharedApplication] delegate] performSelector:@selector(getDataArray)];
    int idx;
    for (idx = 0; idx < rootData.count; ++idx) {
        NSDictionary *tempDic = [rootData objectAtIndex:idx];
        NSString *tempStr = [tempDic objectForKey:@"名称"];
        if ([name isEqualToString:tempStr]) {
            break;
        }
    }
    if (idx == rootData.count){
        return;
    }
    NSDictionary *finalDic = [rootData objectAtIndex:idx];
    NSLog(@"%@",finalDic);
    self.shopName = name;
    self.workTime = [finalDic objectForKey:@"营业时间"];
    self.shopAddress = [finalDic objectForKey:@"地址"];
    self.shopStar = [finalDic objectForKey:@"餐厅特色"];
    self.shopPhone = [finalDic objectForKey:@"电话"];
    self.dishInfo = [finalDic objectForKey:@"菜品信息"];
    //self.shopImage
}

@end
