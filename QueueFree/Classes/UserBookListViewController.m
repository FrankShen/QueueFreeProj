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
#import "BookQRViewController.h"
#import "BookListCell.h"
@interface UserBookListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray * queueData;
@property (nonatomic, strong) NSArray * bookData;
@property (nonatomic) BOOL isBook;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *changeButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
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

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
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
        BookListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookListCell"];
        cell.shopNameLabel.text = [[self.bookData objectAtIndex:indexPath.row] objectForKey:@"name"];
        cell.dateLabel.text = [[self.bookData objectAtIndex:indexPath.row] objectForKey:@"date"];
        return cell;
    } else {
        QueueListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QueueListCell"];
        cell.shopNameLabel.text = [[self.queueData objectAtIndex:indexPath.row] objectForKey:@"name"];
        if ([[[self.queueData objectAtIndex:indexPath.row] objectForKey:@"peopleNum"] isEqualToString:@"已过号"]){
            cell.queueNumLabel.text = @"已过号";
        } else {
            cell.queueNumLabel.text = [NSString stringWithFormat:@"%@桌",[[self.queueData objectAtIndex:indexPath.row] objectForKey:@"peopleNum"]];
        }
        cell.index = indexPath.row;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isBook){
        [self performSegueWithIdentifier:@"ListToBook" sender:[self.bookData objectAtIndex:indexPath.row]];

    } else {
        [self performSegueWithIdentifier:@"ListToQueue" sender:[self.queueData objectAtIndex:indexPath.row]];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ListToQueue"]){
        QueueQRViewController *newVC = segue.destinationViewController;
        newVC.navigationItem.title = [sender objectForKey:@"name"];
        newVC.queueStr = [sender objectForKey:@"queue"];
        newVC.codeStr = [sender objectForKey:@"qrcode"];
        newVC.peopleNum = [[sender objectForKey:@"peopleNum"] intValue];
        newVC.index = [[sender objectForKey:@"index"] intValue];
    }
    if ([segue.identifier isEqualToString:@"ListToBook"]){
        BookQRViewController *newVC = segue.destinationViewController;
        newVC.navigationItem.title = [sender objectForKey:@"name"];
        newVC.userStr = [sender objectForKey:@"user"];
        newVC.dateStr = [sender objectForKey:@"date"];
        newVC.codeStr = [sender objectForKey:@"qrcode"];
    }

}

- (IBAction)changeViewButton:(id)sender
{
    if (self.isBook){
        self.changeButton.title = @"订座订单";
        self.isBook = NO;
        [self.tableView reloadData];
        self.navigationItem.title = @"排队订单";
    } else {
        self.changeButton.title = @"排队订单";
        self.isBook = YES;
        [self.tableView reloadData];
        self.navigationItem.title = @"订座订单";
    }
}
- (void)viewDidUnload {
    [self setChangeButton:nil];
    [self setTableView:nil];
    [super viewDidUnload];
}
@end
