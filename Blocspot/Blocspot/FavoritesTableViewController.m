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

@end

@implementation FavoritesTableViewController

- (id)init {
    if (self) {
        self = [super init];
        self.resultsKeyPath = @"poiFavorites";
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTableData:) name:@"EditedFavoritesNotification" object:[DataSource sharedInstance]];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // enable edit mode of favorites
//    self.tableView.editing = true;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.results = [DataSource sharedInstance].favorites;

//    if (self.results.count > 0) {
//        ((UINavigationController *)self).navigationItem.rightBarButtonItem = self.filterButton;
//    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
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
