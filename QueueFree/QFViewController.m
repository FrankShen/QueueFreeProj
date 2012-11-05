//
//  QFViewController.m
//  QueueFree
//
//  Created by BuG.BS on 12-10-24.
//  Copyright (c) 2012年 BuG.BS. All rights reserved.
//

#import "QFViewController.h"

#import "CoreData/Restaurant+Plist.h"
#import <CoreData/CoreData.h>

@interface QFViewController ()
@property (weak, nonatomic) IBOutlet UIView *CustomTabBar;

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

@end
