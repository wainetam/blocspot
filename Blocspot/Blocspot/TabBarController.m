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
        
        UIImage *listViewTabBarIcon = [UIImage imageNamed:@"list-view-24.png"];
    
        UITabBarItem *listViewBarItem = [[UITabBarItem alloc] initWithTitle:@"List View" image:listViewTabBarIcon selectedImage:nil];
        [resultsVC setTabBarItem:listViewBarItem];
    
        NSArray *tabArray = @[mapVC, resultsVC];
        
        [self setViewControllers:tabArray];
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
}

#pragma mark - SearchDelegate

- (void)didCompleteSearch:(Search *)sender {
    self.selectedIndex = 1; // go to list view!
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
