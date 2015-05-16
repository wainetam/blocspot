//
//  BSTableViewController.m
//  Blocspot
//
//  Created by Waine Tam on 5/16/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "BSTableViewController.h"
#import "POI.h"
#import "DataSource.h"
#import "User.h"
#import "Search.h"
#import "ResultsTableViewCell.h"
#import "ResultViewController.h"

@interface BSTableViewController ()

@end

@implementation BSTableViewController

- (id)init {
    if (self) {
        self = [super init];
        // set results property
//        self.results = [DataSource sharedInstance].poiResults;
        // set keypath for results
//        self.resultsKeyPath = @"poiResults";
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[DataSource sharedInstance] addObserver:self forKeyPath:self.resultsKeyPath options:0 context:nil];
    
    [self.tableView registerClass:[ResultsTableViewCell class] forCellReuseIdentifier:@"resultCell"];
}

- (void)viewWillAppear:(BOOL)animated {
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.parentViewController.title = self.tabBarController.tabBar.selectedItem.title;
}

- (void)viewWillDisappear:(BOOL)animated {
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
    
    [self.tabBarController.navigationController pushViewController:resultModalVC animated:NO];
    
    [tableView deselectRowAtIndexPath:indexPath animated:false];
    
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
    //    NSLog(@"frame height %f", self.tableView.frame.size.height);
    
    self.tableView.contentInset = UIEdgeInsetsZero;
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    self.tableView.layoutMargins = UIEdgeInsetsZero;
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsZero;
    
    self.tableView.frame = CGRectMake(0, yOffset, width, height - yOffset);
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
    return 65;
    //    POI *resultItem = [DataSource sharedInstance].poiResults[indexPath.row];
    
    //    return [ResultsTableViewCell heightForResultItem:resultItem width:CGRectGetWidth(self.view.frame)];
}

#pragma mark - Handling key-value notifications
// all KVO notifications are sent to this method -- here, just have one key to observe (poiResults)
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == [DataSource sharedInstance] && [keyPath isEqualToString:self.resultsKeyPath]) {
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


@end