//
//  NSTableViewController.m
//  QueueFree
//
//  Created by pursue_ct on 12-11-8.
//  Copyright (c) 2012年 BuG.BS. All rights reserved.
//

#import "NSTableViewController.h"
#import "NSTableCell.h"
#import "math.h"

@interface NSTableViewController ()
@property (strong, nonatomic) NSMutableArray *tableviewdataarray;

@end

@implementation NSTableViewController

#define EARTH_RADIUS 6378.137
double rad(double d)
{
    return d * M_PI / 180.0;
}


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
    
    
    NSArray *root = [[[UIApplication sharedApplication] delegate] performSelector:@selector(getDataArray)];
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

- (int)dictanceFromTheUserLocationWithDictionaryData:(NSDictionary *)dictionary
{
    NSMapViewController *tempMapViewController = [[NSMapViewController alloc]init];
    
    if(tempMapViewController.mapView.userLocation.coordinate.latitude == 0 && tempMapViewController.mapView.userLocation.coordinate.longitude == 0)
    {
        return 0;
    }
    
    double radLatitude = rad([[dictionary objectForKey:@"北纬"]doubleValue]);
    double radLongtitude =rad([[dictionary objectForKey:@"东经"]doubleValue]);
    double radUserLatitude = rad(tempMapViewController.mapView.userLocation.coordinate.latitude);
    double radUserLongtitude = rad(tempMapViewController.mapView.userLocation.coordinate.longitude);
    double diffRadLati = (radLatitude - radUserLatitude)/2;
    double diffRadLongti = (radLongtitude - radUserLongtitude)/2;
    
    double distance = 2 * asin(sqrt(pow(sin(diffRadLati), 2) + cos(radLatitude) * cos(radUserLatitude) * pow(sin(diffRadLongti), 2)));
    
    distance *= EARTH_RADIUS;
    distance = round(distance * 10000) / 10000;
    int intDistance = distance * 1000;
    return intDistance;
    
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
        int queueNum = arc4random() % 21;
        cell.queuePeopleNumberLabel.text = [NSString stringWithFormat:@"%d",queueNum];
        cell.distanceToUserLocationLabel.text = [NSString stringWithFormat:@"%d",[self dictanceFromTheUserLocationWithDictionaryData:dicTmp]];
        
        NSString *imageNumber = [dicTmp objectForKey:@"图片数量"];
        NSString *imagePath = [imageNumber isEqualToString:@"0"]?
        [[NSBundle mainBundle] pathForResource:[[dicTmp objectForKey:@"菜品信息"] objectAtIndex:0] ofType:@"jpg"] :
        [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@_1", [dicTmp objectForKey:@"名称"]] ofType:@"jpg"];
        //NSLog(@"ImagePath:%@", imagePath);
        UIImage *dish = [UIImage imageWithContentsOfFile:imagePath];
        
        cell.shopImageView.image = dish;
        
        return cell;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSTableCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self.delegate performSegue:cell.shopNameLabel.text];
}

@end
