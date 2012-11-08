//
//  NSTableViewController.m
//  QueueFree
//
//  Created by pursue_ct on 12-11-8.
//  Copyright (c) 2012年 BuG.BS. All rights reserved.
//

#import "NSTableViewController.h"
#import "NSTableCell.h"

@interface NSTableViewController ()
@property (strong,nonatomic) NSMutableArray *tableviewdataarray;

@end

@implementation NSTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.nsTableView registerNib:[UINib nibWithNibName:@"NSTableCell" bundle:nil] forCellReuseIdentifier:@"NSTableCell"];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"QueueFree" ofType:@"plist"];
    
    NSArray *root = [[NSArray alloc] initWithContentsOfFile:filePath];
    //NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
    NSMutableArray *tmpDataArray = [[NSMutableArray alloc] init];
    //NSMutableArray *tmpImageArray = [[NSMutableArray alloc] init];
    for (int i=0; i<[root count]; i++) {
        NSDictionary *dictionary = root[i];
       
        [tmpDataArray addObject:dictionary];
        
        //NSString *imageUrl = [[NSString alloc] initWithFormat:@"%i.png", i+1];
        //UIImage *image = [UIImage imageNamed:imageUrl];
        //[tmpImageArray addObject:image];
    }
    self.dataList = [tmpDataArray copy];
    //self.imageList = [tmpImageArray copy];
    /*NSString *filePath = [[NSBundle mainBundle] pathForResource:@"QueueFree" ofType:@"plist"];
    
    
    
    NSMutableArray *tmpDataArray = [[NSMutableArray alloc] init];
    //int i = 0;
    //NSMutableArray *tmpImageArray = [[NSMutableArray alloc] init];
    for (NSDictionary *dictionary in root) {
        
        NSString *tmp = [dictionary valueForKey:@"名称"];
        [tmpDataArray addObject:tmp];
        //i++;
        //NSString *imageUrl = [[NSString alloc] initWithFormat:@"%i.png", i+1];
        //UIImage *image = [UIImage imageNamed:imageUrl];
        //[tmpImageArray addObject:image];
    }
    self.dataList = [tmpDataArray copy];
    //self.imageList = [tmpImageArray copy];
     */
}

-(void)viewDidUnload
{
    [self setNsTableView:nil];
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark TableView Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(tableView == self.nsTableView)
    {
        return [self.dataList count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(tableView == self.nsTableView)
    {
        NSTableCell *cell = [self.nsTableView dequeueReusableCellWithIdentifier:@"NSTableCell"];
        NSDictionary *dicTmp = [self.dataList objectAtIndex:indexPath.row ];
        
        
        cell.shopNameLabel.text = [dicTmp objectForKey:@"名称"];
        
        return cell;
    }
}


- (NSIndexPath *)tableView:(UITableView *)tableView
  willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
