//
//  BookViewController.m
//  QueueFree
//
//  Created by BuG.BS on 12-11-13.
//  Copyright (c) 2012年 BuG.BS. All rights reserved.
//

#import "BookViewController.h"
#import "BookQRViewController.h"
@interface BookViewController ()<UIPickerViewDelegate,UIAlertViewDelegate>

@end

@implementation BookViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    if (self.peopleNumInt == 0){
        self.peopleNum.text = @"1~2人";
    }else if (self.peopleNumInt == 1){
        self.peopleNum.text = @"3~5人";
    }else if (self.peopleNumInt == 2){
        self.peopleNum.text = @"5人以上";
    }
    [self.picker addTarget:self action:@selector(dateChanged:)
          forControlEvents:UIControlEventValueChanged];
    NSDateFormatter *dataFormatter = [[NSDateFormatter alloc] init];
    [dataFormatter setDateFormat:@"MM-dd HH:mm"];
    NSString *currentDateStr = [dataFormatter stringFromDate:[NSDate date]];
    self.date.text =  currentDateStr;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)textFiledReturnEditing:(id)sender {
    [sender resignFirstResponder];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (void)viewDidUnload {
    [self setName:nil];
    [self setPhone:nil];
    [self setPeopleNum:nil];
    [self setDate:nil];
    [self setPicker:nil];
    [self setPicker:nil];
    [super viewDidUnload];
}

- (void) dateChanged:(id)sender{
    NSDateFormatter *dataFormatter = [[NSDateFormatter alloc] init];
    [dataFormatter setDateFormat:@"MM-dd HH:mm"];
    NSString *currentDateStr = [dataFormatter stringFromDate:self.picker.date];
    self.date.text =  currentDateStr;
}
- (IBAction)bookPressed:(id)sender
{
    NSString *msg = [NSString stringWithFormat:@"%@\n姓名：%@\n人数：%@\n时间%@",self.navigationItem.title, self.name.text, self.peopleNum.text, self.date.text];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确认预定" message:msg delegate:self cancelButtonTitle:@"取消预定" otherButtonTitles:@"确认预定",nil];
    [self.view addSubview:alert];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSString *msg = @"";
        msg = [msg stringByAppendingFormat:@"%d",self.peopleNumInt];
        for (int idx = 0; idx < 5; ++idx) {
            msg = [msg stringByAppendingFormat:@"%d",arc4random()%10];
        }
        [self performSegueWithIdentifier:@"BookToQR" sender:msg];
    }
    [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
    [alertView removeFromSuperview];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"BookToQR"]){
        BookQRViewController *newVC = segue.destinationViewController;
        newVC.codeStr = sender;
        newVC.navigationItem.title = self.navigationItem.title;
        newVC.userStr = self.name.text;
        newVC.dateStr = self.date.text;
        NSMutableArray *list = [[[NSUserDefaults standardUserDefaults] objectForKey:@"BookList"] mutableCopy];
        [list addObject:@{@"name":self.navigationItem.title, @"user":self.name.text, @"qrcode":sender, @"date":self.date.text}];
        [[NSUserDefaults standardUserDefaults] setObject:list forKey:@"BookList"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        NSLog(@"%@",list);
        [newVC.navigationItem setHidesBackButton:YES];
    }
}
@end
