//
//  TabBarController.m
//  Blocspot
//
//  Created by Waine Tam on 4/21/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "TabBarController.h"
#import "MapViewController.h"
#import "ResultsTableViewController.h"
#import "FavoritesTableViewController.h"
#import "BSCategoryButton.h"
#import "BSCategory.h"
//#import "Search.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (id)init {
    self = [super init];
    if(self) {
        MapViewController *mapVC = [[MapViewController alloc] init];
        
        UIImage *mapViewTabBarIcon = [UIImage imageNamed:@"pin-map-24.png"];
        
        UITabBarItem *mapViewBarItem = [[UITabBarItem alloc] initWithTitle:@"Map View" image:mapViewTabBarIcon selectedImage:nil];
        [mapVC setTabBarItem:mapViewBarItem];
    
        ResultsTableViewController *resultsVC = [[ResultsTableViewController alloc] init];
        
        UIImage *maplistViewTabBarIcon = [UIImage imageNamed:@"list-view-24.png"];
    
        UITabBarItem *maplistViewBarItem = [[UITabBarItem alloc] initWithTitle:@"List View" image:maplistViewTabBarIcon selectedImage:nil];
        [resultsVC setTabBarItem:maplistViewBarItem];
        
        FavoritesTableViewController *favoritesVC = [[FavoritesTableViewController alloc] init];
        
        UIImage *favListViewTabBarIcon = [UIImage imageNamed:@"heart-filled-24.png"];
//         imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal
        
        UITabBarItem *favlistViewBarItem = [[UITabBarItem alloc] initWithTitle:@"All Favorites" image:favListViewTabBarIcon selectedImage:nil];
        
        [favoritesVC setTabBarItem:favlistViewBarItem];
        
    
        NSArray *tabArray = @[mapVC, resultsVC, favoritesVC];
        
        [self setViewControllers:tabArray];
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    
//    MapViewController *mapVC = [[MapViewController alloc] init];
//    
//    UITabBarItem *mapViewBarItem = [[UITabBarItem alloc] initWithTitle:@"Map View" image:nil selectedImage:nil];
//    [mapVC setTabBarItem:mapViewBarItem];
//    
//    ResultsTableViewController *resultsVC = [[ResultsTableViewController alloc] init];
//    
//    UITabBarItem *listViewBarItem = [[UITabBarItem alloc] initWithTitle:@"List View" image:nil selectedImage:nil];
//    [resultsVC setTabBarItem:listViewBarItem];
//    
//    NSArray *tabArray = @[mapVC, resultsVC];
//    
//    
//    
//    [self setViewControllers:tabArray];
    
//    self.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    NSUInteger indexOfTab = [tabBarController.viewControllers indexOfObject:viewController];
    NSLog(@"Tab index = %lu", indexOfTab);
    
    if (indexOfTab == 2 && [((FavoritesTableViewController *)viewController) results].count > 0) { // favorites
        [self createFilterButton];
    }
}

#pragma mark - Filter Button

- (void)createFilterButton {
    UIImage *filterImage = [UIImage imageNamed:@"filter-24.png"];
    
    self.filterButton = [[UIBarButtonItem alloc] initWithImage:filterImage style:UIBarButtonItemStyleDone target:self action:@selector(showFilterModal:)];
    
    self.navigationItem.rightBarButtonItem = self.filterButton;
}

- (void)showFilterModal:(id)sender {
    BSCategoryFilterViewController* filterVC = [[BSCategoryFilterViewController alloc] init];
    filterVC.delegate = self;
    [self presentViewController:filterVC animated:YES completion:^{
        [self.filterButton setEnabled:NO];
        NSLog(@"filter modal should appear");
    }];
}

#pragma mark - SearchDelegate

- (void)didCompleteSearch:(Search *)sender {
    self.selectedIndex = 1; // go to list view!
}

#pragma mark - EditFavoriteDelegate

- (void)didCompleteEditFavorite:(id)sender {
    self.selectedIndex = 2; // go to favorite view!
}

#pragma mark - FilterDelegate

- (void)didFilterByCategory:(BSCategory *)category {
    [self.filterButton setEnabled:YES];
    [((FavoritesTableViewController *)self.selectedViewController).tableView reloadData];
    NSString *currentTitle = @"Favorites";
    NSString *newTitle = [currentTitle stringByAppendingString:@": "];
    NSString *filteredByCategoryName = [[category.name capitalizedString] stringByAppendingString:@"s"];
    self.title = [newTitle stringByAppendingString:filteredByCategoryName];
}

- (void)didClearFilter {
    [((FavoritesTableViewController *)self.selectedViewController).tableView reloadData];
    [self.filterButton setEnabled:YES];
    self.title = @"All Favorites";
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
