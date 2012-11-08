//
//  QFViewController.m
//  QueueFree
//
//  Created by BuG.BS on 12-10-24.
//  Copyright (c) 2012年 BuG.BS. All rights reserved.
//

#import "QFViewController.h"
#import "StarTableViewCell.h"
#import "CoreData/Restaurant+Plist.h"
#import "RestaurantViewController.h"
#import <CoreData/CoreData.h>

@interface QFViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *CustomTabBar;
@property (strong, nonatomic) NSArray *StarData;
@end

@implementation QFViewController
@synthesize managedObjectContext = _managedObjectContext;
@synthesize restaurantDatabase = _restaurantDatabase;
@synthesize fetchedResultsController = _fetchedResultsController;

- (void)changeSubView
{
    if (self.TabBar.starButton.selected){
        self.QFStarView.hidden = NO;
        self.QFHomeView.hidden = YES;
        self.QFQsnsView.hidden = YES;
        self.navigationItem.title = @"今日精选";
    }
    if (self.TabBar.homeButton.selected){
        self.QFStarView.hidden = YES;
        self.QFHomeView.hidden = NO;
        self.QFQsnsView.hidden = YES;
        self.navigationItem.title = @"主页";
    }
    if (self.TabBar.qsnsButton.selected){
        self.QFStarView.hidden = YES;
        self.QFHomeView.hidden = YES;
        self.QFQsnsView.hidden = NO;
        self.navigationItem.title = @"Q社区";
    }
}

//Add by Cui Hao for testing, when it's done, it will be deleted:

- (void)setupFetchedResultsController
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Restaurant"];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:self.restaurantDatabase.managedObjectContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
    
    
}

- (void)FetchPlistDataInDocument:(UIManagedDocument *)document
{
    dispatch_queue_t fetchQ = dispatch_queue_create("PlistInfo fetcher", NULL);
    dispatch_async(fetchQ, ^{
        
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"QueueFree" ofType:@"plist"];        
        NSArray *root = [[NSArray alloc] initWithContentsOfFile:filePath];
        
        [document.managedObjectContext performBlock:^{
            for (NSDictionary *theRestaurant in root) {
                //the Restaurant Category
                [Restaurant infoWithPlistInfo:theRestaurant inManagedObjectContext:document.managedObjectContext];
                
            }
        }];
        
    });
    //dispatch_release(fetchQ);
}

- (void)UseDocument
{
    if (![[NSFileManager defaultManager] fileExistsAtPath:[self.restaurantDatabase.fileURL path]]) {
        [self.restaurantDatabase saveToURL:self.restaurantDatabase.fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
            [self setupFetchedResultsController];
            [self FetchPlistDataInDocument:self.restaurantDatabase];
            
        }];
    } else if (self.restaurantDatabase.documentState == UIDocumentStateClosed) {
        [self.restaurantDatabase openWithCompletionHandler:^(BOOL success) {
            [self setupFetchedResultsController];
        }];
    } else if (self.restaurantDatabase.documentState == UIDocumentStateNormal) {
        [self setupFetchedResultsController];
    }
}

- (void)setRestaurantDatabase:(UIManagedDocument *)restaurantDatabase
{
    if (_restaurantDatabase != restaurantDatabase) {
        _restaurantDatabase = restaurantDatabase;
        [self UseDocument];
    }
}

//the end of this adding.

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //Add by Cui Hao for testing, when it's done, it will be deleted:
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"QueueFree" ofType:@"plist"];
    NSLog(@"The plist Path is :%@", filePath);
    
    NSArray *root = [[NSArray alloc] initWithContentsOfFile:filePath];
    NSLog(@"the restaurant count is %d", [root count]);
    
    if (!self.restaurantDatabase) {
        NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        url = [url URLByAppendingPathComponent:@"Default Restaurant Database"];
        self.restaurantDatabase = [[UIManagedDocument alloc] initWithFileURL:url];
    }
    
    
    //the end of this adding.
    
    self.StarData = @[
    @{@"old":@"15",@"now":@"12",@"shop":@"Salabim意式餐厅",@"name":@"焦糖奶油布丁"},
    @{@"old":@"38",@"now":@"30",@"shop":@"川杭人家",@"name":@"干锅千叶豆腐"},
    @{@"old":@"16",@"now":@"13",@"shop":@"宫の寿司",@"name":@"宫卷"},
    @{@"old":@"48",@"now":@"38",@"shop":@"虹林阁",@"name":@"松子鲈鱼"},
    @{@"old":@"23",@"now":@"18",@"shop":@"尖东茶楼",@"name":@"烧鹅"},
    @{@"old":@"38",@"now":@"30",@"shop":@"锦江大厨",@"name":@"XO酱爆元宝虾"},
    @{@"old":@"42",@"now":@"34",@"shop":@"聚点时尚烧烤主题餐厅(彰武路店)",@"name":@"上等牛舌"},
    @{@"old":@"58",@"now":@"46",@"shop":@"迈玛瑞",@"name":@"有机鱼头汤"},
    @{@"old":@"30",@"now":@"24",@"shop":@"权金城",@"name":@"烤五花肉"},
    @{@"old":@"38",@"now":@"30",@"shop":@"染山",@"name":@"三文鱼"},
    @{@"old":@"58",@"now":@"46",@"shop":@"沈家花园",@"name":@"蟹粉豆腐"},
    @{@"old":@"42",@"now":@"32",@"shop":@"菽心阁",@"name":@"酸汤肥牛"},
    @{@"old":@"88",@"now":@"69",@"shop":@"谭氏私房菜",@"name":@"谭氏老鸭汤"},
    @{@"old":@"46",@"now":@"36",@"shop":@"夏朵小厨",@"name":@"郁金香海鲜焗饭"},
    @{@"old":@"18",@"now":@"14",@"shop":@"夏月小厨",@"name":@"醋溜鱼片"},
    @{@"old":@"88",@"now":@"70",@"shop":@"新南华",@"name":@"水晶鸡"},
    @{@"old":@"42",@"now":@"34",@"shop":@"新雨",@"name":@"卡夫牛排"},
    @{@"old":@"48",@"now":@"38",@"shop":@"兴华川菜馆",@"name":@"烤鱼"},
    @{@"old":@"38",@"now":@"30",@"shop":@"愚慧阁",@"name":@"牛油虾"},
    ];

    
    
    self.QFHomeView = [[[NSBundle mainBundle] loadNibNamed:@"QFHomeView" owner:self options:nil] lastObject];
    self.QFStarView = [[[NSBundle mainBundle] loadNibNamed:@"QFStarView" owner:self options:nil] lastObject];
    self.QFQsnsView = [[[NSBundle mainBundle] loadNibNamed:@"QFQsnsView" owner:self options:nil] lastObject];
    
    [self.view addSubview:self.QFStarView];
    [self.view addSubview:self.QFHomeView];
    [self.view addSubview:self.QFQsnsView];
    
    self.TabBar.starButton.selected = NO;
    self.TabBar.homeButton.selected = YES;
    self.TabBar.qsnsButton.selected = NO;
    
    [self changeSubView];
    
    [self.StarTableView registerNib:[UINib nibWithNibName:@"StarTableViewCell" bundle:nil] forCellReuseIdentifier:@"StarTableViewCell"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setCustomTabBar:nil];
    [self setTabBar:nil];
    [super viewDidUnload];
}

- (IBAction)starButtonPressed:(id)sender
{
    if (!self.TabBar.starButton.selected){
        self.TabBar.starButton.selected = YES;
        self.TabBar.homeButton.selected = NO;
        self.TabBar.qsnsButton.selected = NO;
        [self changeSubView];
    }
}

- (IBAction)homeButtonPressed:(id)sender
{
    if (!self.TabBar.homeButton.selected){
        self.TabBar.starButton.selected = NO;
        self.TabBar.homeButton.selected = YES;
        self.TabBar.qsnsButton.selected = NO;
        [self changeSubView];
    }
}

- (IBAction)qsnsButtonPressed:(id)sender
{
    if (!self.TabBar.qsnsButton.selected){
        self.TabBar.starButton.selected = NO;
        self.TabBar.homeButton.selected = NO;
        self.TabBar.qsnsButton.selected = YES;
        [self changeSubView];
    }
}
- (IBAction)globalSearchPressed:(id)sender
{
    [self performSegueWithIdentifier:@"GlobalSearch" sender:self.parentViewController];
}
- (IBAction)nearSearchPressed:(id)sender
{
    [self performSegueWithIdentifier:@"NearSearch" sender:self.parentViewController];
}
- (IBAction)qsnsEatPressed:(id)sender
{
    [self performSegueWithIdentifier:@"QSNSEat" sender:nil];
}

- (IBAction)qsnsTipPressed:(id)sender
{
    [self performSegueWithIdentifier:@"QSNSTip" sender:nil];
}

- (IBAction)qsnsCollectPressed:(id)sender
{
    [self performSegueWithIdentifier:@"QSNSCollect" sender:nil];
}

- (IBAction)qsnsFindPressed:(id)sender
{
    [self performSegueWithIdentifier:@"QSNSFind" sender:nil];
}
#pragma mark delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.StarTableView){
        return self.StarData.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.StarTableView) {
        StarTableViewCell *cell = [self.StarTableView dequeueReusableCellWithIdentifier:@"StarTableViewCell"];
        NSDictionary *tempDic = [self.StarData objectAtIndex:indexPath.row];
        cell.dishImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",indexPath.row]];
        cell.shopName.text = [tempDic objectForKey:@"shop"];
        cell.dishName.text = [tempDic objectForKey:@"name"];
        cell.oldPrice.text = [tempDic objectForKey:@"old"];
        cell.nowPrice.text = [tempDic objectForKey:@"now"];
        return cell;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.StarTableView){
        StarTableViewCell *cell = [self.StarTableView cellForRowAtIndexPath:indexPath];
        [self performSegueWithIdentifier:@"StarToRestaurant" sender:cell.shopName.text];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"StarToRestaurant"]){
        NSString *name = sender;
        RestaurantViewController *newVC = segue.destinationViewController;
        [newVC initWithShop:name];
    }
}
@end
