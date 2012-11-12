//
//  UserBookListViewController.m
//  QueueFree
//
//  Created by BuG.BS on 12-11-13.
//  Copyright (c) 2012年 BuG.BS. All rights reserved.
//

#import "UserBookListViewController.h"
#import "QueueListCell.h"
#import "QueueQRViewController.h"
@interface UserBookListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray * queueData;
@property (nonatomic, strong) NSArray * bookData;
@property (nonatomic) BOOL isBook;
@end

@implementation UserBookListViewController

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
    
    self.queueData = [[NSUserDefaults standardUserDefaults] objectForKey:@"QueueList"];
    self.bookData = [[NSUserDefaults standardUserDefaults] objectForKey:@"BookList"];
    self.isBook = NO;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isBook){
        return self.bookData.count;
    } else {
        return self.queueData.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isBook){
        
    } else {
        QueueListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QueueListCell"];
        cell.shopNameLabel.text = [[self.queueData objectAtIndex:indexPath.row] objectForKey:@"name"];
        cell.queueNumLabel.text = [[self.queueData objectAtIndex:indexPath.row] objectForKey:@"queue"];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isBook){
    } else {
        [self performSegueWithIdentifier:@"ListToQueue" sender:[self.queueData objectAtIndex:indexPath.row]];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ListToQueue"]){
        QueueQRViewController *newVC = segue.destinationViewController;
        newVC.navigationItem.title = [sender objectForKey:@"name"];
        newVC.queueStr = [sender objectForKey:@"queue"];
        newVC.codeStr = [sender objectForKey:@"qrcode"];
    }
}
@end
