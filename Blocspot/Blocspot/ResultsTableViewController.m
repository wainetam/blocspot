//
//  ResultsTableViewController.m
//  Blocspot
//
//  Created by Waine Tam on 4/12/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "ResultsTableViewController.h"
#import "POI.h"
#import "DataSource.h"
#import "User.h"
#import "Search.h"
#import "ResultsTableViewCell.h"
#import "ResultViewController.h"

@interface ResultsTableViewController ()

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) MKLocalSearch *localSearch;
@property (nonatomic) CGFloat savedContentOffsetY;

@end

@implementation ResultsTableViewController

- (id)init {
    if (self) {
        self = [super init];
        self.results = [DataSource sharedInstance].poiResults;
    }
    
    return self;
}

- (void)viewDidLoad {
    NSLog(@"contentOffsetY VDL1 %f", self.tableView.contentOffset.y);
    [super viewDidLoad];
    
    [[DataSource sharedInstance] addObserver:self forKeyPath:@"poiResults" options:0 context:nil];
//    [[DataSource sharedInstance] addObserver:self forKeyPath:@"searchHistoryItems" options:0 context:nil];
    
//    self.refreshControl = [[UIRefreshControl alloc] init];
//    [self.refreshControl addTarget:self action:@selector(refreshControlDidFire:) forControlEvents:UIControlEventValueChanged];
    
//    self.searchBar = [[UISearchBar alloc] init];
//    self.searchBar.placeholder = @"Search for places";
//    self.searchBar.showsCancelButton = YES;
    
    [self.tableView registerClass:[ResultsTableViewCell class] forCellReuseIdentifier:@"resultCell"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

//    NSLog(@"contentOffsetY VDL2 %f", self.tableView.contentOffset.y);
    self.savedContentOffsetY = self.tableView.contentOffset.y;
//    NSLog(@"contentOffsetY VDL3 %f", self.tableView.contentOffset.y);
}

- (void)viewWillAppear:(BOOL)animated {
//    NSLog(@"contentOffsetY VWA1 %f", self.tableView.contentOffset.y);
//    [self performSelector:@selector(updateContentOffset) withObject:nil afterDelay:1.0];
    self.tableView.contentOffset = CGPointMake(0, self.savedContentOffsetY);
//    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, -64, 0);
//    NSLog(@"contentOffsetY VWA2 %f", self.tableView.contentOffset.y);
}

- (void)viewDidAppear:(BOOL)animated {
//    NSLog(@"contentOffsetY VDA %f", self.savedContentOffsetY);
    [super viewDidAppear:animated];
    [self.tableView setContentOffset: CGPointMake(0, self.savedContentOffsetY) animated:NO];
    self.parentViewController.title = @"Points of Interest";
}

- (void)viewWillDisappear:(BOOL)animated {
//    NSLog(@"contentOffsetY VWD %f", self.tableView.contentOffset.y);
//    self.savedContentOffsetY = self.tableView.contentOffset.y;
}

- (void)dealloc { // removes observer upon dealloc
//    [[DataSource sharedInstance] removeObserver:self forKeyPath:@"poiResults"];
    
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    ResultsTableViewCell *cell = (ResultsTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    ResultViewController *resultModalVC = [[ResultViewController alloc] initWithTableViewCell:cell];

    [self.tabBarController.navigationController pushViewController:resultModalVC animated:true];
    
//    self.navigationController.navigationBarHidden = YES;
    
//    CATransition *transition = [CATransition animation];
//    transition.duration = 0.4;
//    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    transition.type = kCATransitionPush;
//    transition.subtype = kCATransitionFromRight;
//    [self.view.window.layer addAnimation:transition forKey:nil];
//    [self presentViewController:resultModalVC animated:NO completion:nil];
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(ResultsTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    POI *poi = [DataSource sharedInstance].poiResults[indexPath.row];
//    cell.resultItem = poi;
    
    // TBD
//    if (mediaItem.downloadState == MediaDownloadStateNeedsImage) {
//        
//        if (self.tableView.decelerationRate != 0) {
//            //            NSLog(@"tableview deceleration rate %f", self.tableView.decelerationRate);
//            [[DataSource sharedInstance] downloadImageForMediaItem:mediaItem];
//        }
//    }
}

#pragma mark - Layout

- (void)viewWillLayoutSubviews {

    [super viewWillLayoutSubviews];

    
    CGFloat width = CGRectGetWidth(self.tableView.bounds);
    CGFloat height = self.tabBarController.tabBar.frame.origin.y;
    
    CGFloat heightOfNavBar = self.tabBarController.navigationController.navigationBar.frame.size.height;
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    
    CGFloat yOffset = heightOfNavBar + statusBarHeight;
    // window --> nav --> tabBar --> ResultViewController (top)
//                            l
//                            l
//                            v
//                            mapview & tableview
//    UIView* view = self.view;
//    UIView* superview = self.view.superview.superview;
    NSLog(@"frame origin %f", self.tableView.frame.origin.y);
    
//    if (self.tableView.frame.origin.y != yOffset){
//
        NSLog(@"self.savedContentOffsetY %f", self.savedContentOffsetY);
//        NSLog(@"Results tableview controller: heightOfNavBar %f", heightOfNavBar);
    

    self.tableView.frame = CGRectMake(0, yOffset, width, height - yOffset);

//        self.tableView.contentOffset = CGPointMake(0,self.savedContentOffsetY);
//    }

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [DataSource sharedInstance].poiResults.count;
    
}

- (ResultsTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"resultCell";
    
    ResultsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[ResultsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    // Configure the cell...
    cell.delegate = self; // set the cell's delegate
    cell.resultItem = [DataSource sharedInstance].poiResults[indexPath.row];

    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
//    POI *resultItem = [DataSource sharedInstance].poiResults[indexPath.row];
    
//    return [ResultsTableViewCell heightForResultItem:resultItem width:CGRectGetWidth(self.view.frame)];
}

#pragma mark - Handling key-value notifications
// all KVO notifications are sent to this method -- here, just have one key to observe (poiResults)
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == [DataSource sharedInstance] && [keyPath isEqualToString:@"poiResults"]) {
        // we know poiResults has changed. Let's see what kind of change it is
        int kindOfChange = [change[NSKeyValueChangeKindKey] intValue];
        
        if (kindOfChange == NSKeyValueChangeSetting) {
            // changed list of poiResults
            [self.tableView reloadData];
        } else if (kindOfChange == NSKeyValueChangeInsertion || kindOfChange == NSKeyValueChangeRemoval || kindOfChange == NSKeyValueChangeReplacement) {
            // we have an incremental change: insertion, deletion, or replaced items
            
            // get a list of the index (or indices) that changed
            NSIndexSet *indexSetOfChanges = change[NSKeyValueChangeIndexesKey];
            
            // convert this NSIndexSet to an NSArray of NSIndexPath (which is what the table view animation methods require)
            NSMutableArray *indexPathsThatChanged = [NSMutableArray array];
            [indexSetOfChanges enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
                NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:idx inSection:0];
                [indexPathsThatChanged addObject:newIndexPath];
            }];
            
            // call beginUpdates to tell the tableView that we're about to make changes
            [self.tableView beginUpdates];
            
            // tell the tableView what the changes are
            if (kindOfChange == NSKeyValueChangeInsertion) {
                [self.tableView insertRowsAtIndexPaths:indexPathsThatChanged withRowAnimation:UITableViewRowAnimationAutomatic];
            } else if (kindOfChange == NSKeyValueChangeRemoval) {
                [self.tableView deleteRowsAtIndexPaths:indexPathsThatChanged withRowAnimation:UITableViewRowAnimationAutomatic];
            } else if (kindOfChange == NSKeyValueChangeReplacement) {
                [self.tableView reloadRowsAtIndexPaths:indexPathsThatChanged withRowAnimation:UITableViewRowAnimationAutomatic];
            }
            
            // tell the tableView that we're done telling it about changes, and to complete the animation
            [self.tableView endUpdates];
        }
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
