//
//  FavoritesTableViewController.m
//  Blocspot
//
//  Created by Waine Tam on 5/15/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "FavoritesTableViewController.h"
#import "DataSource.h"

@interface FavoritesTableViewController ()
@property (nonatomic, strong) UISearchController *searchController;

@end

@implementation FavoritesTableViewController

- (id)init {
    if (self) {
        self = [super init];
        self.resultsKeyPath = @"favorites";
        self.secondResultsKeyPath = @"sortedResults";
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTableData:) name:@"EditedFavoritesNotification" object:[DataSource sharedInstance].favorites];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTableData:) name:@"SortedFavoritesNotification" object:[DataSource sharedInstance].sortedResults];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSArray*) results{
    if ([DataSource sharedInstance].favoritesSortedByCategory == YES) {
        return [DataSource sharedInstance].sortedResults;
    } else {
        return [DataSource sharedInstance].favorites;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self.tableView reloadData];
    
//    self.filteredFavoritesArray = [NSMutableArray arrayWithCapacity:[[self results] count]];
    

//    if ([self results].count > 0) {
//        ((UINavigationController *)self).navigationItem.rightBarButtonItem = self.filterButton;
//    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    // Check to see whether the normal table or search results table is being displayed
//    if (tableView == self.searchController.view) {
//        return [self.filteredFavoritesArray count];
//    } else {
        return [self results].count;
//    }
}

- (ResultsTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"resultCell";
    
    ResultsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[ResultsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    // Configure the cell...
    cell.delegate = self; // set the cell's delegate
    
    // Check to see whether the normal table or search results table is being displayed
//    if (tableView == self.searchController.view) {
//        cell.resultItem = self.filteredFavoritesArray[indexPath.row];
//    } else {
        cell.resultItem = [self results][indexPath.row];
//    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(ResultsTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell.resultItem isFavorited]) {
        [self setImageForTableCell:cell byCategory:cell.resultItem.category];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // If row is deleted, remove it from the list.
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        POI* poiToRemove = [((NSMutableArray *)[self results]) objectAtIndex:[indexPath row]];
        BSCategory* categoryToRemovePoiFrom = poiToRemove.category;
        
        [poiToRemove removeFromCategory:categoryToRemovePoiFrom];
        poiToRemove.category = nil; // also remove from poi instance itself
        [((NSMutableArray *)[self results]) removeObjectAtIndex:[indexPath row]];
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"EditedFavoritesNotification" object:[DataSource sharedInstance].favorites];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"EditedResultsNotification" object:[DataSource sharedInstance]];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SortedFavoritesNotification" object:[DataSource sharedInstance].sortedResults];
        
        
    }
}

- (void)setImageForTableCell:(ResultsTableViewCell *)cell byCategory:(BSCategory *)category {
    // QUESTION: create constant for category names
    UIImage *rowImage = [[BSCategory imageLookupByCategoryName:category.name] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImageView *rowImageView = [[UIImageView alloc] initWithImage:rowImage];
    rowImageView.frame = CGRectMake(0, 0, 35, 35);
    [rowImageView setTintColor:category.color];
    cell.accessoryView = rowImageView;
}

- (void)dealloc {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
