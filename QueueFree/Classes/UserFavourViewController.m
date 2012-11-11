//
//  UserFavourViewController.m
//  QueueFree
//
//  Created by BuG.BS on 12-11-12.
//  Copyright (c) 2012年 BuG.BS. All rights reserved.
//

#import "UserFavourViewController.h"
#import "UserFavourCell.h"
#import "QFAppDelegate.h"
#import "RestaurantViewController.h"
@interface UserFavourViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, strong) NSMutableArray *detailData;
@end

@implementation UserFavourViewController

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
    NSArray *root = [[[UIApplication sharedApplication] delegate] performSelector:@selector(getDataArray)];
    self.detailData = [[NSMutableArray alloc] init];
    self.data = [[[NSUserDefaults standardUserDefaults] objectForKey:@"UserFavour"] mutableCopy];
    for (int idx = 0; idx < self.data.count; ++idx){
        int shopIdx;
        for (shopIdx = 0; shopIdx < root.count; ++shopIdx){
            if ([[self.data objectAtIndex:idx] isEqualToString:[[root objectAtIndex:shopIdx] objectForKey:@"名称"]]){
                [self.detailData insertObject:[root objectAtIndex:shopIdx] atIndex:idx];
            }
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

#pragma mark delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dicTmp = [self.detailData objectAtIndex:indexPath.row];
    
    UserFavourCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserFavourCell"];
    cell.shopName.text = [self.data objectAtIndex:indexPath.row];
    cell.shopAddress.text = [dicTmp objectForKey:@"地址"];
    
    NSString *imageNumber = [dicTmp objectForKey:@"图片数量"];
    NSString *imagePath = [imageNumber isEqualToString:@"0"]?
    [[NSBundle mainBundle] pathForResource:[[dicTmp objectForKey:@"菜品信息"] objectAtIndex:0] ofType:@"jpg"] :
    [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@_1", [dicTmp objectForKey:@"名称"]] ofType:@"jpg"];
    //NSLog(@"ImagePath:%@", imagePath);
    UIImage *dish = [UIImage imageWithContentsOfFile:imagePath];
    
    cell.shopImage.image = dish;

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserFavourCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [self performSegueWithIdentifier:@"FavourToRestaurant" sender:cell.shopName.text];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"FavourToRestaurant"]){
        NSString *name = sender;
        RestaurantViewController *newVC = segue.destinationViewController;
        [newVC initWithShop:name];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete){
        [self.detailData removeObjectAtIndex:indexPath.row];
        [self.data removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationTop];
        [[NSUserDefaults standardUserDefaults] setObject:self.data forKey:@"UserFavour"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
@end
