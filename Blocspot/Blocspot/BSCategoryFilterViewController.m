//
//  BSCategoryFilterViewController.m
//  Blocspot
//
//  Created by Waine Tam on 5/27/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "BSCategoryFilterViewController.h"
#import "BSCategory.h"
#import "BSCategoryButton.h"
#import "DataSource.h"
#import "TabBarController.h"
#import "FavoritesTableViewController.h"


@interface BSCategoryFilterViewController ()

@end

@implementation BSCategoryFilterViewController

- (id)init {
    self = [super init];
    
    if (self) {
//        self.delegate = (FavoritesTableViewController *)self.presentingViewController;
        // QUESTION how to assign delegate if none exists?
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void) viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)cancelModal:(id)sender {
//    [((TabBarController *)((FavoritesTableViewController *)self.presentingViewController).tabBarController).filterButton setEnabled:YES];
    
    [super cancelModal:sender];
    
    [((TabBarController *)self.delegate).filterButton setEnabled:YES];

}

- (void)filterByHandler:(id)sender {
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
        [self.delegate didSelectCategoryFilter:sender];
        //        [[NSNotificationCenter defaultCenter] postNotificationName:@"EditedResultViewNotification" object:self];
    }];
}

#pragma mark - CategoryButtonHandler

- (void) categoryButtonHandler:(BSCategoryButton *)sender {
    [[DataSource sharedInstance] sortResults: [DataSource sharedInstance].favorites byCategory:sender.category completion:^{
        [self dismissViewControllerAnimated:YES completion:^{

//            [((FavoritesTableViewController *)self.presentingViewController).tableView reloadData];
        }];
    }];
}

@end
