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
        return 6;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(tableView == self.gsTableView)
    {
        GSTableCell *cell = [self.gsTableView dequeueReusableCellWithIdentifier:@"GSTableCell"];
        
        return cell;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //GSTableCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //[self.delegate performSegue:cell.shopNameLabel.text];
}

@end
