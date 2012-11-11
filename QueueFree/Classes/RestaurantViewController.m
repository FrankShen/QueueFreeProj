//
//  RestaurantViewController.m
//  QueueFree
//
//  Created by BuG.BS on 12-11-7.
//  Copyright (c) 2012年 BuG.BS. All rights reserved.
//

#import "RestaurantViewController.h"
#import "MBProgressHUD.h"
#import <QuartzCore/QuartzCore.h>
@interface RestaurantViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,MBProgressHUDDelegate>
@property (nonatomic, strong) UIView *infoView;
@property (nonatomic) int shopPhotoNum;
@property (nonatomic) int currentShopImageIdx;
@end

@implementation RestaurantViewController

- (NSMutableArray *)shopImage
{
    if (!_shopImage){
        _shopImage = [[NSMutableArray alloc] init];
    }
    return _shopImage;
}

- (NSMutableArray *)dishImage
{
    if (!_dishImage){
        _dishImage = [[NSMutableArray alloc] init];
    }
    return _dishImage;
}


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
    self.navigationItem.title = self.shopName;
    [self.dishTableView registerNib:[UINib nibWithNibName:@"DishTableViewCell" bundle:nil] forCellReuseIdentifier:@"DishTableViewCell"];
}

- (void)playAnimation
{
    if (self.currentShopImageIdx == self.shopPhotoNum){
        self.currentShopImageIdx = 0;
    }
    if (self.infoView != nil){
        self.shopImageView.image = [self.shopImage objectAtIndex:self.currentShopImageIdx];
        [UIView animateWithDuration:1.0 animations:^{
            self.shopImageView.alpha = 1.0f;
        }completion:^(BOOL isFinished){
            [UIView animateWithDuration:1.0 delay:3.0 options:UIViewAnimationCurveEaseInOut animations:^{
                self.shopImageView.alpha = 0.0f;
            }completion:^(BOOL isFinished){
                ++self.currentShopImageIdx;
                [self playAnimation];
            }];
        }];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    self.shopImageView.alpha = 0.0f;
    [self playAnimation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.view.layer removeAllAnimations];
    [self setInfoView:nil];
}

- (void)viewDidUnload {

    [self setTimeLabel:nil];
    [self setPhoneLabel:nil];
    [self setAddressLabel:nil];
    [self setStarLabel:nil];
    [self setShopNameLabel:nil];
    [self setScrollView:nil];
    [self setShopImageView:nil];
    [self setDishTableView:nil];
    [super viewDidUnload];
}

- (IBAction)userFavourPressed:(id)sender
{
    NSMutableArray *list = [[[NSUserDefaults standardUserDefaults] objectForKey:@"UserFavour"] mutableCopy];
    int idx;
    for (idx = 0; idx < list.count; ++idx){
        if ([self.shopName isEqualToString:[list objectAtIndex:idx]]){
            break;
        }
    }
    if (idx == list.count){
        [list addObject:self.shopName];
        [[NSUserDefaults standardUserDefaults] setObject:list forKey:@"UserFavour"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        // Configure for text only and offset down
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"已添加到收藏";
        hud.margin = 10.f;
        hud.yOffset = 150.f;
        hud.removeFromSuperViewOnHide = YES;
        
        [hud hide:YES afterDelay:1];
    } else {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        // Configure for text only and offset down
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"已经收藏了";
        hud.margin = 10.f;
        hud.yOffset = 150.f;
        hud.removeFromSuperViewOnHide = YES;
        
        [hud hide:YES afterDelay:1];
    }
    
}

#pragma mark delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dishInfo.count % 2){
        return self.dishInfo.count / 2 + 1;
    } else {
        return self.dishInfo.count / 2;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DishTableViewCell *cell = [self.dishTableView dequeueReusableCellWithIdentifier:@"DishTableViewCell"];
    cell.dish1Image.image = [self.dishImage objectAtIndex:indexPath.row*2];
    cell.dish1Lable.text = [self.dishInfo objectAtIndex:indexPath.row*2];
    
    cell.dish2Image.alpha = 1.0f;
    cell.dish2Border.alpha = 1.0f;
    
    if ([[self.dishInfo objectAtIndex:indexPath.row*2] isEqual:[self.dishInfo lastObject]]) {
        cell.dish2Image.alpha = 0.0f;
        cell.dish2Border.alpha = 0.0f;
        cell.dish2Label.text = @"";
    } else {
        cell.dish2Image.image = [self.dishImage objectAtIndex:indexPath.row*2+1];
        cell.dish2Label.text = [self.dishInfo objectAtIndex:indexPath.row*2+1];
    }
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
    self.shopName = name;
    self.shopPhotoNum = [[finalDic objectForKey:@"图片数量"] intValue];
    self.workTime = [finalDic objectForKey:@"营业时间"];
    self.shopAddress = [finalDic objectForKey:@"地址"];
    self.shopStar = [finalDic objectForKey:@"餐厅特色"];
    self.shopPhone = [finalDic objectForKey:@"电话"];
    self.dishInfo = [finalDic objectForKey:@"菜品信息"];
    
    if (self.shopPhotoNum == 0){
        int maxNum = 4;
        if (self.dishInfo.count < maxNum){
            maxNum = self.dishInfo.count;
        }
        self.shopPhotoNum = maxNum;
        for (int idx = 0; idx < maxNum; ++idx){
            [self.shopImage addObject:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@", [self.dishInfo objectAtIndex:idx]] ofType:@"jpg"]]];
        }
    } else {
        for (int idx = 0; idx < self.shopPhotoNum; ++idx){
            [self.shopImage addObject:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@_%d", self.shopName, idx+1] ofType:@"jpg"]]];
        }
    }
    
    for (int idx = 0; idx < self.dishInfo.count; ++idx){
        [self.dishImage addObject:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@", [self.dishInfo objectAtIndex:idx]] ofType:@"jpg"]]];
    }
    //self.shopImage
}


- (void)hudWasHidden:(MBProgressHUD *)hud {
	// Remove HUD from screen when the HUD was hidded
	[hud removeFromSuperview];
	hud = nil;
}

@end
