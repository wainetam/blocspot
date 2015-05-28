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
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTableData:) name:@"EditedFavoritesNotification" object:[DataSource sharedInstance]];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // enable edit mode of favorites
//    self.tableView.editing = true;
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
//    self.searchController.delegate = self;
    self.searchController.searchResultsUpdater = self;
    self.searchController.searchBar.delegate = self;
    self.definesPresentationContext = YES;
}

- (NSArray*) results{
    return [DataSource sharedInstance].favorites;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.filteredFavoritesArray = [NSMutableArray arrayWithCapacity:[[self results] count]];
    

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
    if (tableView == self.searchController.view) {
        return [self.filteredFavoritesArray count];
    } else {
        return [self results].count;
    }
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
    if (tableView == self.searchController.view) {
        cell.resultItem = self.filteredFavoritesArray[indexPath.row];
    } else {
        cell.resultItem = [self results][indexPath.row];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(ResultsTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell.resultItem isFavorited]) {
        [self setImageForTableCell:cell byCategory:cell.resultItem.category];
    }
}

- (void)setImageForTableCell:(ResultsTableViewCell *)cell byCategory:(BSCategory *)category {
    // QUESTION: create constant for category names
    UIImage *rowImage = [BSCategory imageLookupByCategoryName:category.name];
//    [cell.imageView setImage:rowImage];
    cell.accessoryView = [[UIImageView alloc] initWithImage:rowImage];
}

- (void)dealloc {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
