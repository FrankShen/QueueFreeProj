//
//  GSTableViewController.m
//  QueueFree
//
//  Created by pursue_ct on 12-11-13.
//  Copyright (c) 2012年 BuG.BS. All rights reserved.
//

#import "GSTableViewController.h"

@interface GSTableViewController ()

@end

@implementation GSTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	[self.gsTableView registerNib:[UINib nibWithNibName:@"GSTableCell" bundle:nil] forCellReuseIdentifier:@"GSTableCell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark TableView Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(tableView == self.gsTableView)
    {
        return [self.resultArray count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(tableView == self.gsTableView)
    {
        GSTableCell *cell = [self.gsTableView dequeueReusableCellWithIdentifier:@"GSTableCell"];
        NSDictionary *dicTmp = [self.resultArray objectAtIndex:indexPath.row ];
        
        
        cell.shopName.text = [dicTmp objectForKey:@"名称"];
        int queueNum = arc4random() % 21;
        cell.queueNumberPeople.text = [NSString stringWithFormat:@"%d",queueNum];
        
        NSString *imageNumber = [dicTmp objectForKey:@"图片数量"];
        NSString *imagePath = [imageNumber isEqualToString:@"0"]?
        [[NSBundle mainBundle] pathForResource:[[dicTmp objectForKey:@"菜品信息"] objectAtIndex:0] ofType:@"jpg"] :
        [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@_1", [dicTmp objectForKey:@"名称"]] ofType:@"jpg"];
        //NSLog(@"ImagePath:%@", imagePath);
        UIImage *dish = [UIImage imageWithContentsOfFile:imagePath];
        
        cell.shopImageView.image = dish;
        
        cell.shopAddress.text = [dicTmp objectForKey:@"地址"];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GSTableCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self.delegate performSegue:cell.shopName.text];
}

@end
